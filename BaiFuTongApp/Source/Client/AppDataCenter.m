//
//  AppDataCenter.m
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "AppDataCenter.h"
#import "DateUtil.h"
#import "ParseXMLUtil.h"
#import "StringUtil.h"

@interface AppDataCenter ()

// 取系统追踪号，6个字节数字定长域
- (NSString *) getTraceAuditNum;
- (NSString *) getBatchNum;
- (NSString *) getUUID;
- (NSString *) getCurrentVersion;
// 只在注册和登陆时使用该方法。
- (NSString *) getPhoneNum;
// 在交易页面调用
- (NSString *) getPhoneNumWithLabel;
- (NSString *) getMercherName;

@end

@implementation AppDataCenter

@synthesize __PSAMNO,__TERSERIALNO,__PSAMRANDOM,__PSAMPIN,__PSAMMAC,__PSAMTRACK,__PAN,__ENCCARDNO,__VENDOR,__TERID,__CARDNO,__FIELD22;
@synthesize __TRACEAUDITNUM,__BATCHNUM,__ADDRESS,__PHONENUM,__CURRENTVERSION,__VERSIONCODE,__SERVEREDATE;
@synthesize transferNameDic = _transferNameDic;
@synthesize reversalDic = _reversalDic;

static AppDataCenter *instance = nil;

/*
 synchronized   这个主要是考虑多线程的程序，这个指令可以将{ } 内的代码限制在一个线程执行，如果某个线程没有执行完，其他的线程如果需要执行就得等着。
 */
+ (AppDataCenter *) sharedAppDataCenter
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[AppDataCenter alloc] init];
        }
    }
    
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        __VERSIONCODE = 0;
        __ADDRESS = @"UNKNOWN";
        __FIELD22 = @"021";
        __SERVEREDATE = [DateUtil getSystemDate2];
    }
    
    return self;
}

/*
 是从制定的内存区域读取信息创建实例，所以如果需要的单例已经有了，就需要禁止修改当前单例。所以返回 nil
 */
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

// 必须全大写
- (NSString *) getValueWithKey:(NSString *) key
{
    NSString *property = [[key uppercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([property isEqualToString:@"__TRACEAUDITNUM"]){
        return [self getTraceAuditNum];
    } else if ([property isEqualToString:@"__BATCHNUM"]){
        return [self getBatchNum];
    } else if ([property isEqualToString:@"__YYYYMMDD"]){
        return [DateUtil getSystemDate2];
    } else if ([property isEqualToString:@"__YYYY-MM-DD"]){
        return [DateUtil getSystemDate];
    } else if ([property isEqualToString:@"__HHMMSS"]) {
        return [DateUtil getSystemTime];
    } else if ([property isEqualToString:@"__MMDD"]){
        return [DateUtil getSystemMonthDay];
    } else if ([property isEqualToString:@"__UUID"]){
        return [self getUUID];
    } else if ([property isEqualToString:@"__PHONENUM"]){
        return [self getPhoneNum];
    } else if ([property isEqualToString:@"__PHONENUMWITHLABEL"]){
        return [self getPhoneNumWithLabel];
    } else if ([property isEqualToString:@"__CURRENTVERSION"]){
        return [self getCurrentVersion];
    } else if ([property isEqualToString:@"__VERSIONCODE"]){
        return [self getCurrentVersion];
    } else if ([property isEqualToString:@"__MERCHERNAME"]){
        return [self getMercherName];
    } else {
        SEL selector = NSSelectorFromString(property);
        if ([self respondsToSelector:selector]) {
            // warning:performSelector may cause a leak because its selector is unknown
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [self performSelector:selector];
            #pragma clang diagnostic pop
        } else {
            NSLog(@"ERROR:NOT FOUNT KEY : %@ IN getValue METHOD !", key);
        }
        
        
    }
    
    return @"";
}

- (NSString *) getTraceAuditNum
{
    NSInteger number = [UserDefaults integerForKey:TRACEAUDITNUM];
    if (number == 0) {
        number = 1;
    }
    
    [UserDefaults setInteger:(number+1)==1000000?1:(number+1) forKey:TRACEAUDITNUM];
    [UserDefaults synchronize];
    
    __TRACEAUDITNUM = [NSString stringWithFormat:@"%06d", number];
    
    return self.__TRACEAUDITNUM;
}

// 签到后更新批次号
- (void) setBatchNum:(NSString *) batchNum
{
    __BATCHNUM = [NSString stringWithString:batchNum];
    
    [UserDefaults setObject:batchNum forKey:BATCHNUM];
    [UserDefaults synchronize];
}

- (NSString *) getBatchNum
{
    if (__BATCHNUM) {
        return __BATCHNUM;
    } 
    
    __BATCHNUM = [UserDefaults stringForKey:BATCHNUM];
    if (__BATCHNUM == nil) {
        __BATCHNUM = @"000001";
    }
    
    return __BATCHNUM;
}

- (NSString *) getUUID
{
    return [UserDefaults stringForKey:UUIDSTRING] == nil ? @"" : [UserDefaults stringForKey:UUIDSTRING];
}

- (NSString *) getMercherName
{
#ifdef DEMO
    return @"中国联通";
#else
    return [UserDefaults stringForKey:MERCHERNAME] == nil ? @"" : [UserDefaults stringForKey:MERCHERNAME];
#endif
    
}

- (NSString *) getCurrentVersion
{
    NSInteger currentVersion = [UserDefaults integerForKey:VERSION];
    return __CURRENTVERSION = [NSString stringWithFormat:@"%d", currentVersion];
}

- (void) setPhoneNum:(NSString *) phoneNum
{
    __PHONENUM = [NSString stringWithString:phoneNum];
    
    [UserDefaults setObject:phoneNum forKey:PHONENUM];
    [UserDefaults synchronize];
}

- (void) setAddress:(NSString *) addr
{
    __ADDRESS = [NSString stringWithString:addr];
}
    
// 只在注册和登陆时使用该方法。
- (NSString *) getPhoneNum
{
    if (__PHONENUM) {
        return __PHONENUM;
    }
    
    __PHONENUM = [UserDefaults stringForKey:PHONENUM];
    if (__PHONENUM == nil) {
        __PHONENUM = @"";
    }
    
    return __PHONENUM;
}

// 在交易页面调用
- (NSString *) getPhoneNumWithLabel
{
    return [NSString stringWithFormat:@"注册号码:%@", [self getPhoneNum]];
}

- (void) setVersionCode:(NSInteger) versionCode
{
    __VERSIONCODE = versionCode;
}

- (void) setServerDate:(NSString *) date
{
    __SERVEREDATE = [NSString stringWithString:date];
}

- (NSString *) getServerDate
{
    return [DateUtil formatDateString:__SERVEREDATE];
}

- (NSDictionary *)transferNameDic
{
    if (nil == _transferNameDic || [_transferNameDic count] == 0) {
        _transferNameDic = [ParseXMLUtil parseTransferMapXML];
    }
    
    return _transferNameDic;
}

- (NSDictionary *)reversalDic
{
    if (nil == _reversalDic || [_reversalDic count] == 0) {
        _reversalDic = [ParseXMLUtil parseReversalMapXML];
    }
    
    return _reversalDic;
}

@end
