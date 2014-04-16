//
//  TransferLogicCore.m
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#define GENERALTRANSFER							@"GENERALTRANSFER"
#define UPLOADSIGNIMAGETRANSFER					@"UPLOADSIGNIMAGETRANSFER"

#import "Transfer+Action.h"
#import "EncryptionUtil.h"
#import "FileOperatorUtil.h"
#import "ParseXMLUtil.h"
#import "SystemConfig.h"
//#import "LRCatalogViewController.h"
#import "TransferSuccessDBHelper.h"
#import "StringUtil.h"
#import "EncryptionUtil.h"
//#import "ForgetPasswordViewController.h"
#import "TradeDetailGatherTableViewController.h"
//#import "SettingPasswordViewController.h"
#import "ConfirmCancelResultViewController.h"
#import "TradeDetailTableViewController.h"
#import "SettleAccountResultViewController.h"
//#import "RegesterSuccessViewController.h"
#import "ReversalDBHelper.h"
#import "SuccessTransferModel.h"
#import "AnnouncementDBHelper.h"
#import "AnnouncementModel.h"
#import "ResultViewController.h"
#import "UploadSignImageDBHelper.h"
//#import "PayResultViewController.h"
#import "DateUtil.h"
#import "PayeeAccountDBHelper.h"
#import "PayeeAccountModel.h"
#import "AnnouncementListViewController.h"
//#import "TimedoutUtil.h"
#import "NoviceGuideViewController.h"

@implementation Transfer (Action)


- (void) transferAction:(NSString *) transferCode paramDic:(NSDictionary *) paramDic
{
    // TODO
    
    /**
    if ([transferCode isEqualToString:@"500000001"]) { // 签购单上传
        [self.transferDic setObject:nil forKey:UPLOADSIGNIMAGETRANSFER];
    } else {
        [self.transferDic setObject:nil forKey:GENERALTRANSFER];
    }
     
     **/
    
    [[Transfer sharedTransfer] startTransfer:transferCode fskCmd:nil paramDic:paramDic];
}

- (void) actionDone
{
    if ([self.transferCode isEqualToString:@"100001"]){
        [self registrDone];
    } else if ([self.transferCode isEqualToString:@"100002"]) {
        [self regesterSuccessDone];
    } else if ([self.transferCode isEqualToString:@"100005"]) {
        [self loginDone];
    } else if([self.transferCode isEqualToString:@"800003"]) {
        [self signDone];
    } else if ([self.transferCode isEqualToString:@"999000003"]) {
        [self downloadSecuImage];
    } else if([self.transferCode isEqualToString:@"999000001"]) {
        [self downloadAnnouncements];
    } else if ([self.transferCode isEqualToString:@"600000001"]) {
        [self tradeGatherDone];
    } else if ([self.transferCode isEqualToString:@"200000022"]) {
        [self inputMoneyDone];
    } else if ([self.transferCode isEqualToString:@"200200023"]) {
        [self ConfirmCancelDone];
    } else if([self.transferCode isEqualToString:@"600000002"]){
        [self tradeDetailDone];
    } else if ([self.transferCode isEqualToString:@"200310001"]) {
        [self queryBalanceDone];
    } else if ([self.transferCode isEqualToString:@"200001111"]) {
        [self payMoneyDone];
    } else if ([self.transferCode isEqualToString:@"500000001"]) {
        [self uploadSignImageDone];
    } else if ([self.transferCode isEqualToString:@"500201"]) {
        [self settleDone];
    } else if ([self.transferCode isEqualToString:@"100004"]) {
        [self modifyDone];
    } else if([self.transferCode isEqualToString:@"820002"]){
        [self signOutDone];
    }else {
        [self transferSuccessDone];
    }
}

-(void)signOutDone
{
    if (self.receDic) {
        NSLog(@"%@", self.receDic);
        [ApplicationDelegate gotoSuccessViewController:[self.receDic objectForKey:@"fieldMessage"]];
    }
}

