//
//  TimedoutUtil.m
//  POS2iPhone
//
//  Created by  STH on 4/27/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "TimedoutUtil.h"
#import "DateUtil.h"
#import "SystemConfig.h"

@implementation TimedoutUtil

@synthesize timer = _timer;

static TimedoutUtil *instance = nil;

+ (TimedoutUtil *) sharedInstance
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[TimedoutUtil alloc] init];
        }
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

- (void) start
{
    [self updateLastedTime];
    
    // 每30秒钟检测一次超时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(checkTimedout) userInfo:nil repeats:YES];
}

- (void) checkTimedout
{
    double currentTime = [DateUtil currentTimeMillis];
    if (currentTime - lastedTime > 60 * [SystemConfig sharedSystemConfig].maxLockTimeout) {
        [self.timer invalidate];
        
        ApplicationDelegate.hasLogin = NO;
        [ApplicationDelegate.rootNavigationController popToRootViewControllerAnimated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"由于您长时间没有操作完美支付，系统超时退出，请您重新登陆。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

static double lastedTime;
- (void) updateLastedTime
{
    lastedTime = [DateUtil currentTimeMillis];
}

@end
