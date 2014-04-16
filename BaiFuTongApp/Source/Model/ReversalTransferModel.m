//
//  ReversalTransferModel.m
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "ReversalTransferModel.h"
#import "RegexKitLite.h"
#import "DateUtil.h"

@implementation ReversalTransferModel

@synthesize traceNum = _traceNum;
@synthesize batchNum = _batchNum;
@synthesize date = _date;
@synthesize content = _content;
@synthesize state = _state;
@synthesize count = _count;

- (id)init
{
    if (self = [super init]){
        self.state = 1; // 1为失败，０为成功
        self.count = 0;
    }
    
    return self;
}

- (void) setDate:(NSString *)theDate
{
    if (nil != theDate && [theDate isMatchedByRegex:@"^\\d{4}-\\d{2}-\\d{2}$"]){
        _date = theDate;
    } else {
        _date = [DateUtil formatDateString:theDate];
    }
}

@end
