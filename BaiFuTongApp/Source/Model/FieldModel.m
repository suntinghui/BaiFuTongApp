//
//  FieldModel.m
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "FieldModel.h"

@implementation FieldModel

@synthesize key = _key;
@synthesize value = _value;
@synthesize macField = _macField;

- (id)init
{
    if (self = [super init]) {
        _key = @"";
        _value = @"";
        _macField = NO;
    }
    
    return self;
}

- (void) setMac:(NSString *) value
{
    if (value == nil) {
        _macField = NO;
        return;
    }
    
    if ([value hasPrefix:@"t"] || [value hasPrefix:@"T"] || [value hasPrefix:@"y"] || [value hasPrefix:@"Y"]) {
        _macField = YES;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"key:%@, value:%@, macField:%@", self.key, self.value, self.macField?@"YES":@"NO"];
}


@end
