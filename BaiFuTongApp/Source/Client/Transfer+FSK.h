//
//  Transfer+FSK.h
//  POS2iPhone
//
//  Created by  STH on 1/16/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transfer.h"
#import <voclib/CSwiperStateChangedListener.h>

@interface Transfer (FSK) <CSwiperStateChangedListener>

- (void) initFSK;
- (void) fskAction;
- (void) invokeFSKCmd:(NSString *) cmd;
- (void) runFSKCmd;
- (NSArray *) parseArgs:(NSString *) argsStr;
- (void) setFSKArgs:(vcom_Result *) vs;
- (NSString *) getErrorMsg:(int) result;

@end
