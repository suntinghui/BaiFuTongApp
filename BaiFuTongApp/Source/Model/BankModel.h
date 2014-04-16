//
//  BankModel.h
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject
{
    NSString            *_code;
    NSString            *_name;
}

@property (nonatomic, strong) NSString    *code;
@property (nonatomic, strong) NSString    *name;

@end
