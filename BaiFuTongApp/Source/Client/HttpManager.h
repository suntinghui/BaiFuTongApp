//
//  HttpManager.h
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

@interface HttpManager : MKNetworkEngine

typedef void (^TransferSuccessBlack) (NSDictionary *respDic);

+ (HttpManager *) sharedHttpManager;

- (MKNetworkOperation *) transfer:(NSDictionary *) reqDic
                   successHandler:(TransferSuccessBlack) successBlock
                     errorHandler:(MKNKErrorBlock) errorBlock;

@end