-(void)modifyDone
{
    if (self.receDic) {
        NSLog(@"%@", self.receDic);
        [ApplicationDelegate gotoSuccessViewController:[self.receDic objectForKey:@"fieldMessage"]];
    }
}

-(void)settleDone
{
    /**
     —— 内卡结算总额，内容为：
     ● 借记总金额 N12
     ● 借记总笔数 N3
     ● 贷记总金额 N12
     ● 贷记总笔数 N3
     ● 对账应答代码 N1
     
     对账应答码 对账应答码说明
     0 ISO 保留
     1 对账平
     **/
    if (self.receDic) {
        NSString *field48 = [self.receDic objectForKey:@"field48"];
        NSString *debitAmount = [field48 substringWithRange:NSMakeRange(0, 12)];
        NSString *debitCount = [field48 substringWithRange:NSMakeRange(12, 3)];
        NSString *creditAmount = [field48 substringWithRange:NSMakeRange(15, 12)];
        NSString *creditCount = [field48 substringWithRange:NSMakeRange(27, 3)];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[self.receDic objectForKey:@"fieldMessage"] forKey:@"fieldMessage"];
        [dic setObject:[StringUtil string2SymbolAmount:debitAmount] forKey:@"debitAmount"];
        [dic setObject:debitCount forKey:@"debitCount"];
        [dic setObject:[StringUtil string2SymbolAmount:creditAmount] forKey:@"creditAmount"];
        [dic setObject:creditCount forKey:@"creditCount"];
        
        SettleAccountResultViewController *vc = [[SettleAccountResultViewController alloc] initWithParam:dic];
        [[ApplicationDelegate topViewController].navigationController pushViewController:vc animated:YES];
    }
}

