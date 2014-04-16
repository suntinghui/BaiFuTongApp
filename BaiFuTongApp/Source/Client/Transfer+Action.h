//
//  TransferLogicCore.h
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

// IOS中虽然可能有更好的逻辑实现方式，但是为了考虑与Android逻辑的一致性，便于维护，仍然沿用Android的实现思路。。。

#import <Foundation/Foundation.h>
#import "Transfer.h"

@interface Transfer (Action)

- (void) actionDone;

- (void) updateWorkingKeyDone;

- (BOOL) reversalAction;

- (void) uploadSignImageAction;

- (void) uploadSignImageDone;

@end
