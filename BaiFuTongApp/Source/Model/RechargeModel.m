//
//  RechargeModel.m
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "RechargeModel.h"

@implementation RechargeModel

@synthesize faceValue = _faceValue;
@synthesize sellingPrice = _sellingPrice;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@元 (售价 %@元)", self.faceValue, self.sellingPrice];
}

@end
