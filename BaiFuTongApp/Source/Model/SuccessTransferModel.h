//
//  SuccessTransferModel.h
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuccessTransferModel : NSObject
{
    @private
    NSString            *_traceNum;
    NSString            *transCode;
    NSString            *_date;
    NSString            *_amount;
    NSDictionary        *_content;
}

@property (nonatomic, strong) NSString                  *traceNum;
@property (nonatomic, strong) NSString                  *transCode;
@property (nonatomic, strong, setter = setDate:) NSString                  *date;
@property (nonatomic, strong) NSString                  *amount;
@property (nonatomic, strong) NSDictionary              *content;

- (void) setDate:(NSString *)date;

@end
