//
//  DemoClient.h
//  POS2iPhone
//
//  Created by  STH on 2/21/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoClient : NSObject

+ (NSString *) getMessageWithTranCode:(NSString *) transferCode;

+ (void) setDemoAmount:(NSString *) amount;
+ (NSString *) demoAmount;

+ (void) setDemoAccountNo:(NSString *) no;
+ (NSString *) demoAccountNo;


@end
