//
//  PayeeAccountModel.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "PayeeAccountModel.h"
#import "StringUtil.h"

@implementation PayeeAccountModel

@synthesize accountNo = _accountNo;
@synthesize accountName = _accountName;
@synthesize phoneNo = _phoneNo;

@synthesize bankCode = _bankCode;
@synthesize bankName = _bankName;

- (NSString *)description
{
    return [StringUtil formatAccountNo:self.accountNo];
}


@end
