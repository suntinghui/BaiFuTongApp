//
//  SuccessTransferModel.m
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "SuccessTransferModel.h"
#import "RegexKitLite.h"
#import "DateUtil.h"

@implementation SuccessTransferModel

@synthesize traceNum = _traceNum;
@synthesize transCode = _transCode;
@synthesize date = _date;
@synthesize amount = _amount;
@synthesize content = _content;

- (void) setDate:(NSString *)theDate
{
    if (nil != theDate && [theDate isMatchedByRegex:@"^\\d{4}-\\d{2}-\\d{2}$"]){
        _date = theDate;
    } else {
        _date = [DateUtil formatDateString:theDate];
    }
}

@end
