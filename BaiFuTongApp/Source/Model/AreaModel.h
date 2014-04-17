//
//  AreaModel.h
//  YLTiPhone
//
//  Created by xushuang on 14-1-20.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
{
    NSString            *_code;
    NSString            *_name;
}

@property (nonatomic, strong) NSString    *code;
@property (nonatomic, strong) NSString    *name;

@end