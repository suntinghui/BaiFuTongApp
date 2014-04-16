//
//  TradeDetail.m
//  POS2iPhone
//
//  Created by jia liao on 1/15/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "TradeDetail.h"
#import "DateUtil.h"
#import "StringUtil.h"

@implementation TradeDetail

@synthesize aimCardNo = _aimCardNo;
@synthesize batchNo = _batchNo;
@synthesize cardNo = _cardNo;
@synthesize hostSerial = _hostSerial;
@synthesize issueBank = _issueBank;
@synthesize merchId = _merchId;
@synthesize settleDate = _settleDate;
@synthesize settleFlag = _settleFlag;
@synthesize termId = _termId;
@synthesize tranAmt = _tranAmt;
@synthesize tranDate = _tranDate;
@synthesize tranSerial = _tranSerial;
@synthesize tranTime = _tranTime;
@synthesize tranCode = _tranCode;
@synthesize tranFlag = _tranFlag;

-(TradeDetail *)initWithString:(NSString*)detail
{
    self = [super init];
    if (self && detail) {
        NSArray *array = [detail componentsSeparatedByString:@"^"];
        
        _aimCardNo = [StringUtil formatAccountNo:[[(NSString*)[array objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:1]];
        _batchNo = [[(NSString*)[array objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
        _cardNo = [StringUtil formatAccountNo:[[(NSString*)[array objectAtIndex:2] componentsSeparatedByString:@":"] objectAtIndex:1]];
        _hostSerial = [[(NSString*)[array objectAtIndex:3] componentsSeparatedByString:@":"] objectAtIndex:1];
        _issueBank = [[(NSString*)[array objectAtIndex:4] componentsSeparatedByString:@":"] objectAtIndex:1];
        _merchId = [[(NSString*)[array objectAtIndex:5] componentsSeparatedByString:@":"] objectAtIndex:1];
        _settleDate = [DateUtil formatDateString:[[(NSString*)[array objectAtIndex:6] componentsSeparatedByString:@":"] objectAtIndex:1]];
        _settleFlag = [[(NSString*)[array objectAtIndex:7] componentsSeparatedByString:@":"] objectAtIndex:1];
        _termId = [[(NSString*)[array objectAtIndex:8] componentsSeparatedByString:@":"] objectAtIndex:1];
        _tranAmt = [StringUtil string2SymbolAmount:[StringUtil amount2String:[[(NSString*)[array objectAtIndex:9] componentsSeparatedByString:@":"] objectAtIndex:1]]];
        _tranDate = [DateUtil formatDateString:[[(NSString*)[array objectAtIndex:10] componentsSeparatedByString:@":"] objectAtIndex:1]];
        _tranSerial = [[(NSString*)[array objectAtIndex:11] componentsSeparatedByString:@":"] objectAtIndex:1];
        _tranTime = [DateUtil formatTimeString:[[(NSString*)[array objectAtIndex:12] componentsSeparatedByString:@":"] objectAtIndex:1]];
        _tranCode = [[(NSString*)[array objectAtIndex:13] componentsSeparatedByString:@":"] objectAtIndex:1];
        _tranFlag = [[(NSString*)[array objectAtIndex:14] componentsSeparatedByString:@":"] objectAtIndex:1];
    }
    
    return self;
}
@end
