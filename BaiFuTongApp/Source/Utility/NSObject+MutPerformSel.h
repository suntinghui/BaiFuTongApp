//
//  NSObject+MutPerformSel.h
//  POS2iPhone
//
//  Created by  STH on 1/18/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MutPerformSel)

//执行多个参数的方法
- (id) performSelector:(SEL)aSelector withMultiObjects:(id)object,...;

@end
