//
//  AppDelegate.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, MBProgressHUDDelegate>
{
    Reachability                *hostReach;
    MBProgressHUD               *HUD;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController            *rootNavigationController;
@property (nonatomic, assign) BOOL                              hasLogin;

@property (nonatomic, assign) BOOL                              printVersion;

- (UIViewController *) topViewController;

- (void) gotoSuccessViewController:(NSString *) msg;
- (void) gotoFailureViewController:(NSString *) msg;

- (BOOL) checkNetAvailable; // 检测网络方法一，可能有问题
- (BOOL) checkExistenceNetwork; // 检测网络方法二。。。

- (void) showText:(NSString *) msg;
- (void) showProcess:(NSString *) msg;
- (void) hideProcess;

- (void) showSuccessPrompt:(NSString *) msg;
- (void) showErrorPrompt:(NSString *) msg;
- (void) showErrorPrompt:(NSString *) msg ViewController:(UIViewController *) vc;

@end
