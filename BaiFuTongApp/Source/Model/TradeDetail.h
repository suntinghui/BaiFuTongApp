//
//  TradeDetail.h
//  POS2iPhone
//
//  Created by jia liao on 1/15/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeDetail : NSObject

@property(nonatomic, strong)NSString *aimCardNo;
@property(nonatomic, strong)NSString *batchNo;
@property(nonatomic, strong)NSString *cardNo;
@property(nonatomic, strong)NSString *hostSerial;
@property(nonatomic, strong)NSString *issueBank;
@property(nonatomic, strong)NSString *merchId;
@property(nonatomic, strong)NSString *settleDate;
@property(nonatomic, strong)NSString *settleFlag;
@property(nonatomic, strong)NSString *termId;
@property(nonatomic, strong)NSString *tranAmt;
@property(nonatomic, strong)NSString *tranDate;
@property(nonatomic, strong)NSString *tranSerial;
@property(nonatomic, strong)NSString *tranTime;
@property(nonatomic, strong)NSString *tranCode;
@property(nonatomic, strong)NSString *tranFlag;

-(TradeDetail *)initWithString:(NSString*)detail;
@end
