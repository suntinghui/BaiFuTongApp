//
//  CityModel.h
//  YLTiPhone
//
//  Created by xushuang on 14-1-20.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
{
    NSString            *_code;
    NSString            *_name;
    NSString            *_parentCode;
}

@property (nonatomic, strong) NSString    *code;
@property (nonatomic, strong) NSString    *name;
@property (nonatomic, strong) NSString    *parentCode;

@end