-(void)payMoneyDone
{
    if (self.receDic) {
        NSLog(@"%@", self.receDic);
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        [array addObject:[[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[self.receDic objectForKey:@"fieldTrancode"]]];
        [array addObject:[self.receDic objectForKey:@"field11"]];
        NSString *date =  [DateUtil formatDateString:[self.receDic objectForKey:@"field13"]];
        NSString *time =  [DateUtil formatTimeString:[self.receDic objectForKey:@"field12"]];
        NSString *dateStr = [NSString stringWithFormat:@"%@ %@",date, time];
        [array addObject:dateStr];
        [array addObject:[StringUtil formatAccountNo:[self.receDic objectForKey:@"field102"]]];
        [array addObject:[StringUtil formatAccountNo:[self.receDic objectForKey:@"field103"]]];
        [array addObject:[StringUtil string2SymbolAmount:[self.receDic objectForKey:@"field4"]]];
        [array addObject:[NSString stringWithFormat:@"%@ 元", [self.receDic objectForKey:@"fieldFee"]]];
        [array addObject:[self.receDic objectForKey:@"fieldMessage"]];
        
        PayeeAccountDBHelper *helper = [[PayeeAccountDBHelper alloc] init];
        PayeeAccountModel *model = [helper queryAccountWithAccountNo:[self.receDic objectForKey:@"field103"]];
        NSString *phoneStr = model.phoneNo;
        
//        PayResultViewController *vc = [[PayResultViewController alloc] initWithNibName:@"PayResultViewController" bundle:nil];
//        vc.dataArray = array;
//        vc.phoneStr = phoneStr ? phoneStr : @"";
//        [[ApplicationDelegate topViewController].navigationController pushViewController:vc animated:YES];
    }
}

-(void)tradeDetailDone
{
    if (self.receDic) {
        NSString *detail = [self.receDic objectForKey:@"detail"];
        NSArray *array = (NSArray*)[detail componentsSeparatedByString:@"|"];
        ((TradeDetailTableViewController*)[ApplicationDelegate topViewController]).array = array;
        [(TradeDetailTableViewController*)[ApplicationDelegate topViewController] refreshTabelView];
    }
}

-(void)tradeGatherDone
{
    if (self.receDic) {
        TradeDetailGatherTableViewController *vc = [[TradeDetailGatherTableViewController alloc] initWithNibName:@"TradeDetailGatherTableViewController" bundle:nil];
        NSString *tmpBeginDate = [self.sendDic objectForKey:@"BeginDate"];
        NSString *tmpEndDate = [self.sendDic objectForKey:@"EndDate"];
        NSString *tmpStr = [self.receDic objectForKey:@"detail"];
        NSArray *array = [tmpStr componentsSeparatedByString:@"|"];
        vc.dataArray = array;
        vc.beginString = tmpBeginDate;
        vc.endString = tmpEndDate;
        [[ApplicationDelegate topViewController].navigationController pushViewController:vc animated:YES];
    }
}

- (void) transferSuccessDone
{
    [ApplicationDelegate gotoSuccessViewController:[self.receDic objectForKey:@"fieldMessage"]];
}

- (void) loginDone
{
    @try {
        if (self.receDic) {
            // 先判断公钥是否需要更新
            if ([((NSString *)[self.receDic objectForKey:@"keyFlag"]) isEqualToString:@"1"]) { // 0-不需更新 1-需要更新
                // 更新公钥信息
                NSDictionary *pubDic = [EncryptionUtil parsePublickey:[self.receDic objectForKey:@"field62"]];
                [UserDefaults setObject:[pubDic objectForKey:@"mod"] forKey:PUBLICKEY_MOD];
                [UserDefaults setObject:[pubDic objectForKey:@"exp"] forKey:PUBLICKEY_EXP];
                [UserDefaults setObject:[self.receDic objectForKey:@"fieldnewVersion"] forKey:PUBLICKEY_VERSION];
                [UserDefaults setObject:[self.receDic objectForKey:@"publicKeyType"] forKey:PUBLICKEY_TYPE];
                [UserDefaults synchronize];
                
                [ApplicationDelegate gotoFailureViewController:@"由于安全密钥已更新，请您重新登陆"];
                return;
            }
            
            // 取服务器最新的公告编号
            if ([self.receDic objectForKey:@"max_id_notice"]) {
                [UserDefaults setObject:[self.receDic objectForKey:@"max_id_notice"] forKey:SERVER_ANNOUNCEMENT_LASTEST_NUM];
            }
            
            // 保存商户名称
            if ([self.receDic objectForKey:@"merchName"]) {
                [UserDefaults setObject:[self.receDic objectForKey:@"merchName"] forKey:MERCHERNAME];
            }
            
            // 检查版本，如有可能下载文件进行更新。
#ifndef DEMO
            int currentVersion = [UserDefaults integerForKey:VERSION];
            int serverVersion = [[self.receDic objectForKey:@"fieldVersion"] intValue];
            if ([FileOperatorUtil updateFiles:currentVersion newVersion:serverVersion fileNames:[self.receDic objectForKey:@"fieldFileName"]]) {
                
                NSLog(@"下载更新文件完成或不需要更新");
            } else {
                [ApplicationDelegate gotoFailureViewController:@"更新文件失败"];
                return;
            }
#endif
            
            @try {
                // 读取有可能更新后的系统配置信息。systemconfig.xml
                [[SystemConfig sharedSystemConfig] loadParams:[ParseXMLUtil parseSystemConfigXML]];
            }
            @catch (NSException *exception) {
                NSLog(@"--%@", [exception callStackSymbols]);
                [ApplicationDelegate gotoFailureViewController:@"读取系统配置文件失败"];
            }
        
            // 启动超时退出服务
//            [[TimedoutUtil sharedInstance] start];
            
            // 登陆成功，跳转到菜单界面
            ApplicationDelegate.hasLogin = YES;
            
//            [ApplicationDelegate.rootNavigationController pushViewController:[[LRCatalogViewController alloc] initWithNibName] animated:YES];
        
            
        } else {
            [ApplicationDelegate gotoFailureViewController:@"服务器返回异常！"];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", [exception callStackSymbols]);
        [ApplicationDelegate gotoFailureViewController:@"服务器返回异常。"];
    }
    @finally {
        [UserDefaults synchronize];
    }
}

/**
 * 签到
 *
 * 当点击签到按纽后并从服务器返回JSON后执行此方法。
 *
 * 执行此方法说明服务器端签到正常，没有其他的异常情况发生。
 * 签到成功后
 * 1、首先要更新工作密钥。按长度分别切割
 * 2、然后将收款撤销表清空。
 */
- (void)signDone
{
    // 更新批次号
    NSString *batchNum = [[self.receDic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)];
    [[AppDataCenter sharedAppDataCenter] setBatchNum:batchNum];
    
    // 清空上一个批次的交易成功的信息，即用于消费撤销和查询签购单的数据库表
    TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
    if ([helper deleteAllTransfer]) {
        NSLog(@"更换批次后 成功 清空需清除的成功交易！");
    } else {
        NSLog(@"更换批次后清空需清除的成功交易 失败 ！");
    }
    
    // 根据62域字符串切割得到工作密钥
    NSString *macKey = nil;
    NSString *pinKey = nil;
    NSString *stackKey = nil;
    @try {
        NSString *newKey = [[self.receDic objectForKey:@"field62"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        int macLength = [[newKey substringToIndex:3] intValue];
        macKey = [newKey substringWithRange:NSMakeRange(3, macLength)];
        
        int pinLenggh = [[newKey substringWithRange:NSMakeRange(3+macLength, 3)] intValue];
        pinKey = [newKey substringWithRange:NSMakeRange(6+macLength, pinLenggh)];
        
        int stackLength = [[newKey substringWithRange:NSMakeRange(6+macLength+pinLenggh, 3)] intValue];
        stackKey = [newKey substringWithRange:NSMakeRange(9+macLength+pinLenggh, stackLength)];
        
        // 更新工作密钥
        [[Transfer sharedTransfer] startTransfer:nil fskCmd:[NSString stringWithFormat:@"Request_ReNewKey|string:%@,string:%@,string:%@", macKey, pinKey, stackKey] paramDic:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", [exception callStackSymbols]);
        [ApplicationDelegate gotoFailureViewController:@"签到失败，请重试"];
    }
}

// 更新工作密钥成功
- (void) updateWorkingKeyDone
{
    [ApplicationDelegate gotoSuccessViewController:@"签到成功\n\n[设备已成功更新工作密钥]"];
}

// 签退
- (void)signOffDone
{
    [ApplicationDelegate gotoSuccessViewController:[self.receDic objectForKey:@"fieldMessage"]];
}

// 注册
- (void) registrDone
{
    @try {
        // 保存手机号
        [[AppDataCenter sharedAppDataCenter] setPhoneNum:[self.sendDic objectForKey:@"termMobile"]];
        
        if (![self.receDic objectForKey:@"field62"] || ![self.receDic objectForKey:@"merchName"] || ![self.receDic objectForKey:@"publicKeyVersion"] || ![self.receDic objectForKey:@"publicKeyType"]) {
            
            [ApplicationDelegate gotoFailureViewController:@"服务器返回数据异常，请重试！"];
            return;
            
        } else {
            // 注册成功后，保存商户名称，保存公钥信息，然后跳转到设置密码界面
            NSDictionary *pubDic = [EncryptionUtil parsePublickey:[self.receDic objectForKey:@"field62"]];
            [UserDefaults setObject:[self.receDic objectForKey:@"merchName"] forKey:MERCHERNAME];
            [UserDefaults setObject:[pubDic objectForKey:@"mod"] forKey:PUBLICKEY_MOD];
            [UserDefaults setObject:[pubDic objectForKey:@"exp"] forKey:PUBLICKEY_EXP];
            [UserDefaults setObject:[self.receDic objectForKey:@"publicKeyVersion"] forKey:PUBLICKEY_VERSION];
            [UserDefaults setObject:[self.receDic objectForKey:@"publicKeyType"] forKey:PUBLICKEY_TYPE];
            [UserDefaults synchronize];
            
            // 跳转到设置密码界面
//            [ApplicationDelegate.rootNavigationController pushViewController:[[SettingPasswordViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", [exception callStackSymbols]);
        [ApplicationDelegate gotoFailureViewController:@"服务器返回数据异常，请重试！"];
    }
}

- (void) regesterSuccessDone
{
    //跳转到注册成功页面 显示商户名称，商户号等信息
//    RegesterSuccessViewController *regesterSuccessVC = [[RegesterSuccessViewController alloc] initWithData:self.receDic];
//    [ApplicationDelegate.rootNavigationController pushViewController:regesterSuccessVC animated:YES];
}

// 查询银行卡余额
- (void) queryBalanceDone
{
    @try {

        NSString *balance = [self.receDic objectForKey:@"field54"];
        NSString *availableBalance = [self.receDic objectForKey:@"field4"];
        
        NSMutableString *tempStr = [NSMutableString string];
        if (balance && balance.length == 20) {
            [tempStr appendFormat:@"账面余额:%@", [StringUtil string2SymbolAmount:[balance substringFromIndex:[balance length] - 12]]];
        }
        
        if (availableBalance && availableBalance.length == 20) {
            [tempStr appendString:@"\n"];
            [tempStr appendFormat:@"可用余额:%@", [StringUtil string2SymbolAmount:[availableBalance substringFromIndex:[availableBalance length] - 12]]];
        }
        
//        NSString *displayMsg = [NSString stringWithFormat:@"账面余额%@\n可用余额%@", [StringUtil string2SymbolAmount:[balance substringFromIndex:[balance length] - 12]], [StringUtil string2SymbolAmount:[availableBalance substringFromIndex:[availableBalance length] - 12]]];
        
        // 点击确定按纽后会一直执行这个方法
        [[Transfer sharedTransfer].m_vcom display:tempStr timer:30];
        
        /**
        // 由于金额带有， 与 反射调用方法中的分隔符冲突，故直接调用该方法
        [[Transfer sharedTransfer] startTransfer:nil fskCmd:[NSString stringWithFormat:@"Display|string:%@", displayMsg] paramDic:nil];
         ***/
        
        [ApplicationDelegate gotoSuccessViewController:[self.receDic objectForKey:@"fieldMessage"]];
        
        [ApplicationDelegate showSuccessPrompt:@"余额已显示在刷卡设备屏幕上"];
    }
    @catch (NSException *exception) {
        NSLog(@"--%@", exception);
        NSLog(@"--%@", [exception callStackSymbols]);
        
        [ApplicationDelegate gotoFailureViewController:@"查询余额失败，请重试。"];
    }
}

/**
 * 收款或收款撤销成功，记录数据以备查询签购单
 */
- (void) recordSuccessTransfer
{
    SuccessTransferModel *model = [[SuccessTransferModel alloc] init];
    [model setAmount:[self.receDic objectForKey:@"field4"]];
    [model setTraceNum:[self.receDic objectForKey:@"field11"]];
    [model setTransCode:[self.receDic objectForKey:@"fieldTrancode"]];
    [model setDate:[self.receDic objectForKey:@"field13"]];
    [model setContent:self.receDic];
    
    TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
    BOOL flag = [helper insertASuccessTrans:model];
    if (flag) {
        NSLog(@"交易成功并写入数据库。。。");
    } else {
        NSLog(@"交易成功但写入数据库时操作失败。。。");
    }
}

/**
 收款成功
 **/
-(void)inputMoneyDone
{
    [self recordSuccessTransfer];
    
    ConfirmCancelResultViewController *resultVC = [[ConfirmCancelResultViewController alloc] initWithResultMessage:@"收款成功"];
    [[ApplicationDelegate topViewController].navigationController pushViewController:resultVC animated:YES];
}

/**
 收款撤销成功
 **/
- (void) ConfirmCancelDone
{
    [self recordSuccessTransfer];
    
    TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
    [helper updateRevokeFalg:[[self.sendDic objectForKey:@"field90"] substringWithRange:NSMakeRange(4, 6)]];
    
    ConfirmCancelResultViewController *resultVC = [[ConfirmCancelResultViewController alloc] initWithResultMessage:@"收款撤销成功"];
    [[ApplicationDelegate topViewController].navigationController pushViewController:resultVC animated:YES];
}

/**
 冲正
 ***/
- (BOOL) reversalAction
{
#ifdef DEMO
    return NO;
#endif
    
    
    ReversalDBHelper *helper = [[ReversalDBHelper alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[helper queryTheNeedReversalTrans]];
    if (dic == nil || [dic count] == 0) {
        return false;
        
    } else {
        [ApplicationDelegate showProcess:@"正在发起冲正交易..."];
        // 更新冲正表，则冲正次数加1。
        // 注意这可能有问题，因为如果网络不通，直接没有从手机中发出交易，也已经使冲正次数发生变更
        ReversalDBHelper *DBHelper = [[ReversalDBHelper alloc] init];
        [DBHelper updateReversalCount:[dic objectForKey:@"field11"]];
        
        // 将原交易的transferCode改为对应的冲正的transferCode
        [dic setObject:[[AppDataCenter sharedAppDataCenter].reversalDic objectForKey:[dic objectForKey:@"fieldTrancode"] ] forKey:@"fieldTrancode"];
        
        [self transferAction:[dic objectForKey:@"fieldTrancode"] paramDic:dic];
        
        return true;
    }
}


/**
 * 取验证码
 */
- (void) downloadSecuImage
{
    /**
    UIViewController *vc = [ApplicationDelegate topViewController];
    if ([vc isKindOfClass:[LoginViewController class]]) {
        [((LoginViewController *)vc) refreshSecurityImage:[self.receDic objectForKey:@"captcha"]];
    } else if ([vc isKindOfClass:[ForgetPasswordViewController class]]) {
        [((ForgetPasswordViewController *)vc) refreshSecurityImage:[self.receDic objectForKey:@"captcha"]];
    }
     **/
}

/**
 * 正在下载新公告
 */
- (void) downloadAnnouncements
{
    @try {
        NSInteger currentAnnouncementLastestNum = [UserDefaults integerForKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM]; // 如果不存在返回0
        AnnouncementDBHelper *helper = [[AnnouncementDBHelper alloc] init];
        
        NSString *fieldContent = [self.receDic objectForKey:@"content_notice"];
        if (fieldContent && ![[fieldContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            
            NSArray *contentArray = [fieldContent componentsSeparatedByString:@"|"];
            for (NSString *content in contentArray) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                NSArray *tempArray = [content componentsSeparatedByString:@"^"];
                for (NSString *str in tempArray) {
                    NSArray *fieldArray = [str componentsSeparatedByString:@":"];
                    if ([fieldArray count] == 1) {
                        [dic setObject:@"" forKey:[fieldArray objectAtIndex:0]];
                    } else if ([fieldArray count] == 2) {
                        [dic setObject:[fieldArray objectAtIndex:1] forKey:[fieldArray objectAtIndex:0]];
                    }
                }
                
                if ([dic objectForKey:@"id_notice"]) {
                    AnnouncementModel *model = [[AnnouncementModel alloc] initWithDic:dic];
                    [helper insertAnnouncement:model];
                    
                    // 更新公告最新编号
                    NSInteger noticeNum = [[dic objectForKey:@"id_notice"] integerValue];
                    if (noticeNum > currentAnnouncementLastestNum) {
                        [UserDefaults setObject:[dic objectForKey:@"id_notice"] forKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM];
                        [UserDefaults synchronize];
                    }
                } else {
                    [ApplicationDelegate gotoFailureViewController:@"更新公告时出现异常，请重试。"];
                    return;
                }
            }
        }

        [(AnnouncementListViewController *)[ApplicationDelegate topViewController] refreshTabelView];
    }
    @catch (NSException *exception) {
        NSLog(@"---%@", exception);
        NSLog(@"---%@", [exception callStackSymbols]);
        [ApplicationDelegate gotoFailureViewController:@"更新公告时出现异常，请重试！"];
    }
}

- (void) uploadSignImageDone
{
    // TODO 服务器返回的数据竟然又将图片反传回来了。。。。
    
    NSString *field11 = [self.sendDic objectForKey:@"field11"];
    
    UploadSignImageDBHelper *helper = [[UploadSignImageDBHelper alloc] init];
    // TODO 发送短信
    NSString *receMobile = [helper queryReceMobile:field11];
    
    
    // 签购单上传成功后更新数据库
    [helper updateUploadFlagSuccess:field11];
}

- (void) uploadSignImageAction
{
    // 将相关数据写入数据库
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    [tempDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__TERID"] forKey:@"field41"];
    [tempDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__VENDOR"] forKey:@"field42"];
    [tempDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PHONENUM"] forKey:@"termMobile"];
    [tempDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__TERSERIALNO"] forKey:@"ReaderID"];
    [tempDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PSAMNO"] forKey:@"PSAMID"];
    
    [tempDic setObject:[self.sendDic objectForKey:@"field7"] forKey:@"field7"];
    [tempDic setObject:[self.receDic objectForKey:@"field11"] forKey:@"field11"];
    [tempDic setObject:[[self.receDic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)] forKey:@"batchNum"];
    [tempDic setObject:[self.receDic objectForKey:@"imei"] forKey:@"filedIMEI"];
    [tempDic setObject:[self.receDic objectForKey:@"receivePhoneNo"] forKey:@"fieldMobile"];
    [tempDic setObject:[self.receDic objectForKey:@"fieldImage"] forKey:@"fieldImage"];
    
    UploadSignImageDBHelper *helper = [[UploadSignImageDBHelper alloc] init];
    BOOL flag = [helper insertATransfer:[tempDic objectForKey:@"field11"] receMobile:[tempDic objectForKey:@"receivePhoneNo"] content:tempDic];
    NSLog(flag?@"已将签购单写入数据库，等待上传...":@"签购单写入数据库 失败！");
    
    
    // 启动线程上传签购单图片
    if (self.uploadSignImageTimer && [self.uploadSignImageTimer isValid]) {
        NSLog(@"试图开启上传签购单服务，服务已开启，运行中...");
        return;
    }
    
    self.uploadSignImageTimer = [NSTimer scheduledTimerWithTimeInterval:300.0 target:self selector:@selector(doUploadSignImage) userInfo:nil repeats:YES];
    // 立即触发事件
    [self.uploadSignImageTimer fire];
}

- (void) doUploadSignImage
{
    NSLog(@"正在检查签购单...");
    UploadSignImageDBHelper *helper = [[UploadSignImageDBHelper alloc] init];
    NSDictionary *dic = [helper queryAUploadSignImageTransfer];
    if (dic) {
        NSLog(@"检测到需要上传的签购单，正在发起上传...");
        [[Transfer sharedTransfer] startTransfer:@"500000001" fskCmd:nil paramDic:dic];
    } else {
        NSLog(@"没有检测到需要上传的签购单，停止后台服务...");
        [self.uploadSignImageTimer invalidate];
        self.uploadSignImageTimer = nil;
    }
}

@end
