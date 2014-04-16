//
//  Transfer+FSK.m
//  POS2iPhone
//
//  Created by  STH on 1/16/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "Transfer+FSK.h"
#import "NSObject+MutPerformSel.h"
#import "StringUtil.h"
#import "DateUtil.h"
#import "Transfer+Action.h"
#import "AppDataCenter.h"
#import "ConfirmCancelResultViewController.h"

@implementation Transfer (FSK)

- (void) initFSK
{
    NSLog(@"Init Transfer FSK ...");
    // 初始化对象
    self.m_vcom = [vcom getInstance];
    [self.m_vcom open];
    
    self.m_vcom.eventListener = self;
    [self.m_vcom setMode:VCOM_TYPE_FSK recvMode:VCOM_TYPE_F2F];
    [self.m_vcom setVloumn:75];
    
    self.fskCmdArray = [[NSMutableArray alloc] init];
}

- (void) fskAction
{
    self.fskCmdArray = [NSMutableArray arrayWithArray:[self.fskCommand componentsSeparatedByString:@"#"]];
    
    [self.m_vcom StartRec];
    
    //[self.m_vcom StopRec];
    
    [self runFSKCmd];
    
    //[self.m_vcom StartRec];
}

- (void) runFSKCmd
{
    @try {
        if ([self.fskCmdArray count] > 0) {

            NSString *cmd = [self.fskCmdArray objectAtIndex:0];
            
            [self performSelectorOnMainThread:@selector(showFSKProgress) withObject:nil waitUntilDone:NO];
            
            [self invokeFSKCmd:cmd];
            
            [self.fskCmdArray removeObjectAtIndex:0];
            
        } else {
            [ApplicationDelegate hideProcess];
            
            if (self.tempTransferCode && self.transferCode) {
                [self packet];
            }
            if(self.nextViewController){
                [[ApplicationDelegate topViewController].navigationController pushViewController:self.nextViewController animated:YES];
                
                self.nextViewController = nil;
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
    }
}

- (void) invokeFSKCmd:(NSString *) cmd
{
    NSArray *argsArray = nil;
    
    NSArray *fieldArray = [cmd componentsSeparatedByString:@"|"];
    if ([fieldArray count] == 2) {
        argsArray = [self parseArgs:[fieldArray objectAtIndex:1]];
    }
    
    self.currentFSKMethod = [self getRealMethod:[fieldArray objectAtIndex:0]];
    
    @try {
        SEL selector = NSSelectorFromString(self.currentFSKMethod);
        
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];//获得类和方法的签名
        // 从签名获得调用对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self]; // 设置target
        [invocation setSelector:selector];// 设置selector
        
        if (argsArray == nil || [argsArray count] == 0) {
            
        } else {
            int i = 2;
            for (__strong NSObject *obj in argsArray) {
                [invocation setArgument:&obj atIndex:i++];
            }
        }
        
        // NSInvocation 默认不会对参数进行retain动作的。 就是这个特殊，备记！
        [invocation retainArguments];
        
        [invocation invoke]; //调用
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
    }
}

- (NSArray *) parseArgs:(NSString *) argsStr
{
    argsStr = [argsStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (argsStr == nil || [argsStr isEqualToString:@""] || [argsStr isEqualToString:@"null"] || [argsStr isEqualToString:@"nil"]) {
        return nil;
    }
    
    NSMutableArray *argValueArray = [[NSMutableArray alloc] init];
    
    NSArray *argArray = [argsStr componentsSeparatedByString:@","];
    for (NSString *arg in argArray) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[arg componentsSeparatedByString:@":"]];
        if ([[temp objectAtIndex:1] hasPrefix:@"__"]) {
            [temp addObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:[temp objectAtIndex:1]]];
            [temp removeObjectAtIndex:0];
        }
        
        NSString *type = [[temp objectAtIndex:0] lowercaseString];
        NSString *value = [temp objectAtIndex:1];
        if ([type isEqualToString:@"int"] || [type isEqualToString:@"integer"]) {
            [argValueArray addObject:[NSNumber numberWithInt:[value intValue]]];
        } else if ([type isEqualToString:@"string"]){
            [argValueArray addObject:value?value:@""];
        } else if ([type isEqualToString:@"bool"] || [type isEqualToString:@"boolean"]){
            [argValueArray addObject:[NSNumber numberWithBool:[value boolValue]]];
        }
        
    }
    
    return argValueArray;
}

