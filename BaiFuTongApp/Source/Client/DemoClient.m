//
//  DemoClient.m
//  POS2iPhone
//
//  Created by  STH on 2/21/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "DemoClient.h"
#import "AppDataCenter.h"

@implementation DemoClient

static NSString *amount = @"000000010000";
static NSString *accountNo = @"6226200102917466";

+ (void) setDemoAmount:(NSString *) amt
{
    amount = [NSString stringWithFormat:@"%@", amt];
}

+ (NSString *) demoAmount
{
    return amount;
}

+ (void) setDemoAccountNo:(NSString *) no
{
    accountNo = [NSString stringWithFormat:@"%@", no];
}

+ (NSString *) demoAccountNo
{
    return accountNo;
}

+ (NSString *) getMessageWithTranCode:(NSString *) transferCode
{
    [NSThread sleepForTimeInterval:1];
    
    NSString *receJSON = @"";
    
    if ([transferCode isEqualToString:@"100005"]){ // 校验密码 登陆
        receJSON = @"{\"messtype\":\"0810\",\"field62\":\"308188028180E584FD694E15608D845C9DB15E0F68522E19FDFAE81DE34F64947D37361714315F60B01DC68D6AC2AD5BD7D4A00AF0A12ED3AB8509A04B1350B465135546F5DABC1847B650C7AADF0D9CCF458D75431E6DA31945EBF575C43A527B738DB82425D907BDE4C867508EAFCCD973872FC0FBAB8B8C3410C0800CC2088D2B11D691E70203010001\",\"keyFlag\":\"0\",\"notice_count\":\"\",\"merchName\":\"测试6\",\"field39\":\"00\",\"fieldNotice\":\"无新公告\",\"fieldVersion\":\"0\",\"field32\":\"\",\"field13\":\"20130114\",\"publicKeyType\":\"\",\"paraFlag\":\"0\",\"field12\":\"100926\",\"field11\":\"000008\",\"field37\":\"234600268261\",\"max_id_notice\":\"0\",\"fieldnewVersion\":\"201301050007\",\"fieldFlag\":\"0\",\"field41\":\"22200014\",\"fieldTrancode\":\"100005\",\"fieldMessage\":\"校验商户密码成功\",\"fieldFileName\":\"\"}";
        
    } else if ([transferCode isEqualToString:@"100001"]){ // 注册
        receJSON = @"{\"messtype\":\"0810\",\"field62\":\"\",\"field39\":\"0400004\",\"merchName\":\"\",\"field32\":\"\",\"field13\":\"20121108\",\"paraFlag\":\"\",\"field42\":\"496652141120001\",\"field12\":\"141924\",\"field11\":\"048520\",\"field37\":\"234300204076\",\"field41\":\"19820469\",\"fieldTrancode\":\"100001\",\"fieldMessage\":\"终端状态异常\"}";
    } else if([transferCode isEqualToString:@"100003"]){ // 重置密码
        receJSON = @"{\"field32\":\"\",\"messtype\":\"0810\",\"field13\":\"20121108\",\"field12\":\"142155\",\"field37\":\"234300204077\",\"field11\":\"040699\",\"field39\":\"00\",\"field41\":\"19820469\",\"fieldTrancode\":\"100003\",\"fieldMessage\":\"重置商户密码成功\"}";
    } else if ([transferCode isEqualToString:@"800003"]){ // 签到
        receJSON = @"{\"messtype\":\"0810\",\"field60\":\"00000009004\",\"field62\":\"0409C999CED9578306ED804EB6F1605A2E5968B3446024A330D25C8F28A38BAF100A320409C999CED9578306ED804EB6F1605A2E5968B3446\",\"field39\":\"00\",\"field32\":\"04960110\",\"field13\":\"20130114\",\"field42\":\"222451051920001\",\"field12\":\"163134\",\"field11\":\"000044\",\"field37\":\"234600268307\",\"field41\":\"22200014\",\"fieldTrancode\":\"800003\",\"fieldMessage\":\"\"}";
    } else if ([transferCode isEqualToString:@"500201"]){ // 结算
        receJSON = @"{\"field60\":\"00000012201\",\"messtype\":\"0510\",\"field39\":\"00\",\"field32\":\"\",\"field13\":\"20121108\",\"field15\":\"1108\",\"field42\":\"496652141120001\",\"field49\":\"\",\"field48\":\"0000000155570040000000000010012\",\"field12\":\"130458\",\"field11\":\"021133\",\"field37\":\"234300204062\",\"fieldMAC\":\"\",\"field41\":\"19820469\",\"fieldMAB\":\"\",\"fieldTrancode\":\"500201\",\"fieldMessage\":\"结算成功\"}";
    } else if ([transferCode isEqualToString:@"820002"]){ // 签退成功
        receJSON = @"{\"field60\":\"00000014002\",\"field32\":\"04960110\",\"messtype\":\"0830\",\"field13\":\"20121108\",\"field42\":\"496652141120001\",\"field12\":\"134332\",\"field37\":\"234300204066\",\"field11\":\"065219\",\"field39\":\"00\",\"field41\":\"19820469\",\"fieldTrancode\":\"820002\",\"fieldMessage\":\"签退成功\"}";
    } else if ([transferCode isEqualToString:@"100004"]){ // 修改密码
        receJSON = @"{\"field32\":\"\",\"messtype\":\"0810\",\"field13\":\"20121108\",\"field12\":\"134523\",\"field37\":\"234300204068\",\"field11\":\"076637\",\"field39\":\"00\",\"field41\":\"19820469\",\"fieldTrancode\":\"100004\",\"fieldMessage\":\"修改密码成功\"}";
    } else if ([transferCode isEqualToString:@"200310001"]){ // 银行卡余额查询
        receJSON = [NSString stringWithFormat:@"{\"field60\":\"0100000900020\",\"field62\":\"\",\"field39\":\"00\",\"field4\":\"1002156D000000010000\",\"field44\":\"\",\"field25\":\"00\",\"field3\":\"300000\",\"field2\":\"%@\",\"field42\":\"222451051920001\",\"field23\":\"000\",\"field49\":\"156\",\"fieldMAC\":\"AB1554AF\",\"field41\":\"22200014\",\"fieldTrancode\":\"200310001\",\"fieldMAB\":\"fieldTrancode;messtype;field2;field3;field11;field13;field25;field32;field39;field41;field42;field53\",\"fieldMessage\":\"银行卡余额查询成功\",\"messtype\":\"0210\",\"field53\":\"2610000000000000\",\"field54\":\"1001156C000000010000\",\"field32\":\"11111111\",\"field14\":\"4912\",\"field13\":\"20130114\",\"field12\":\"101936\",\"field38\":\"\",\"field37\":\"234600268267\",\"field11\":\"000016\"}", accountNo];
    } else if ([transferCode isEqualToString:@"200000022"]){  // 收款
        receJSON = [NSString stringWithFormat:@"{\"field60\":\"2200000900020\",\"field62\":\"\",\"remark\":\"\",\"field39\":\"00\",\"field4\":\"%@\",\"field44\":\"002300\",\"field3\":\"000000\",\"issuerBank\":\"中国银行\",\"field2\":\"%@\",\"field42\":\"222451051920001\",\"field49\":\"156\",\"field41\":\"22200014\",\"fieldMAC\":\"96D25810\",\"fieldTrancode\":\"200000022\",\"fieldMAB\":\"fieldTrancode;messtype;field2;field3;field4;field11;field13;field32;field38;field39;field41;field42;field53\",\"fieldMessage\":\"收款成功\",\"messtype\":\"0210\",\"field55\":\"\",\"field53\":\"2610000000000000\",\"field32\":\"11111111\",\"field14\":\"4912\",\"field13\":\"%@\",\"field15\":\"0912\",\"field38\":\"\",\"field12\":\"%@\",\"field37\":\"234600268271\",\"field11\":\"000020\"}", amount, accountNo, [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__YYYYMMDD"], [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__HHMMSS"]];
    } else if ([transferCode isEqualToString:@"600000001'"]) { // 交易明细汇总查询
        receJSON = @"{\"field32\":\"090001\",\"messtype\":\"0810\",\"field13\":\"20130114\",\"detail\":\"amount:0.11^total:2^tranCode:200000022|amount:1000.00^total:1^tranCode:200001111|amount:0.06^total:1^tranCode:200200023\",\"field12\":\"162912\",\"field37\":\"234600268305\",\"field11\":\"000042\",\"field39\":\"00\",\"field41\":\"22200014\",\"fieldTrancode\":\"600000001\",\"fieldMessage\":\"查询成功\"}";
    } else if ([transferCode isEqualToString:@"600000002"]){ // 交易明细查询
        receJSON = @"{\"field32\":\"\",\"messtype\":\"0210\",\"field13\":\"20130114\",\"detail\":\"aimCardNo:^batchNo:000008^cardNo:6221881000084798123^hostSerial:0014^issueBank:绿卡银联标准卡^merchId:222451051920001^settleDate:20130112^settleFlag:0^termId:22200014^tranAmt:0.05^tranDate:20130111^tranSerial:234600268248^tranTime:175713^tranCode:200000022^tranFlag:0|aimCardNo:^batchNo:000009^cardNo:6221881000084798123^hostSerial:0016^issueBank:绿卡银联标准卡^merchId:222451051920001^settleDate:20130114^settleFlag:0^termId:22200014^tranAmt:0.06^tranDate:20130114^tranSerial:234600268271^tranTime:102310^tranCode:200000022^tranFlag:1\",\"field12\":\"163017\",\"field37\":\"234600268306\",\"field11\":\"000043\",\"field39\":\"00\",\"field41\":\"22200014\",\"fieldTrancode\":\"600000002\",\"fieldMessage\":\"查询成功\"}";
    }else if ([transferCode isEqualToString:@"500000001"]){ // 签购单上传
        receJSON = @"{\"messtype\":\"0210\",\"field44\":\"您卡号后4位为6095的卡于2012年12月04日发生一笔消费交易，交易金额100.00元,签购单查询地址:www.baidu.com[内蒙农信]\",\"field13\":\"20121108\",\"field3\":\"500000001\",\"field12\":\"135520\",\"field39\":\"00\",\"fieldMAC\":\"\",\"fieldMAB\":\"\",\"fieldTrancode\":\"500000001\",\"fieldMessage\":\"签购单上传成功\"}";
    } else if ([transferCode isEqualToString:@"200200023"]){ // 收款撤销
        receJSON = [NSString stringWithFormat:@"{\"field60\":\"2300001400020\",\"field63\":\"CUP\",\"field39\":\"00\",\"field4\":\"%@\",\"field44\":\"\",\"field25\":\"00\",\"field3\":\"200000\",\"field2\":\"%@\",\"field42\":\"496652141120001\",\"field23\":\"000\",\"field49\":\"156\",\"fieldMAC\":\"52355320\",\"field41\":\"19820469\",\"fieldMAB\":\"fieldTrancode;messtype;field2;field3;field4;field11;field13;field25;field32;field38;field39;field41;field42;field53\",\"fieldTrancode\":\"200200023\",\"fieldMessage\":\"收款撤销成功\",\"messtype\":\"0210\",\"field55\":\"\",\"field53\":\"2610000000000000\",\"field32\":\"\",\"field14\":\"4912\",\"field13\":\"%@\",\"field15\":\"\",\"field12\":\"%@\",\"field38\":\"\",\"field11\":\"025638\",\"field37\":\"234300204072\"}", amount, accountNo,[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__YYYYMMDD"], [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__HHMMSS"]];
        
    } else if ([transferCode isEqualToString:@"200001111"]){ // 付款
        receJSON = [NSString stringWithFormat:@"{\"field60\":\"2200001400020\",\"field62\":\"\",\"field39\":\"00\",\"field4\":\"000000020000\",\"field44\":\"\",\"field25\":\"00\",\"field3\":\"400000\",\"field2\":\"%@\",\"field42\":\"496652141120001\",\"field49\":\"156\",\"field7\":\"20121108\",\"field46\":\"\",\"fieldMAC\":\"718FA0E2\",\"field41\":\"19820469\",\"fieldMAB\":\"fieldTrancode;messtype;field2;field3;field4;field7;field11;field13;field25;field32;field33;field39;field41;field42;field102;field103\",\"fieldTrancode\":\"200001111\",\"fieldMessage\":\"转账成功\",\"messtype\":\"0210\",\"field54\":\"\",\"field32\":\"\",\"field13\":\"20121108\",\"field100\":\"0023000\",\"field33\":\"\",\"field15\":\"0912\",\"field12\":\"140515\",\"field11\":\"028104\",\"field37\":\"234300204074\",\"field103\":\"6226852365896326\",\"field102\":\"6229760070100466095\"}", accountNo];
    } else if ([transferCode isEqualToString:@"700000001"]){ // 手机充值
        receJSON = @"{\"field32\":\"\",\"messtype\":\"0810\",\"field13\":\"20121108\",\"field12\":\"134523\",\"field37\":\"234300204068\",\"field11\":\"076637\",\"field39\":\"00\",\"field41\":\"19820469\",\"fieldTrancode\":\"700000001\",\"fieldMessage\":\"手机充值成功\"}";
    } else if([transferCode isEqualToString:@"999000003"]){ // 验证码
        receJSON = @"{\"condition\":\"152D6793-4FA5-4F58-91F6-79222C97861E\",\"field39\":\"00\",\"captcha_save\":\"0058\",\"fieldTrancode\":\"999000003\",\"fieldMessage\":\"\",\"clientType\":\"01\"}";
    } else if([transferCode isEqualToString:@"999000002"]){ // 检查更新
        receJSON = @"{\"version_name\":\"\",\"fieldChannel\":\"06\",\"version_number\":0,\"field39\":\"00\",\"fieldTrancode\":\"999000002\",\"fieldMessage\":\"\",\"clientType\":1}";
    } else {
        receJSON = @"{\"field32\":\"\",\"messtype\":\"0810\",\"field13\":\"20121108\",\"field12\":\"134523\",\"field37\":\"234300204068\",\"field11\":\"076637\",\"field39\":\"00\",\"field41\":\"19820469\",\"fieldTrancode\":\"700000001\",\"fieldMessage\":\"交易成功\"}";
    }
    
    
    return receJSON;
}

/***
 
 \"captcha\":\"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\nOw==\",
 
 ***/

@end
