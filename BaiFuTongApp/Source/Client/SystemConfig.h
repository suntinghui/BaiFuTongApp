//
//  SystemConfig.h
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemConfig : NSObject
{
    BOOL                _sendSMS;
    NSInteger           _pageSize;
    NSInteger           _historyInterval;
    NSInteger           _maxReversalCount;
    NSInteger           _maxUploadSignImageCount;
    NSInteger           _maxTransferTimeout;
    NSInteger           _maxLockTimeout;
}

@property (nonatomic, assign) BOOL          sendSMS;
@property (nonatomic, assign) NSInteger     pageSize;
@property (nonatomic, assign) NSInteger     historyInterval;
@property (nonatomic, assign) NSInteger     maxReversalCount;
@property (nonatomic, assign) NSInteger     maxUploadSignImageCount;
@property (nonatomic, assign) NSInteger     maxTransferTimeout;
@property (nonatomic, assign) NSInteger     maxLockTimeout;

+ (SystemConfig *) sharedSystemConfig;

- (void) loadParams:(NSDictionary *) dic;

@end