#pragma mark - CSwiperStateChangedListener

//通知监听器刷卡器插入手机
-(void) onDevicePlugged
{
    NSLog(@"点付宝：刷卡器插入手机");
    [ApplicationDelegate showSuccessPrompt:@"刷卡器插入手机"];
}

//通知监听器刷卡器已从手机拔出
-(void) onDeviceUnPlugged
{
    NSLog(@"点付宝：刷卡器已从手机拔出");
    [ApplicationDelegate showSuccessPrompt:@"刷卡器已从手机拔出"];
}

//通知监听器控制器CSwiperController的操作被中断
-(void)onInterrupted
{
    NSLog(@"点付宝：操作被中断");
    [ApplicationDelegate showErrorPrompt:@"操作被中断"];
}

//通知监听器控制器CSwiperController的操作超时
//(超出预定的操作时间，30秒)
-(void)onTimeout
{
    NSLog(@"点付宝：超出预定的操作时间，30秒");
    [ApplicationDelegate showErrorPrompt:@"操作超时"];
}

-(void)onDeviceReady
{
    NSLog(@"onDeviceReady...");
}

-(void)onDecodeCompleted:(NSString*) formatID
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
            andMaskedPAN:(NSString*) maskedPAN
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName
{
    //log4Debug(@"Return data on Decode completed");
}
//mic插入
-(void) onMicInOut:(int) inout
{
    //log4Debug(@"mic insert");
}
//解析艾刷返回的数据信息的实现
-(void)secondReturnDataFromAiShua
{
    NSLog(@"Second Return Data From AiShua");
    //log4Debug(@"Second Return Data From AiShua");
}
//通知监听器控制器CSwiperController正在搜索刷卡器
-(void) onWaitingForDevice
{
    //log4Debug(@"Notify Morniting Searching Swiping Device");
}

//通知监听器没有刷卡器硬件设备
-(void)onNoDeviceDetected
{
    //log4Debug(@"Notify Morniting No Swiping Device");
}

//通知监听器可以进行刷卡动作
-(void)onWaitingForCardSwipeForAiShua
{
    //log4Debug(@"Slide Card For AiShua");
}
// 通知监听器检测到刷卡动作
-(void)onCardSwipeDetected
{
    //log4Debug(@"moniting sliping device");
}

//通知监听器开始解析或读取卡号、磁道等相关信息
-(void)onDecodingStart
{
    //log4Debug(@"Notify morniting, starting praser or read card no, track etc info");
}

-(void)onError:(int)errorCode andMsg:(NSString*)errorMsg
{
    NSLog(@"error %@",errorMsg);
    //log4ErrorWithException(@"error %@", errorMsg);
}

//收到数据
-(void) dataArrive:(vcom_Result*) vs  Status:(int) status
{
    if (status == -3) {
        NSLog(@"点付宝：设备超时，无应答！");
        [ApplicationDelegate hideProcess];
        [ApplicationDelegate showErrorPrompt:@"设备响应超时,请重试！"];
        
    } else if(status == -2) {
        NSLog(@"点付宝：设备没有连接手机！");
        [ApplicationDelegate hideProcess];
        [ApplicationDelegate showErrorPrompt:@"设备没有连接手机！"];
        
    } else if(status == -1) {
        NSLog(@"点付宝：接收数据格式错误！");
        [ApplicationDelegate hideProcess];
        [ApplicationDelegate showErrorPrompt:@"接收数据格式错误！"];
        
    } else if(vs != 0){
        if (vs->res == 0) {
            // 指令操作正确
            [self setFSKArgs:vs]; // 设置可能的参数
            //[self fskActionDone]; // 执行可能的方法
            
            [self performSelectorOnMainThread:@selector(fskActionDone) withObject:nil waitUntilDone:NO];
            
            // 执行下一个方法
            [self runFSKCmd];
            
        } else if(vs->res == 0x40 || vs->res == 0x41 || vs->res == 0x42 || vs->res == 0x43 || vs->res == 0x44 || vs->res == 0x45){
            
            // 这样写可能不是很好，如果有需要请优化实现方式！
            [(ConfirmCancelResultViewController *)ApplicationDelegate.topViewController repeatPrint:[self getErrorMsg:vs->res]];
            
        } else if(vs->res == 0x0B){
            // MAC校验失败
            if ([[[AppDataCenter sharedAppDataCenter] reversalDic] objectForKey:self.transferCode]){
                NSLog(@"MAC 校验失败,发起冲正");
                [ApplicationDelegate gotoFailureViewController:@"校验服务器响应数据失败"];
                [self reversalAction];
            } else {
                [ApplicationDelegate gotoFailureViewController:@"校验服务器响应数据失败，请重新交易"];
            }
            
        } else {
            // 查询余额显示余额信息时，虽然操作正确，但是现在的库没有对vs=0,而是返回80异常。所以特殊处理之
            NSString *errorMsg = [self getErrorMsg:vs->res];
            if (errorMsg && ![errorMsg isEqualToString:@""]) {
                NSLog(@"点付宝：%@", errorMsg);
                [ApplicationDelegate hideProcess];
                [ApplicationDelegate showErrorPrompt:errorMsg];
            }
        }
    }
}

