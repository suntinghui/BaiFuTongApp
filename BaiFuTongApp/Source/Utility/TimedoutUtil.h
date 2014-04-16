//
//  TimedoutUtil.h
//  POS2iPhone
//
//  Created by  STH on 4/27/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimedoutUtil : NSObject


@property (nonatomic, strong) NSTimer *timer;

+ (TimedoutUtil *) sharedInstance;

- (void) start;
- (void) updateLastedTime;

@end
