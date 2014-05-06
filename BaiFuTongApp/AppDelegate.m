//
//  AppDelegate.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AppDelegate.h"
#import "BFTMenuCell.h"
#import "BFTMenuViewController.h"
#import "BFTRootViewController.h"
#import "BFTRevealViewController.h"
#import "SecondMenuViewController.h"
#import "ResultViewController.h"
#import "Reachability.h"
#import "EncryptionUtil.h"
#import "BaseDBHelper.h"
#import "HttpManager.h"
#import "Transfer.h"
#import "Transfer+FSK.h"
#import "LocationHelper.h"
#import "DateUtil.h"
#import "TimedoutUtil.h"
#import "LoginViewController.h"

#pragma mark -
#pragma mark Private Interface
@interface AppDelegate ()
@property (nonatomic, strong) BFTRevealViewController *revealController;
//@property (nonatomic, strong) BFTMenuViewController *menuController;
@end

@implementation AppDelegate

@synthesize window;
//@synthesize revealController, menuController;

#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"LOGIN"];
    
//	UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
//	self.revealController = [[BFTRevealViewController alloc] initWithNibName:nil bundle:nil];
//	self.revealController.view.backgroundColor = bgColor;
//	
//    RevealBlock revealBlock = ^(){
//		[self.revealController toggleSidebar:NO
//									duration:kGHRevealSidebarDefaultAnimationDuration];
//	};
//	RevealBlock revealBlock = ^(){
//		[self.revealController toggleSidebar:!self.revealController.sidebarShowing
//									duration:kGHRevealSidebarDefaultAnimationDuration];
//	};
    
//    NSArray *controllers = @[
//                             @[
//                                 [[UINavigationController alloc] initWithRootViewController:[[BFTRootViewController alloc] initWithTitle:@"主菜单" withRevealBlock:revealBlock]],
//                                 [[UINavigationController alloc] initWithRootViewController:[[SecondMenuViewController alloc] initWithTitle:@"我的管理" withRevealBlock:revealBlock catalogId:1]],
//                                 [[UINavigationController alloc] initWithRootViewController:[[SecondMenuViewController alloc] initWithTitle:@"我要查询" withRevealBlock:revealBlock catalogId:2]],
//                                 [[UINavigationController alloc] initWithRootViewController:[[SecondMenuViewController alloc] initWithTitle:@"我要收款" withRevealBlock:revealBlock catalogId:3]],
//                                 [[UINavigationController alloc] initWithRootViewController:[[SecondMenuViewController alloc] initWithTitle:@"我要提现" withRevealBlock:revealBlock catalogId:4]],
//                                 [[UINavigationController alloc] initWithRootViewController:[[SecondMenuViewController alloc] initWithTitle:@"系统相关" withRevealBlock:revealBlock catalogId:5]]
//                                 ]
//                             ];
    
//    NSArray *controllers = @[
//                             @[
//                                 [[UINavigationController alloc] initWithRootViewController:[[BFTRootViewController alloc] initWithTitle:@"主菜单" withRevealBlock:revealBlock]],
//                                 [[SecondMenuViewController alloc] initWithTitle:@"我的管理" withRevealBlock:revealBlock catalogId:1],
//                                 [[SecondMenuViewController alloc] initWithTitle:@"我要查询" withRevealBlock:revealBlock catalogId:2],
//                                 [[SecondMenuViewController alloc] initWithTitle:@"我要收款" withRevealBlock:revealBlock catalogId:3],
//                                 [[SecondMenuViewController alloc] initWithTitle:@"我要提现" withRevealBlock:revealBlock catalogId:4],
//                                 [[SecondMenuViewController alloc] initWithTitle:@"系统相关" withRevealBlock:revealBlock catalogId:5]
//                                 ]
//                             ];
//    
//	NSArray *cellInfos = @[
//                        @[
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"主菜单", @"")},
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_01.png"], kSidebarCellTextKey: NSLocalizedString(@"我的管理", @"")},
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_02.png"], kSidebarCellTextKey: NSLocalizedString(@"我要查询", @"")},
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_03.png"], kSidebarCellTextKey: NSLocalizedString(@"我要收款", @"")},
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_04.png"], kSidebarCellTextKey: NSLocalizedString(@"我要提现", @"")},
//                            @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_05.png"], kSidebarCellTextKey: NSLocalizedString(@"系统相关", @"")},
//                            ]
//                        ];
	
	// Add drag feature to each root navigation controller
//	[controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//		[((NSArray *)obj) enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx2, BOOL *stop2){
//			UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealController
//																						 action:@selector(dragContentView:)];
//			panGesture.cancelsTouchesInView = YES;
//			[((UINavigationController *)obj2).navigationBar addGestureRecognizer:panGesture];
//		}];
//	}];
	
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
//	self.menuController = [[BFTMenuViewController alloc] initWithSidebarViewController:self.revealController
//                      withControllers:controllers
//                        withCellInfos:cellInfos];
//
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.rootNavigationController.navigationBarHidden = YES;
//    UINavigationBar *navBar = self.rootNavigationController.navigationBar;
//    
//    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
//    {
//        //if iOS 5.0 and later
//        [navBar setBackgroundImage:[UIImage imageNamed:@"BFTNavbar.png"] forBarMetrics:UIBarMetricsDefault];
//    }
//    else
//    {
//        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
//        if (imageView == nil)
//        {
//            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFTNavbar.png"]];
//            [imageView setTag:kSCNavBarImageTag];
//            [navBar insertSubview:imageView atIndex:0];
//        }
//    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.rootNavigationController;
    [self.window makeKeyAndVisible];
    
    [[Transfer sharedTransfer] initFSK];
    
    return YES;
}


