//
//  CatalogModel.h
//  POS2iPhone
//
//  Created by  STH on 12/4/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatalogModel : NSObject
{
    NSInteger           _catalogId;
    NSString            *_title;
    NSInteger           _parentId;
    NSString            *_actionId;
    NSString            *_action;
    NSString            *_actionType;
    NSInteger           _iconId;
}

@property (nonatomic, assign) NSInteger                 catalogId;
@property (nonatomic, strong) NSString                  *title;
@property (nonatomic, assign) NSInteger                 parentId;
@property (nonatomic, strong) NSString                  *actionId;
@property (nonatomic, strong) NSString                  *action;
@property (nonatomic, strong) NSString                  *actionType;
@property (nonatomic, assign) NSInteger                 iconId;

@end
