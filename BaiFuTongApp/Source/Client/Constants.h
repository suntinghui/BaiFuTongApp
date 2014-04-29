//
//  Constants.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "AppDelegate.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define UserDefaults [NSUserDefaults standardUserDefaults]


// HTTP
#define HOST                                @"106.120.253.181:8443"
#define FILEURL                             @"http://106.120.253.181:8888/pos/xmlFiles/"

//#define HOST                                @"192.168.0.248:8443"
//#define FILEURL                             @"http://192.168.0.248:8888/pos/xmlFiles/"

//#define HOST                                @"192.168.1.126:8443"
//#define FILEURL                             @"http://192.168.1.126:8888/pos/xmlFiles/"

#define JSONURL                             @"pos/transfer.tx?CHANNEL=android&locale=ch"

//原以为iphone4和iphone5的self.view.bounds.size.height是不一样的，但错了，是一样的，都是548
//所以不能这么设定适配的屏幕高度　4和5没区别
//#define VIEWHEIGHT                          self.view.bounds.size.height - 105
//改成这样就OK了 其中105包括　20的状态条　44的导航 41的手机号码显示条
#define VIEWHEIGHT                          [UIScreen mainScreen].bounds.size.height - 105

#define ios7_y                              (DeviceVersion>=7 ? 50:0)
#define ios7_h                              (DeviceVersion>=7 ? -50:0)
#define iPhone5_height                         (iPhone5 ? 88:0)

//判断设备是否是iPhone5
#define iPhone5                             ([UIScreen instancesRespondToSelector:@selector (currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)

//判断设备是否是IOS7 systemVersion
#define DeviceVersion    [[[UIDevice currentDevice] systemVersion] floatValue]

// DataBase
#define kDataBaseName                       @"POS2iPhone.db"

#define kTransferSuccessTableName           @"TransferSuccessTable"
#define kReversalTableName                  @"ReversalTable"
#define kPayeeAccountTableName              @"PayeeAccountTable"
#define kUploadSignImageTableName           @"UploadSignImageTable"
#define kAnnouncementTableName              @"AnnouncementTable"

// NSUserDefault
#define TRACEAUDITNUM 						@"traceAuditNum"
#define BATCHNUM							@"batchNum"
#define PASSWORD							@"password"
#define PHONENUM							@"phoneNum"
#define VERSION                             @"version"

#define ALREAD_SHOWGUIDE                    @"ALREAD_SHOWGUIDE"

#define UUIDSTRING							@"UUIDString"

#define MERCHERNAME							@"mercherName"

// 程序中最新公告编号
#define SYSTEM_ANNOUNCEMENT_LASTEST_NUM		@"SystemAnnouncementLastestNum"
#define SERVER_ANNOUNCEMENT_LASTEST_NUM		@"ServerAnnouncementLastestNum"

// 流量相关值
#define TRAFFIC_MONTH						@"traffic_month"
#define MONTH_WIFISEND 						@"month_wifi_send"
#define MONTH_WIFIRECEIVE 					@"month_wifi_receive"
#define MONTH_MOBILESEND 					@"month_mobile_send"
#define MONTH_MOBILESRECEIVE 				@"month_mobile_receive"

#define TRAFFIC_DAY							@"traffic_day"
#define DAY_WIFISEND 						@"day_wifi_send"
#define DAY_WIFIRECEIVE 					@"day_wifi_receive"
#define DAY_MOBILESEND 						@"day_mobile_send"
#define DAY_MOBILESRECEIVE 					@"day_mobile_receive"

// 公钥相关值
#define PUBLICKEY_MOD						@"publickey_mod"
#define PUBLICKEY_EXP						@"publickey_exp"
#define PUBLICKEY_VERSION					@"publickey_version"
#define PUBLICKEY_TYPE						@"publickey_type"

#define INIT_PUBLICKEY_MOD					@ "D9D0D2224E6E84899184BBCD389F8EE08EB09EBA123948309804113B3F829D24D6093F1AFC153D113FAB8673114F4FABFDAAC9BB1B58B9E569B255BA4C338A2465642411A5EB0D68B78BB1B4E45AFF51580C3802AE01FF4DCF976D4CC681944C478FE3490A051F2B4894C321703C4D091E5365718509B20D23D78BBAD163E405"
#define INIT_PUBLICKEY_EXP					@"010001"

#define INIT_PUBLICKEY_VERSION				@"000000000000"

#define DEVICEID                            @"deviceId"
//身份证号输入限制
#define PID @"0123456789xX\n"

