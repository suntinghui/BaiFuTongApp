//
//  RechargeModel.h
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeModel : NSObject
{
    NSString            *_faceValue; // 面值
    NSString            *_sellingPrice; // 实际售价
}

@property (nonatomic, strong) NSString      *faceValue;
@property (nonatomic, strong) NSString      *sellingPrice;

@end
