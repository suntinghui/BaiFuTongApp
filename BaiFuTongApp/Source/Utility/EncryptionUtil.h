//
//  EncryptionUtil.h
//  POS2iPhone
//
//  Created by  STH on 11/30/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionUtil : NSObject

// MD5加密
+ (NSString *) MD5Encrypt:(NSString *) srcStr;
// 解析公钥字符串，得到mod exp，其key分别为mod和exp
+ (NSDictionary *) parsePublickey:(NSString *) publicKey;

+ (NSString *) rsaEncrypt:(NSString *) plainText;

+ (NSString *) rsaEncrypt2:(NSString *) plainText;

+ (void) TestRSAEncryAndDecry;

@end