#pragma mark -
- (void) fskActionDone
{
    if ([self.currentFSKMethod isEqualToString:@"Request_ReNewKey:MacKey:DesKey:"]) {
        [self updateWorkingKeyDone];
    } else if ([self.currentFSKMethod isEqualToString:@"Request_GetMac:"]){
        [self.sendDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PSAMMAC"] forKey:@"fieldMAC"];
        [self sendPacket];
    } else if ([self.currentFSKMethod isEqualToString:@"Request_CheckMac:macValue:"]){
        // MAC校验成功后检查39域
        [self checkField39];
    }
}

- (void) setFSKArgs:(vcom_Result *) vs
{
    @try {
        // psam卡号
        if (vs->psamnoLen > 0) {
            [AppDataCenter sharedAppDataCenter].__PSAMNO = [StringUtil ASCII2Hex:[self.m_vcom HexValue:vs->psamno Len:vs->psamnoLen]];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PSAMNO);
        }
        
        // 设备号
        if (vs->hardSerialNoLen > 0) {
            [AppDataCenter sharedAppDataCenter].__TERSERIALNO = [self.m_vcom HexValue:vs->hardSerialNo Len:vs->hardSerialNoLen];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__TERSERIALNO);
            
            // 以001917开头的是打印设备，以001911开头的是不带打印的点付宝设备
            if ([[AppDataCenter sharedAppDataCenter].__TERSERIALNO hasPrefix:@"001917"]) {
            //if ([[AppDataCenter sharedAppDataCenter].__TERSERIALNO hasPrefix:@"001903"]) {
                NSLog(@"*******是打印设备*******");
                [ApplicationDelegate setPrintVersion:YES];
                
            } else {
                NSLog(@"*******非打印设备*******");
                [ApplicationDelegate setPrintVersion:NO];
            }
            
            /***
            NSArray *deviceIDArray = [UserDefaults stringArrayForKey:DEVICEID];
            if (deviceIDArray && [deviceIDArray containsObject:[[AppDataCenter sharedAppDataCenter].__TERSERIALNO substringFromIndex:13]]) {
                NSLog(@"*******非打印设备*******");
                [ApplicationDelegate setPrintVersion:NO];
                
            } else {
                NSLog(@"*******是打印设备*******");
                [ApplicationDelegate setPrintVersion:YES];
            }
             ***/
        }
        
        // pan
        if (vs->panLen > 0) {
            [AppDataCenter sharedAppDataCenter].__PAN = [self.m_vcom HexValue:vs->pan Len:vs->panLen];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PAN);
        }
        
        // 商户号
        if (vs->traderNoInPsamLen > 0) {
            [AppDataCenter sharedAppDataCenter].__VENDOR = [StringUtil ASCII2Hex:[NSString stringWithCString:BinToHex(vs->traderNoInPsam, 0, vs->traderNoInPsamLen) encoding:NSASCIIStringEncoding]];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__VENDOR);
        }
        
        // 终端号
        if (vs->termialNoInPsamLen > 0) {
            [AppDataCenter sharedAppDataCenter].__TERID = [StringUtil ASCII2Hex:[NSString stringWithCString:BinToHex(vs->termialNoInPsam, 0, vs->termialNoInPsamLen) encoding:NSASCIIStringEncoding]];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__TERID);
        }
        
        // 卡号明文
        if (vs->cardPlaintextLen > 0) {
            [AppDataCenter sharedAppDataCenter].__CARDNO = [StringUtil ASCII2Hex:[NSString stringWithCString:BinToHex(vs->cardPlaintext, 0, vs->cardPlaintextLen) encoding:NSASCIIStringEncoding]];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__CARDNO);
        }
        
        // 磁道密文
        if (vs->trackEncryptionLen > 0) {
            [AppDataCenter sharedAppDataCenter].__PSAMTRACK = [[self.m_vcom HexValue:vs->trackEncryption Len:vs->trackEncryptionLen] uppercaseString];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PSAMTRACK);
        }
        
        // 密码密文
        if (vs->pinEncryptionLen > 0) {
            [AppDataCenter sharedAppDataCenter].__PSAMPIN = [[self.m_vcom HexValue:vs->pinEncryption Len:vs->pinEncryptionLen] uppercaseString];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PSAMPIN);
            NSLog(@"客户输入了密码。。。");
            
            // 如果交易输入了密码，取值为：021，如果未输入密码，取值为：022
            [AppDataCenter sharedAppDataCenter].__FIELD22 = @"021";
            
        } else if (vs->pinEncryptionLen == 0) {// 信用卡有可能不用输入密码，密码返回空。
            [AppDataCenter sharedAppDataCenter].__PSAMPIN = [[self.m_vcom HexValue:vs->pinEncryption Len:vs->pinEncryptionLen] uppercaseString];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PSAMPIN);
            NSLog(@"客户没有输入密码。。。");
            
            // 如果交易输入了密码，取值为：021，如果未输入密码，取值为：022
            [AppDataCenter sharedAppDataCenter].__FIELD22 = @"022";
            
        }
        
        // mac
        if (vs->macresLen > 0) {
            [AppDataCenter sharedAppDataCenter].__PSAMMAC = [StringUtil ASCII2Hex:[self.m_vcom HexValue:vs->macres Len:vs->macresLen]];
            NSLog(@"App Data:%@", [AppDataCenter sharedAppDataCenter].__PSAMMAC);
        }
        
        if (vs->macres) {
            NSLog(@"MAC 校验成功 !");
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
    }
}

