//
//  DateUtil.h
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

// 将yyyyMMdd格式的字符串转化成NSDate
+ (NSDate *) string2Date:(NSString *) yyyyMMdd;
// yyyyMMdd -> MMdd
+ (NSString *) formatMonthDay:(NSString *) yyyyMMdd;
// yyyyMMdd -> yyyy-MM-dd
+ (NSString *) formatDateString:(NSString *) yyyyMMdd;
// 将日期转换为yyyy-MM-dd格式的字符串
+ (NSString *) getDateStringWithDate:(NSDate *) date;
// 将日期转换为yyyy-MM-dd格式的字符串
+ (NSString *) getDateStringWithDate2:(NSDate *) date;
// 将日期转换为HHmmss格式的字符串
+ (NSString *) getTimeStringWithDate:(NSDate *) date;
// 取得手机的日期时间 MMddHHmmss
+ (NSString *) getSystemDateTime;
// 取得手机的日期时间 yyyyMMddHHmmss
+ (NSString *) getSystemDateTime2;
// 取得手机日期 yyyy-MM-dd
+ (NSString *) getSystemDate;
// 取得手机日期 yyyyMMdd
+ (NSString *) getSystemDate2;
// 取得手机日期 MMdd
+ (NSString *) getSystemMonthDay;
// 取得手机时间 HHmmss
+ (NSString *) getSystemTime;
// HHmmss -> HH:mm:ss
+ (NSString *) formatTimeString:(NSString *) HHmmss;
// 将yyyyMMddhhmmss格式的数据转化为yyyy-MM-dd hh:mm:ss格式
+ (NSString *) formatDateTime:(NSString *) yyyyMMddHHmmss;
// MMdd -> MM-dd
+ (NSString *) formMMddByDash:(NSString *) MMdd;
// 计算两个日期之间相差的天数
+ (int) dayIntervalSinceDate:(NSDate *) startDate endDate:(NSDate *) endDate;
// 获取自1970年以来的秒数
+ (double) currentTimeMillis;

@end