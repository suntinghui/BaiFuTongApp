//
//  FieldModel.h
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FieldModel : NSObject
{
    NSString            *_key;
    NSString            *_value;
    BOOL                _macField;
}

@property (nonatomic, strong) NSString                          *key;
@property (nonatomic, strong) NSString                          *value;
@property (nonatomic, assign, readonly) BOOL                    macField;

- (void) setMac:(NSString *) value;

@end