- (NSString *) getErrorMsg:(int) result
{
    // 当应答结果不是00或者FX时，表示PSAM卡操作失败
    switch (result) {
        case  0x01:
            return @"执行命令超时";
        case  0x02:
            return @"PSAM卡认证失败";
        case  0x03:
            return @"PSAM卡上电失败或者不存在";
        case  0x04:
            //return @"PSAM卡操作失败,您有可能没有签到";
            return @"PSAM卡操作失败";
        case  0x0A:
            return @"用户取消操作";
        case  0x0B:
            return @"MAC校验失败";
        case  0x0C:
            return @"终端加密失败";
        case  0x0F:
            return @"PSAM卡状态异常";
        case  0x20:
            return @"不匹配的主命令码";
        case  0x21:
            return @"不匹配的子命令码";
        case  0x50:
            return @"获取电池电量失败";
        case  0x80:
//            return @"数据接收正确";
            return nil;
        case  0xE0:
            return @"重传数据无效";
        case  0xE1:
            return @"终端设置待机信息失败";
            
            // 如果为FX的话，表示下行(即手机至密键)数据格式错误
        case  0xF0:
            return @"不识别的包头";
        case  0xF1:
            return @"不识别的主命令码";
        case  0xF2:
            return @"不识别的子命令码";
        case  0xF3:
            return @"该版本不支持此指令";
        case  0xF4:
            return @"随机数长度错误";
        case  0xF5:
            return @"不支持的部件";
        case  0xF6:
            return @"不支持的模式";
        case  0xF7:
            return @"数据域长度错误";
        case  0xFC:
            return @"数据域内容有误";
        case  0xFD:
            return @"终端ID错误";
        case  0xFE:
            return @"MAC_TK校验失败";
        case  0xFF:
            return @"校验和错误";
            
            // 打印机故障
        case 0x40:
            return @"打印机缺纸";
        case 0x41:
            return @"打印机离线";
        case 0x42:
            return @"没有打印机";
        case 0x43:
            return @"打印机故障：没有黑标";
        case 0x44:
            return @"打印机关闭";
        case 0x45:
            return @"打印机故障";
            
            
        default:
            return @"未知错误！！！";
    }
}

