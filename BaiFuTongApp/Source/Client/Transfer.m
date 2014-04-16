//
//  Transfer.m
//  POS2iPhone
//
//  Created by  STH on 1/16/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "Transfer.h"
#import "ParseXMLUtil.h"
#import "FieldModel.h"
#import "ReversalTransferModel.h"
#import "ReversalDBHelper.h"
#import "HttpManager.h"
#import "ReversalDBHelper.h"
#import "JSONKit.h"
#import "SystemConfig.h"
#import "Transfer+FSK.h"
#import "Transfer+Action.h"

@implementation Transfer

@synthesize transferCode = _transferCode;
@synthesize fskCommand = _fskCommand;
@synthesize paramDic = _paramDic;

@synthesize sendDic = _sendDic;
@synthesize receDic = _receDic;

@synthesize m_vcom = _m_vcom;
@synthesize fskCmdArray = _fskCmdArray;
@synthesize currentFSKMethod = _currentFSKMethod;

@synthesize MKOperation = _MKOperation;

@synthesize timer = _timer;

@synthesize tempTransferCode = _tempTransferCode;

@synthesize uploadSignImageTimer = _uploadSignImageTimer;

@synthesize nextViewController = _nextViewController;

static Transfer *instance = nil;

+ (Transfer *) sharedTransfer
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[Transfer alloc] init];
        }
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

