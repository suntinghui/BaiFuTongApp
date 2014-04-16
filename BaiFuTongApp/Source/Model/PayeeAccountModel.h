//
//  PayeeAccountModel.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayeeAccountModel : NSObject
{
    @private
    NSString        *_accountNo;
    NSString        *_accountName;
    NSString        *_phoneNo;
    
    NSString        *_bankName;
    NSString        *_bankCode;
    
}

@property (nonatomic, strong) NSString          *accountNo;
@property (nonatomic, strong) NSString          *accountName;
@property (nonatomic, strong) NSString          *phoneNo;

@property (nonatomic, strong) NSString          *bankName;
@property (nonatomic, strong) NSString          *bankCode;


@end
