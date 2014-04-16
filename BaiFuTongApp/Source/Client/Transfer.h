//
//  Transfer.h
//  POS2iPhone
//
//  Created by  STH on 1/16/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <voclib/vcom.h>
#import "MKNetworkKit.h"

@interface Transfer : NSObject
{
    NSString                *_transferCode;
    NSString                *_fskCommand;
    NSDictionary            *_paramDic;
    
    NSMutableDictionary     *_sendDic;
    NSMutableDictionary     *_receDic;
    
    MKNetworkOperation      *_MKOperation;
    NSTimer                 *_timer;
    NSInteger               counter;
    
    // Transfer+FSK
    vcom                    *_m_vcom;
    NSMutableArray          *_fskCmdArray; // NSInvocation
    NSString                *_currentFSKMethod;
    
    NSString                *_tempTransferCode; // 这个代码不及格，以后要改成block实现
    
    NSTimer                 *_uploadSignImageTimer;
}

@property (nonatomic, strong, readonly) NSString            *transferCode;
@property (nonatomic, strong, readonly) NSString            *fskCommand;
@property (nonatomic, strong, readonly) NSDictionary        *paramDic;

@property (nonatomic, strong) NSMutableDictionary           *sendDic;
@property (nonatomic, strong) NSMutableDictionary           *receDic;

@property (nonatomic, strong) vcom                          *m_vcom;
@property (nonatomic, strong) NSMutableArray                *fskCmdArray;
@property (nonatomic, strong) NSString                      *currentFSKMethod;

@property (nonatomic, strong) MKNetworkOperation            *MKOperation;

@property (nonatomic, strong) NSTimer                       *timer;

@property (nonatomic, strong) NSString                      *tempTransferCode;

@property (nonatomic, strong) NSTimer                       *uploadSignImageTimer;

@property (nonatomic, strong) UIViewController              *nextViewController; //跳转的ViewController  

+ (Transfer *) sharedTransfer;

- (void) startTransfer:(NSString *)transCode fskCmd:(NSString *) fskCmd paramDic:(NSDictionary *) paramDic;
- (void) startTransfer:(NSString *)transCode fskCmd:(NSString *) fskCmd paramDic:(NSDictionary *) paramDic nextVC:(UIViewController*)nextVC;
- (void) packet;
- (void) parse;
- (void) sendPacket;
- (void) checkField39;

@end