- (void) showFSKProgress
{
    [ApplicationDelegate showProcess:[self getWaittingMessage:self.currentFSKMethod]];
}

- (NSString *) getWaittingMessage:(NSString *) methodName
{
    if ([methodName isEqualToString:@"Request_GetExtKsn"]) {
        return @"正在读取终端信息...";
    } else if([methodName isEqualToString:@"Request_VT"]) {
        return @"正在读取商户信息...";
    } else if ([methodName isEqualToString:@"Request_GetMac:"]) {
        return @"正在加密发送报文...";
    } else if ([methodName isEqualToString:@"Request_CheckMac:macValue:"]) {
        return @"正在校验响应报文...";
    } else if ([methodName isEqualToString:@"Request_ReNewKey:MacKey:DesKey:"]) {
        return @"正在更新工作密钥...";
    } else if ([methodName isEqualToString:@"Request_GetDes"]) {
        return @"请用户刷卡并按[确认]键";
    } else if ([methodName isEqualToString:@"Request_GetPin:"]) {
        return @"请用户输入密码并按[确认]键";
    } else if ([methodName isEqualToString:@"Print"]) {
        return @"正在打印凭条，请稍候...";
    } else {
        return @"正在操作设备，请保持连接...";
    }
}

// 为了书写方便，不产生歧义
- (NSString *) getRealMethod:(NSString *) methodName
{
    if ([methodName isEqualToString:@"Request_GetPin"]) {
        return @"Request_GetPin:";
    } else if([methodName isEqualToString:@"Request_GetMac"]) {
        return @"Request_GetMac:";
    } else if ([methodName isEqualToString:@"Request_CheckMac"]) {
        return @"Request_CheckMac:macValue:";
    } else if ([methodName isEqualToString:@"Request_ReNewKey"]) {
        return @"Request_ReNewKey:MacKey:DesKey:";
    } else if([methodName isEqualToString:@"Request_ReNewVT"]) {
        return @"Request_ReNewVT:terid:";
    } else if([methodName isEqualToString:@"Display"]) {
        return @"Display:";
    }
    
    return methodName;
}

#pragma mark -

// 带中文的必须用strlen，其它的可以使用[@"" length]

// 获取ksn
- (void) Request_GetKsn
{
    NSLog(@"点付宝：获取ksn");
//    [self.m_vcom Request_GetKsn];
    
    //demo中提供的方法
    [self.m_vcom setMode:VCOM_TYPE_F2F recvMode:VCOM_TYPE_F2F];
    [self.m_vcom StopRec];
    [self.m_vcom Request_GetKsn];
    [self.m_vcom StartRec];
}

// 扩展获取ksn     Get_PsamNo
-(void) Request_GetExtKsn
{
    NSLog(@"点付宝：获取扩展ksn");
    [self.m_vcom Request_GetExtKsn];
}

// 获取psam卡上保存的商户号码和终端号    Get_VendorTerID
-(void) Request_VT
{
    NSLog(@"点付宝：获取商户号和终端号");
    [self.m_vcom Request_VT];
}

// 获取磁道密文数据       Get_EncTrack
-(void) Request_GetDes
{
    NSLog(@"点付宝：获取磁道密文数据");
    [self.m_vcom Request_GetDes:0 keyIndex:2 random:[StringUtil string2char:@""] randomLen:0 time:60];
}

