//
//  DateUtil.m
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "DateUtil.h"
#import "RegexKitLite.h"

@implementation DateUtil

+ (NSDate *) string2Date:(NSString *) yyyyMMdd
{
    if (nil != yyyyMMdd && [yyyyMMdd isMatchedByRegex:@"^\\d{8}$"]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateFormat: @"yyyyMMdd"];
        NSDate *destDate= [dateFormatter dateFromString:yyyyMMdd];
        return destDate;
    }

    NSLog(@"DateUtil->string2Date : The parameter is illegal");
    return [NSDate date];
}

+ (NSString *) formatMonthDay:(NSString *) yyyyMMdd
{
    if (nil != yyyyMMdd && [yyyyMMdd isMatchedByRegex:@"^\\d{8}$"]){
        return [yyyyMMdd substringFromIndex:4];
    }
    
    NSLog(@"DateUtil->formatMonthDay : The parameter is illegal");
    return yyyyMMdd;
}

+ (NSString *) formatDateString:(NSString *) yyyyMMdd
{
    if (nil != yyyyMMdd && [yyyyMMdd isMatchedByRegex:@"^\\d{8}$"]){
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:yyyyMMdd];
        [mutableStr insertString:@"-" atIndex:4];
        [mutableStr insertString:@"-" atIndex:7];
        
        return mutableStr;
    }
    
    NSLog(@"DateUtil->formatDateString : The parameter is illegal");
    return yyyyMMdd;
}

+ (NSString *) getDateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm:ss zzz -- zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *) getDateStringWithDate2:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm:ss zzz -- zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *) getTimeStringWithDate:(NSDate *) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm:ss zzz -- zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *) getSystemDateTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm:ss zzz -- zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"MMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    return destDateString;
}

+ (NSString *) getSystemDateTime2
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //yyyy-MM-dd HH:mm:ss zzz -- zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    return destDateString;
}

+ (NSString *) getSystemDate
{
    return [self getDateStringWithDate:[NSDate date]];
}

+ (NSString *) getSystemDate2
{
    return [self getDateStringWithDate2:[NSDate date]];
}

+ (NSString *) getSystemMonthDay
{
    return [[self getDateStringWithDate2:[NSDate date]] substringFromIndex:4];
}

+ (NSString *) getSystemTime
{
    return [self getTimeStringWithDate:[NSDate date]];
}


+ (NSString *) formatTimeString:(NSString *) HHmmss
{
    if (nil != HHmmss && [HHmmss isMatchedByRegex:@"^\\d{6}$"]){
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:HHmmss];
        [mutableStr insertString:@":" atIndex:2];
        [mutableStr insertString:@":" atIndex:5];
        
        return mutableStr;
    }
    
    NSLog(@"DateUtil->formatTimeString : The parameter is illegal");
    return HHmmss;
}

+ (NSString *) formatDateTime:(NSString *) yyyyMMddHHmmss
{
    if (nil != yyyyMMddHHmmss && [yyyyMMddHHmmss isMatchedByRegex:@"^\\d{14}$"]){
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat: @"yyyyMMddHHmmss"];
        NSDate *destDate= [dateFormatter1 dateFromString:yyyyMMddHHmmss];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [dateFormatter2 stringFromDate:destDate];
    }
    
    NSLog(@"DateUtil->formatDateTime : The parameter is illegal");
    return yyyyMMddHHmmss;
}

+ (NSString *) formMMddByDash:(NSString *) MMdd
{
    if (nil != MMdd && [MMdd isMatchedByRegex:@"^\\d{4}$"]){
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:MMdd];
        [mutableStr insertString:@"-" atIndex:2];
        
        return mutableStr;
    }
    
    NSLog(@"DateUtil->formMMddByDash : The parameter is illegal");
    return MMdd;
}

+ (int) dayIntervalSinceDate:(NSDate *) startDate endDate:(NSDate *) endDate
{
    return [endDate timeIntervalSinceDate:startDate]/(3600*24);
}

+ (double) currentTimeMillis
{
    // [[NSDate date] timeIntervalSince1970] 返回的数值是以 “秒” 为单位的
    return [[NSDate date] timeIntervalSince1970];
}

@end