- (id)init
{
    if (self = [super init]) {
        _transferCode = nil;
        _fskCommand = nil;
        _paramDic = nil;
        
        _sendDic = [[NSMutableDictionary alloc] init];
        _receDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) startTransfer:(NSString *)transCode fskCmd:(NSString *) fskCmd paramDic:(NSDictionary *) dic
{
    // print打印指令是特例，没有网络的时候也要打印
    if (![ApplicationDelegate checkNetAvailable] && ![@"Print" isEqualToString:fskCmd]) {
        return ;
    }
    
    if ([[transCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        transCode = nil;
    }
    
    if ([[fskCmd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        fskCmd = nil;
    }
    
    self.nextViewController = nil;
    
    _paramDic = dic;
    
    self.tempTransferCode = transCode;
    
    if (self.tempTransferCode) {
        _transferCode = transCode;
    }
    
    if (fskCmd) {
        _fskCommand = fskCmd;
        
        [self fskAction];
        
        return;
    }
    
    if (transCode) {
        [self packet];
    }
}

- (void) startTransfer:(NSString *)transCode fskCmd:(NSString *) fskCmd paramDic:(NSDictionary *) paramDic nextVC:(UIViewController*)nextVC
{
    [self startTransfer:transCode fskCmd:fskCmd paramDic:paramDic];
    
    if (nextVC) {
        self.nextViewController = nextVC;
    }
}

- (void) packet
{
    // 弹出等待信息
    [self performSelectorOnMainThread:@selector(showTransferProcess) withObject:nil waitUntilDone:NO];
    [self showTransferProcess];
    
    [self.sendDic removeAllObjects];
    
    NSLog(@"正在拼装报文...");
    
    @try {
        NSArray *fieldArray = [ParseXMLUtil parseConfigXML:self.transferCode];
        if (fieldArray == nil || [fieldArray count] == 0) {
            [ApplicationDelegate gotoFailureViewController:[NSString stringWithFormat:@"应用程序加载文件出错，重新登陆(%@)", self.transferCode]];
            return;
        }
        
        // 在报文的配置中，有可能值来自于本报文中某一个域的值，为了检索的效率，在tempMap中将已解析的值存储，在后面用到时直接在tmepMap中查找
        // 取本报文的值用$做前缀，此时一定要注意，取此值时，前面一定要已经有这个域的值
        
        NSMutableString *mabStr = [[NSMutableString alloc] init];
        NSMutableString *macStr = [[NSMutableString alloc] init];
        
        for (FieldModel *field in fieldArray) {
            NSMutableString *tempStr = [[NSMutableString alloc] init];
            
            NSArray *values = [[field value] componentsSeparatedByString:@"#"];
            for (NSString *value in values) {
                if ([value hasPrefix:@"$"]) {
                    // 如果报文中某一域的值取自此报文的其他域的值，其值规定为将key的首末用'$'做前后缀
                    // for example：field60  - 012#__PASMNO#$field11$
                    if ([self.sendDic objectForKey:[value substringWithRange:NSMakeRange(1, [value length]-2)]]) {
                        [tempStr appendString:[self.sendDic objectForKey:[value substringWithRange:NSMakeRange(1, [value length]-2)]]];
                    } else {
                        NSLog(@"conf_req_%@.xml WRONG , Set the value of '%@' before setting the value of '%@' !!!",self.transferCode, field.value, [value substringWithRange:NSMakeRange(1, [value length]-2)]);
                    }
                    
                } else if ([value hasPrefix:@"__"]) {
                    // 首先检查此值是否来自界面输入，冲正则来自数据库
                    if (nil != self.paramDic && [self.paramDic objectForKey:[value substringFromIndex:2]]) {
                        [tempStr appendString:[self.paramDic objectForKey:[value substringFromIndex:2]]];
                    } else {
                        // 如果不是来自界面，那么就在AppDataCenter中寻找这个值。
                        [tempStr appendString:[[AppDataCenter sharedAppDataCenter] getValueWithKey:value]];
                    }
                } else {
                    [tempStr appendString:value];
                }
            }
            
            [field setValue:tempStr];
            
            [self.sendDic setObject:field.value forKey:field.key];
            
            // 判断是否有参与mac计算的域
            if (field.macField) {
                [mabStr appendFormat:@"%@;", field.key];
                [macStr appendString:(field.value ? field.value : @"")];
            }
        }
        
        if (![ApplicationDelegate checkNetAvailable]) {
            return ;
        }
        
        // 如果该交易需要进行冲正，则将其记入数据库冲正表中。注意，这里可能会有问题，因为有可能网络不通，直接打回，也就是说没有从手机发出交易就需要进行充正。
        if ([[[AppDataCenter sharedAppDataCenter] reversalDic] objectForKey:self.transferCode]) {
            ReversalTransferModel *model = [[ReversalTransferModel alloc] init];
            [model setTraceNum:[self.sendDic objectForKey:@"field11"]];
            [model setDate:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__YYYY-MM-DD"]];
            [model setContent:self.sendDic];
            
            ReversalDBHelper *helper = [[ReversalDBHelper alloc] init];
            [helper insertATransfer:model];
        }
        
        if (![mabStr isEqualToString:@""]) { // 需要进行MAC计算
            NSLog(@"进行mac计算的数据 :%@", macStr);
            [self.sendDic setObject:[mabStr substringToIndex:[mabStr length]-1] forKey:@"fieldMAB"];
            // 进行MAC计算
            [self startTransfer:nil fskCmd:[NSString stringWithFormat:@"Request_GetMac|string:%@", macStr] paramDic:nil];
        } else {
            [self sendPacket];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
        [ApplicationDelegate gotoFailureViewController:[NSString stringWithFormat:@"%@", exception]];
    }
}

- (void) sendPacket
{
    self.MKOperation = [[HttpManager sharedHttpManager] transfer:self.sendDic
                               successHandler:^(NSDictionary *respDic)
                                            {
                                                [self.timer invalidate];
                                                [ApplicationDelegate hideProcess];
                            
                                                self.receDic = [NSMutableDictionary dictionaryWithDictionary:respDic];
                                                [self parse];
                            
                                            }
                                 errorHandler:^(NSError *error)
                                            {
                                                [self.timer invalidate];
                                                [ApplicationDelegate hideProcess];
         
                                                NSLog(@"%@\t%@\t%@\t%@", [error localizedDescription], [error localizedFailureReason],
                                                      [error localizedRecoveryOptions], [error localizedRecoverySuggestion]);
                                            }
                        ];
}

- (void) parse
{
    NSLog(@"正在解析服务器响应报文...");
    
    @try {
        // 收到应答后先校验MAC
        NSString *mabField = [self.receDic objectForKey:@"fieldMAB"];
        
#ifdef DEMO
        [self checkField39];
        return ;
#endif
        
        // 如果是上传签购单交易,则特殊处理
        if ([self.transferCode isEqualToString:@"500000001"]) {
            if ([[self.receDic objectForKey:@"field39"] isEqualToString:@"00"]) {
                // TODO
                [self uploadSignImageDone];
            }
            
        } else {
            if (mabField != nil && ![[mabField stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
                NSArray *fields = [mabField componentsSeparatedByString:@";"];
                NSMutableString *macStr = [[NSMutableString alloc] init]; // MAC原文
                for (NSString *field in fields) {
                    [macStr appendString:[self.receDic objectForKey:field]];
                }
                
                // 校验MAC
                if ([self.receDic objectForKey:@"fieldMAC"]) {
                    [self startTransfer:nil fskCmd:[NSString stringWithFormat:@"Request_CheckMac|string:%@,string:%@", macStr, [self.receDic objectForKey:@"fieldMAC"]] paramDic:nil];
                }
            
                
            } else {
                [self checkField39];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
        
        [ApplicationDelegate gotoFailureViewController:@"服务器返回数据有误，请重试。"];
    }
    
}

- (void) checkField39
{
    if ([self.receDic objectForKey:@"field39"]) {
        NSString *field39 = [self.receDic objectForKey:@"field39"];
        
        // 收到应答后，如果此交易是一笔可能发冲正的交易且响应码不是98，则删除冲正表中的此条交易记录
        if (![field39 isEqualToString:@"98"] && [[AppDataCenter sharedAppDataCenter].reversalDic objectForKey:self.transferCode]) {
            ReversalDBHelper *helper = [[ReversalDBHelper alloc] init];
            [helper deleteAReversalTrans:[self.receDic objectForKey:@"field11"]];
        }
        
        if ([field39 isEqualToString:@"00"]) {
            // 只有在交易成功的时候取服务器日期
            if ([self.receDic objectForKey:@"field13"]) {
                [[AppDataCenter sharedAppDataCenter] setServerDate:[self.receDic objectForKey:@"field13"]];
            }
            
            if ([[AppDataCenter sharedAppDataCenter].reversalDic.allValues containsObject:self.transferCode]) {
                // 交易成功。如果这笔交易是冲正交易，则要更新冲正表，将这笔交易的状态置为冲正成功。
                ReversalDBHelper *helper = [[ReversalDBHelper alloc] init];
                [helper updateReversalState:[self.receDic objectForKey:@"field11"]];
            }
            
            [self actionDone];
            
        } else if ([field39 isEqualToString:@"98"]){
            // 当39域为98时要冲正。98 - 银联收不到发卡行应答
            [ApplicationDelegate gotoFailureViewController:@"没有收到发卡行应答"];
            [self reversalAction];
            
        } else {
            // 39域不为00，交易失败，跳转到交易失败界面。其它失败情况比如MAC计算失败直接弹窗提示用户重新交易。
            // 如果是点付宝出现异常，将在点付宝逻辑内直接处理掉
            [ApplicationDelegate gotoFailureViewController:[self.receDic objectForKey:@"fieldMessage"]];
        }
        
    } else {
        [ApplicationDelegate gotoFailureViewController:@"服务器返回数据异常(39)"];
    }
}

- (void) showTransferProcess
{
    NSString *message = [self getProcessMessage];
    
    if (message) {
        counter = 0;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProcess) userInfo:message repeats:YES];
    }
}

- (void) updateProcess
{
    if (counter++ < [SystemConfig sharedSystemConfig].maxTransferTimeout) {
        [ApplicationDelegate showProcess:[NSString stringWithFormat:@"%@ %02d s", self.timer.userInfo, counter]];
        
    } else {
        [self.timer invalidate];
        
        if (self.MKOperation) {
            [self.MKOperation cancel];
            self.MKOperation = nil;
        }
        
        if ([[[AppDataCenter sharedAppDataCenter] reversalDic] objectForKey:self.transferCode]){
            [ApplicationDelegate gotoFailureViewController:@"交易超时"];
            [self reversalAction];
        } else if ([[[AppDataCenter sharedAppDataCenter] reversalDic].allValues containsObject:self.transferCode]) {
            [ApplicationDelegate gotoFailureViewController:@"冲正超时"];
        } else {
            [ApplicationDelegate gotoFailureViewController:@"交易超时，请重试"];
        }
    }
}

- (NSString *) getProcessMessage
{
    NSString *waittingMsg = @"正在处理交易...";
    
    if ([[[AppDataCenter sharedAppDataCenter].reversalDic allValues] indexOfObject:self.transferCode] != NSNotFound) {
        waittingMsg = @"正在进行冲正...";
    } else if([self.transferCode isEqualToString:@"100005"]){
        waittingMsg = @"正在登录...";
    } else if ([self.transferCode isEqualToString:@"500000001"]){
        waittingMsg = nil;
    } else if ([self.transferCode isEqualToString:@"999000003"]){
        waittingMsg = @"正在获取验证码...";
    } else if ([self.transferCode isEqualToString:@"999000001"]) {
        waittingMsg = @"正在下载公告...";
    }
    
    return waittingMsg;
}

@end