// 获取pin密文数据
-(void) Request_GetPin:(NSString *) cash  
{
    NSLog(@"点付宝:获取pin密文数据");
    NSString *pan = [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PAN"];
    
    [self.m_vcom Request_GetPin:0 keyIndex:0 cash:[StringUtil string2char:cash] cashLen:[cash length] random:[StringUtil string2char:@""] randomLen:0 panData:HexToBin([StringUtil string2char:pan]) pandDataLen:8 time:60];
}

// 计算mac
-(void) Request_GetMac:(NSString *) data
{
    NSLog(@"点付宝:计算MAC");
    [self.m_vcom Request_GetMac:0 keyIndex:1 random:[StringUtil string2char:@""] randomLen:0 data:[StringUtil string2char:data] dataLen:strlen([StringUtil string2char:data])];
}

// 校验MAC
-(void) Request_CheckMac:(NSString *) mab macValue:(NSString *) mac
{
    @try {
        NSLog(@"点付宝:校验MAC");
        
        // 点付宝加密的mac是16位长的,校验MAC也是用的16进制，是16进制表示的,如 3630443043323435
        // 而后台返回的是8位的char.如 60D0C245
        // 所以先将后台返回数据做一个转换
        
        NSString *macStr = nil;
        if ([mac length] != 8) {
            macStr = [StringUtil ASCII2Hex:mac];
        } else {
            macStr = [NSString stringWithString:mac];
        }
        
        char *cmab = [StringUtil string2char:mab];
        char *cmac = [StringUtil string2char:macStr];
//        char *ctemp = new char[strlen(cmab) + strlen(cmac) + 1];
//        strcpy(ctemp, cmab);
//        strcat(ctemp, cmac);
        
//        [self.m_vcom Request_CheckMacEx:0 keyIndex:1 random:[self string2char:@""] randomLen:0 data:ctemp dataLen:strlen(ctemp)];
        
        [self.m_vcom Request_CheckMac2:0 keyIndex:1 random:[StringUtil string2char:@""] randomLen:0 data:cmab dataLen:strlen(cmab) mac:cmac maclen:strlen(cmac)];
    }
    @catch (NSException *exception) {
        NSLog(@"---%@", exception);
        NSLog(@"---%@", [exception callStackSymbols]);
    }
}

// 更新工作密钥
-(void) Request_ReNewKey:(NSString *)pinKey MacKey:(NSString *) macKey DesKey:(NSString *) desKey
{
    NSLog(@"点付宝:更新工作密钥");
    
    char *pintemp = HexToBin([StringUtil string2char:pinKey]);
    char *pin = new char[100];
    strcpy(pin, pintemp);
    
    char *mactemp = HexToBin([StringUtil string2char:macKey]);
    char *mac = new char[100];
    strcpy(mac, mactemp);
    
    char *destemp = HexToBin([StringUtil string2char:desKey]);
    char *des = new char[100];
    strcpy(des, destemp);
    
    [self.m_vcom Request_ReNewKey:0 PinKey:pin PinKeyLen:20 MacKey:mac MacKeyLen:12 DesKey:des DesKeyLen:20];
}

// 更新终端号码和商户号
-(void) Request_ReNewVT:(NSString *) vendor terid:(NSString *) terid
{
    NSLog(@"点付宝:更新终端号码和商户号");
    [self.m_vcom Request_ReNewVT:[StringUtil string2char:vendor] vendorLen:[vendor length] terid:[StringUtil string2char:terid] teridLen:[terid length]];
}

// 显示数据
-(void) Display:(NSString *) info
{
    NSLog(@"点付宝:显示数据");
    [self.m_vcom display:info timer:30];
}

- (void) Print
{
    /**
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *temp = [str componentsSeparatedByString:@";"];
    for (NSString *str in temp) {
        NSArray *field = [str componentsSeparatedByString:@"="];
        if ([field count] == 2) {
            [dic setObject:[field objectAtIndex:1] forKey:[field objectAtIndex:0]];
        } else {
            [dic setObject:@"" forKey:[field objectAtIndex:0]];
        }
    }
     ***/
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[Transfer sharedTransfer].receDic];
    
    NSMutableArray* array=[[NSMutableArray alloc] init];
    
    /***
    [array addObject:[NSString stringWithFormat:@"11    商户名称：%@\n商户存根            请妥善保管\n", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__MERCHERNAME"]]];
    [array addObject:[NSString stringWithFormat:@"12    商户名称：%@\n持卡人存根          请妥善保管\n", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__MERCHERNAME"]]];
    [array addObject:[NSString stringWithFormat:@"00商户编号（MERCHAANT NO） %@", [dic objectForKey:@"field42"]]];
    [array addObject:[NSString stringWithFormat:@"00终端编号（TERMINAL NO） %@", [dic objectForKey:@"field41"]]];
    [array addObject:[NSString stringWithFormat:@"00发卡行 (BANK NAME)  %@", [dic objectForKey:@"issuerBank"]]];
    [array addObject:@"00卡号（CARD NO）"];
    [array addObject:[NSString stringWithFormat:@"00    %@", [StringUtil formatAccountNo:[dic objectForKey:@"field2"]]]];
    [array addObject:@"00交易类型（TRANS TYPE）"];
    [array addObject:[NSString stringWithFormat:@"00          %@", [[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[[Transfer sharedTransfer].receDic objectForKey:@"fieldTrancode"]]]];
    [array addObject:@"00交易时间（DATE/TIME）"];
    [array addObject:[NSString stringWithFormat:@"00    %@", [DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [dic objectForKey:@"field13"],[dic objectForKey:@"field12"]]]]];
    [array addObject:@"00交易金额（RMB）"];
    [array addObject:[NSString stringWithFormat:@"00    %@", [StringUtil string2SymbolAmount:[dic objectForKey:@"field4"]]]];
    [array addObject:[NSString stringWithFormat:@"00参考号（REFERENCE NO）%@", [dic objectForKey:@"field37"]]];
    [array addObject:[NSString stringWithFormat:@"00批次号 (BATCH NO) %@", [[dic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)]]];
    [array addObject:[NSString stringWithFormat:@"00流水号 (SERIAL NO) %@", [dic objectForKey:@"field11"]]];
    [array addObject:@"00备注（REFERENCE）:"];
    [array addObject:@"21持卡人签名\n\n\n\n\n\n本人确认以上交易，同意将其计入本卡账户\nI ACKNOWLEDGE SATISFACTORY RECEIPT OF RELATIVE GOODS/SERVICES"];
    [array addObject:@"22"];
     ****/
    
    [array addObject:[NSString stringWithFormat:@"11商户名称(MERCHANT NAME):\n    %@", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__MERCHERNAME"]]];
    [array addObject:[NSString stringWithFormat:@"12商户名称(MERCHANT NAME):\n    %@", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__MERCHERNAME"]]];
    [array addObject:[NSString stringWithFormat:@"00商户编号(MERCHANT NO):\n    %@", [dic objectForKey:@"field42"]]];
    [array addObject:[NSString stringWithFormat:@"00终端编号(TERMINAL NAME):\n    %@", [dic objectForKey:@"field41"]]];
    [array addObject:[NSString stringWithFormat:@"00发卡行(ISSUER)\n    %@", [dic objectForKey:@"issuerBank"]]];
    [array addObject:[NSString stringWithFormat:@"00卡号(CARD NO):\n    %@", [StringUtil formatAccountNo:[dic objectForKey:@"field2"]]]];
    [array addObject:[NSString stringWithFormat:@"00交易类型(TRANS TYPE):\n          %@", [[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[[Transfer sharedTransfer].receDic objectForKey:@"fieldTrancode"]]]];
    [array addObject:[NSString stringWithFormat:@"00交易批次号(BATCH NO):\n    %@", [[dic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)]]];
    [array addObject:[NSString stringWithFormat:@"00交易凭证号(VOUCHER NO):\n    %@", [dic objectForKey:@"field11"]]];
    [array addObject:[NSString stringWithFormat:@"00交易日期和时间(DATE/TIME):\n    %@", [DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [dic objectForKey:@"field13"],[dic objectForKey:@"field12"]]]]];
    [array addObject:[NSString stringWithFormat:@"00参考号(REFER NO):\n    %@", [dic objectForKey:@"field37"]]];
    [array addObject:[NSString stringWithFormat:@"00交易金额(AMOUNT):\n    %@", [StringUtil string2SymbolAmount:[dic objectForKey:@"field4"]]]];
    [array addObject:[NSString stringWithFormat:@"00备注(REFERENCE):%@", [dic objectForKey:@"remark"]]];
    [array addObject:@"21持卡人签名\n\n\n\n\n\n本人确认以上交易，同意将其计入本卡账户\nI ACKNOWLEDGE SATISFACTORY RECEIPT OF RELATIVE GOODS/SERVICES"];
    [array addObject:@"22"];
    
    [self.m_vcom rmPrint3:array pCnt:2 pakLen:350];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFY_RECORDDATA object:nil];
}


@end
