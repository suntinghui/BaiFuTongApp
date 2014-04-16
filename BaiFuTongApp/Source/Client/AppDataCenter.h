//
//  AppDataCenter.h
//  POS2iPhone
//
//  Created by  STH on 11/28/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <voclib/vcom.h>

@interface AppDataCenter : NSObject
{
    @private
    // FSK相关
	NSString                        *__PSAMNO ; // psam卡号 8
	NSString                        *__TERSERIALNO; // 终端序列号 -  20
	NSString                        *__PSAMRANDOM; // 随机数
	NSString                        *__PSAMPIN; // pin密文
	NSString                        *__PSAMMAC; // mac密文
	NSString                        *__PSAMTRACK; // 磁道密文
	NSString                        *__PAN; // PAN
	NSString                        *__ENCCARDNO; // 卡号密文
	NSString                        *__VENDOR; // 商户号
	NSString                        *__TERID; // 终端号
	NSString                        *__CARDNO; // 磁卡卡号
    NSString                        *__FIELD22; // 如果交易输入了密码，取值为：021，如果未输入密码，取值为：022
    
    // 其他参数
    NSString                        *__TRACEAUDITNUM;// 系统追踪号
    NSString                        *__BATCHNUM; // 批次号
    NSString                        *__ADDRESS;
    NSString                        *__PHONENUM;
    NSString                        *__CURRENTVERSION;
    NSInteger                       __VERSIONCODE;
    
    NSString                        *__SERVEREDATE;
    
    NSDictionary                    *_transferNameDic;
    NSDictionary                    *_reversalDic;
}

@property (nonatomic, strong) NSString                              *__PSAMNO;
@property (nonatomic, strong) NSString                              *__TERSERIALNO;
@property (nonatomic, strong) NSString                              *__PSAMRANDOM;
@property (nonatomic, strong) NSString                              *__PSAMPIN;
@property (nonatomic, strong) NSString                              *__PSAMMAC;
@property (nonatomic, strong) NSString                              *__PSAMTRACK;
@property (nonatomic, strong) NSString                              *__PAN;
@property (nonatomic, strong) NSString                              *__ENCCARDNO;
@property (nonatomic, strong) NSString                              *__VENDOR;
@property (nonatomic, strong) NSString                              *__TERID;
@property (nonatomic, strong) NSString                              *__CARDNO;
@property (nonatomic, strong) NSString                              *__FIELD22;

@property (nonatomic, strong, readonly) NSString                    *__TRACEAUDITNUM;
@property (nonatomic, strong, readonly) NSString                    *__BATCHNUM;
@property (nonatomic, strong, readonly) NSString                    *__ADDRESS;
@property (nonatomic, strong, readonly) NSString                    *__PHONENUM;
@property (nonatomic, strong, readonly) NSString                    *__CURRENTVERSION;
@property (nonatomic, assign, readonly) NSInteger                   __VERSIONCODE;
@property (nonatomic, strong, readonly) NSString                    *__SERVEREDATE;

@property (nonatomic, strong, readonly) NSDictionary                *transferNameDic;
@property (nonatomic, strong, readonly) NSDictionary                *reversalDic;


+ (AppDataCenter *) sharedAppDataCenter;

- (NSString *) getValueWithKey:(NSString *) key;
- (void) setBatchNum:(NSString *) batchNum;
- (void) setPhoneNum:(NSString *) phoneNum;
- (void) setAddress:(NSString *) addr;
- (void) setVersionCode:(NSInteger) versionCode;
- (void) setServerDate:(NSString *) date;
- (NSString *) getServerDate;

@end
