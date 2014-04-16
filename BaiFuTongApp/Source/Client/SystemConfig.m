//
//  SystemConfig.m
//  POS2iPhone
//
//  Created by  STH on 11/29/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "SystemConfig.h"
#import "ParseXMLUtil.h"

@implementation SystemConfig

@synthesize sendSMS = _sendSMS;
@synthesize pageSize = _pageSize;
@synthesize historyInterval = _historyInterval;
@synthesize maxReversalCount = _maxReversalCount;
@synthesize maxTransferTimeout = _maxTransferTimeout;
@synthesize maxLockTimeout = _maxLockTimeout;


static SystemConfig *instance = nil;

+ (SystemConfig *) sharedSystemConfig
{
    @synchronized(self){
        if (nil == instance){
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}

- (id)init
{
    if (self = [super init]){
        self.sendSMS                = false;
        self.pageSize               = 5;
        self.historyInterval        = 30;
        self.maxReversalCount       = 3;
        self.maxTransferTimeout     = 60;
        self.maxLockTimeout         = 20;
    }
    
    return self;
}

- (void) loadParams:(NSDictionary *) dic
{
    if (nil == dic)
        return;
    
    for (NSString *key in [dic allKeys]){
        NSString *value = [dic objectForKey:key];
        
        if ([key caseInsensitiveCompare:@"sendSMS"] == NSOrderedSame) {
            [self setSendSMS:[value boolValue]];
            
        } else if ([key caseInsensitiveCompare:@"pageSize"] == NSOrderedSame){
            [self setPageSize:[value integerValue]];
            
        } else if ([key caseInsensitiveCompare:@"historyInterval"] == NSOrderedSame){
            [self setHistoryInterval:[value integerValue]];
            
        } else if ([key caseInsensitiveCompare:@"maxReversalCount"] == NSOrderedSame){
            [self setMaxReversalCount:[value integerValue]];
            
        } else if ([key caseInsensitiveCompare:@"maxUploadSignImageCount"] == NSOrderedSame){
            [self setMaxUploadSignImageCount:[value integerValue]];
            
        } else if ([key caseInsensitiveCompare:@"maxTransferTimeout"] == NSOrderedSame){
            [self setMaxTransferTimeout:[value integerValue]];
            
        } else if ([key caseInsensitiveCompare:@"maxLockTimeout"] == NSOrderedSame){
            [self setMaxLockTimeout:[value integerValue]];
            
        }
    }
    
}

@end
