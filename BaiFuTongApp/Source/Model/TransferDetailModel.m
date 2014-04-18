//
//  TransferDetailModel.m
//  YLTiPhone
//
//  Created by xushuang on 14-1-18.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "TransferDetailModel.h"

@implementation TransferDetailModel

@synthesize account1 = _account1;
@synthesize amount = _amount;
@synthesize card_branch_id = _card_branch_id;
@synthesize local_log = _local_log;
@synthesize localdate = _localdate;
@synthesize localtime = _localtime;
@synthesize snd_cycle = _snd_cycle;
@synthesize systransid = _systransid;
@synthesize rspmsg = _rspmsg;
@synthesize flag = _flag;


- (id) init {
	self = [super init];
    
	return self;
}

@end

