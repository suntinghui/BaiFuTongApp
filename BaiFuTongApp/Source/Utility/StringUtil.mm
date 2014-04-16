//
//  StringUtil.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "StringUtil.h"
#import "JSONKit.h"

@implementation StringUtil

+ (NSString *) formatAccountNo:(NSString *) accountNo
{
    @try {
        NSMutableString *mutableString1 = [NSMutableString string];
        
        // 如果直接将表达式写在for内部，当长度为负数时出现死循环，疑似编译器漏洞。。。
        int length = [accountNo length] - 10;
        for (int i=0; i<length; i++) {
            [mutableString1 appendString:@"*"];
        }
        
        NSMutableString *mutableString2 = [NSMutableString stringWithString:accountNo];
        [mutableString2 replaceCharactersInRange:NSMakeRange(6, [mutableString1 length]) withString:mutableString1];
        
        return mutableString2;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return accountNo;
    }
}

+ (NSDictionary *) string2Dictionary:(NSString *) jsonStr;
{
    return [jsonStr objectFromJSONString];
}

+ (NSString *) dictionary2String:(NSDictionary *) dict
{
    return [dict JSONString];
}

+ (NSString *) amount2String:(NSString *) amount
{
    NSString *tempStr = [amount stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSMutableString *tempMutableStr = [NSMutableString stringWithString:tempStr];
    if ([tempStr rangeOfString:@"."].location == NSNotFound) {
        [tempMutableStr appendString:@"00"];
        
    } else if ([tempStr rangeOfString:@"."].location == tempStr.length - 1) {
        [tempMutableStr appendString:@"00"];
        
    } else if ([tempStr rangeOfString:@"."].location == tempStr.length - 2) {
        [tempMutableStr appendString:@"0"];
        
    } else if ([tempStr rangeOfString:@"."].location == tempStr.length - 3) {
        
    }
    
    tempMutableStr = [NSMutableString stringWithString:[tempMutableStr stringByReplacingOccurrencesOfString:@"." withString:@""]];

    int l = 12 - [tempMutableStr length];
    for (int i=0; i<l; i++) {
        [tempMutableStr insertString:@"0" atIndex:0];
    }
    
    return tempMutableStr;
}

+ (NSString *) string2SymbolAmount:(NSString *) str
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str longLongValue]/100.0]];
}

+ (NSString *) string2AmountFloat:(NSString *) str
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"###.00"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[str longLongValue]/100.0]];
}

+ (NSString *) formatAmount:(NSString *) amount
{
    
    return [self string2AmountFloat:[self amount2String:amount]];
}

+ (NSString *) getUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *) ASCII2Hex:(NSString *) asciiStr
{
    NSMutableString * newString = [[NSMutableString alloc] init];
    int i = 0;
    while (i < [asciiStr length])
    {
        NSString * hexChar = [asciiStr substringWithRange: NSMakeRange(i, 2)];
        int value = 0;
        sscanf([hexChar cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        [newString appendFormat:@"%c", (char)value];
        i+=2;
    }
    
    return newString;
}

+ (char *) string2char:(NSString *) str
{
    if (str == nil) {
        return [self string2char:@""];
    }
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    const char* cpc = [str cStringUsingEncoding:enc];
    char* pc = new char[[str length]];
    strcpy(pc, cpc);
    
    return pc;
}

@end
