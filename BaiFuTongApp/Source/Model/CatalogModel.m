//
//  CatalogModel.m
//  POS2iPhone
//
//  Created by  STH on 12/4/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "CatalogModel.h"

@implementation CatalogModel

@synthesize catalogId = _catalogId;
@synthesize title = _title;
@synthesize parentId = _parentId;
@synthesize actionId = _actionId;
@synthesize action = _action;
@synthesize actionType = _actionType;
@synthesize iconId = _iconId;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.title];
}

@end
