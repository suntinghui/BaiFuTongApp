//
//  ReversalTransferModel.h
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReversalTransferModel : NSObject
{
    @private
    NSString                *_traceNum;
    NSString                *_batchNum;
    NSString                *_date;
    NSDictionary            *_content;
    NSInteger               _state;
    NSInteger               _count;
}

@property (nonatomic, strong) NSString                              *traceNum;
@property (nonatomic, strong) NSString                              *batchNum;
@property (nonatomic, strong, setter = setDate:) NSString           *date;
@property (nonatomic, strong) NSDictionary                          *content;
@property (nonatomic, assign) NSInteger                             state;
@property (nonatomic, assign) NSInteger                             count;

- (void) setDate:(NSString *)date;

@end
