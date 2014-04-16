//
//  StringUtil.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

// 格式化银行卡号
+ (NSString *) formatAccountNo:(NSString *) accountNo;

// 利用JSONKit，将NSString转换为NSDictionary
+ (NSDictionary *) string2Dictionary:(NSString *) jsonStr;
// 利用JSONKit，将NSDictionary转换为NSString
+ (NSString *) dictionary2String:(NSDictionary *) dict;

// 将金额转化银联要求的12位长字符串格式  1,112.08 -> 0000000001208
+ (NSString *) amount2String:(NSString *) amount;
// 将12位长字符串转换为带符号的币种表示
+ (NSString *) string2SymbolAmount:(NSString *) str;
// 将12位长字符串转换为不带符号的币种表示
+ (NSString *) string2AmountFloat:(NSString *) str;
// 用户输入金额时，将金额转化成标准格式 1298.09 -> 1,298.09
+ (NSString *) formatAmount:(NSString *) amount;

+ (NSString *) getUUID;

+ (NSString *) ASCII2Hex:(NSString *) asciiStr;

// NSString to char *
+ (char *) string2char:(NSString *) str;


@end
