//
//  TransferDetailModel.h
//  YLTiPhone
//
//  Created by xushuang on 14-1-18.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDetailModel : NSObject
{
    NSString            *_account1;         //卡号
    NSString            *_amount;           //交易金额
    NSString            *_card_branch_id;   //发卡方机构代码
    
    NSString            *_local_log;        //系统业务交易流水号
    NSString            *_localdate;        //网点交易日期
    NSString            *_localtime;        //网点交易时间
    NSString            *_snd_log;          //渠道方交易流水号
    
    NSString            *_snd_cycle;        //渠道方周期号
    NSString            *_systransid;       //系统交易代码
    NSString            *_rspmsg;           //交易响应信息
    NSString            *_flag;             //交易状态 0 交易成功
}
@property (nonatomic, strong) NSString          *account1;
@property (nonatomic, strong) NSString          *amount;
@property (nonatomic, strong) NSString          *card_branch_id;

@property (nonatomic, strong) NSString          *local_log;
@property (nonatomic, strong) NSString          *localdate;
@property (nonatomic, strong) NSString          *localtime;
@property (nonatomic, strong) NSString          *snd_log;

@property (nonatomic, strong) NSString          *snd_cycle;
@property (nonatomic, strong) NSString          *systransid;
@property (nonatomic, strong) NSString          *rspmsg;
@property (nonatomic, strong) NSString          *flag;

@property (nonatomic, strong) NSString          *merchant_name;//商户名
@property (nonatomic, strong) NSString          *merchant_id;//商户编号
@property (nonatomic, strong) NSString          *terminal_id;//终端号码
@property (nonatomic, strong) NSString          *note;


@end