- (void) gotoSuccessViewController:(NSString *) msg
{
    [self.rootNavigationController pushViewController:[[ResultViewController alloc] initwithSuccessMsg:msg] animated:YES];
}

- (void) gotoFailureViewController:(NSString *) msg
{
    [self.rootNavigationController pushViewController:[[ResultViewController alloc] initWithFailureMsg:msg] animated:YES];
}

- (BOOL) checkNetAvailable
{
    if (([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) &&
        ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus == NotReachable))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"无法链接到互联网，请检查您的网络设置"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (BOOL) checkExistenceNetwork
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            //   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            //   NSLog(@"GRPS 或 3G 网络");
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
            //  NSLog(@"WIFI网络");
            break;
    }
    
	if (!isExistenceNetwork) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"无法链接到互联网，请检查您的网络设置"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
	}
    
	return isExistenceNetwork;
}

#pragma mark - Reachability
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"网络链接已断开"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIViewController *) topViewController
{
    // 在此时机更新时间，是不是有点太过操作频繁。。。
//    [[TimedoutUtil sharedInstance] updateLastedTime];
    return self.revealController;
}


#pragma mark - MBHUD
- (void) showText:(NSString *)msg
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self topViewController].view.window animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
    //hud.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
	hud.labelText = msg;
	hud.margin = 10.f;
	hud.yOffset = 150.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:2];
}

- (void) showProcess:(NSString *) msg
{
    @try {
        if (!HUD){
            // 使用window是为了屏蔽左上角的返回按纽在弹出等待框后仍然可响应点击事件。
            HUD = [[MBProgressHUD alloc] initWithView:[self topViewController].view.window];
            [[self topViewController].view.window addSubview:HUD];
            
            HUD.delegate = self;
            //HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
            HUD.labelText = msg;
            [HUD show:YES];
        } else {
            HUD.labelText = msg;
        }
    }
    @catch (NSException *exception) {
        if (!HUD){
            // 如果在ViewDidLoad中调用showProgress方法会崩溃
            HUD = [[MBProgressHUD alloc] initWithView:[self topViewController].view];
            [[self topViewController].view addSubview:HUD];
            
            HUD.delegate = self;
            //HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
            HUD.labelText = msg;
            [HUD show:YES];
        } else {
            HUD.labelText = msg;
        }
    }
}

- (void) hideProcess
{
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:0.5];
}

- (void) hideHUD
{
    [HUD hide:YES];
}

- (void) showSuccessPrompt:(NSString *) msg
{
    if(HUD){
        [self hideProcess];
    }
    
    MBProgressHUD *successHUD = [[MBProgressHUD alloc] initWithView:[self topViewController].view.window];
	[[self topViewController].view.window addSubview:successHUD];
    
	successHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/success.png"]];
	//successHUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
	successHUD.mode = MBProgressHUDModeCustomView;
	
	//successHUD.delegate = self;
	successHUD.labelText = msg;
	
	[successHUD show:YES];
	[successHUD hide:YES afterDelay:2];
}

- (void) showErrorPrompt:(NSString *) msg
{
    if(HUD){
        [self hideProcess];
    }
    
    MBProgressHUD *errHUD = [[MBProgressHUD alloc] initWithView:[self topViewController].view.window];
	[[self topViewController].view.window addSubview:errHUD];
    //errHUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
	errHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/error.png"]];
	
	errHUD.mode = MBProgressHUDModeCustomView;
	
	errHUD.labelText = msg;
	
	[errHUD show:YES];
	[errHUD hide:YES afterDelay:2];
}

- (void) showErrorPrompt:(NSString *) msg ViewController:(UIViewController *) vc
{
    MBProgressHUD *errHUD = [[MBProgressHUD alloc] initWithView:vc.view.window];
    [vc.view.window addSubview:errHUD];
    errHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD.bundle/error.png"]];
    //errHUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    errHUD.mode = MBProgressHUDModeCustomView;
    errHUD.labelText = msg;
    [errHUD show:YES];
    [errHUD hide:YES afterDelay:2];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	
    //[hud removeFromSuperview];
	HUD = nil;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *	@brief	获取指定日期的字符串表达式 需要当前日期时传入：[NSDate date] 即可 注意时区转换
 *
 *	@param 	someDate 	指定的日期 NSDate类型
 *	@param 	typeStr 	分割线类型 @"/" 或者@“-”  传nil时默认没有分隔符
 *  @param  hasTime     是否需要返回时间
 *	@return	返回的日期字符串  格式为 2012-13-23 或者 2013/13/23 或2012-12-12 12:11:11 或2102/12/12 12:12:12
 */
- (NSString *)getDateStrWithDate:(NSDate*)someDate withCutStr:(NSString*)cutStr hasTime:(BOOL)hasTime
{
    if (cutStr == nil) {
        cutStr = @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *str = nil;
    if (hasTime) {
        str = [NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm:ss",cutStr,cutStr];
    }
    else
    {
        str = [NSString stringWithFormat:@"yyyy%@MM%@dd",cutStr,cutStr];
    }
	[formatter setDateFormat:str];
	NSString *date = [formatter stringFromDate:someDate];
	return date;
}

@end

// UINavigationController
@implementation UINavigationController (Rotation_IOS6)

- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end