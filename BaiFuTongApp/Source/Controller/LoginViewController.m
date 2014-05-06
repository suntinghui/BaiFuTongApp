//
//  LoginViewController.m
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BFTRevealViewController.h"
#import "BFTMenuViewController.h"
#import "BFTRootViewController.h"
#import "SecondMenuViewController.h"
#import "BFTMenuCell.h"
#import "ForgotPasswordViewController.h"

#import "UITextField+HideKeyBoard.h"

#define kSCNavBarImageTag       10
@interface LoginViewController ()

@property (nonatomic, strong) BFTRevealViewController *revealController;
@property (nonatomic, strong) BFTMenuViewController *menuController;

@end

@implementation LoginViewController

@synthesize phoneNumTF = _phoneNumTF;
@synthesize passwordTF = _passwordTF;
@synthesize forgetPwdButton = _forgetPwdButton;
@synthesize loginButton = _loginButton;
@synthesize registerButton = _registerButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    
    //self.navigationItem.title = @"登 录";
    self.hasTopView = NO;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //if iOS 5.0 and later
        [navBar setBackgroundImage:[UIImage imageNamed:@"BFTNavbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFTNavbar.png"]];
            [imageView setTag:kSCNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"登 录";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.shadowColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [navBar addSubview:label];
    
    [self.view addSubview:navBar];
    
    self.phoneNumTF = [[LeftTextField alloc] initWithFrame:CGRectMake(79, 162 + (iPhone5?44:0), 181, 30) isLong:true];
    [self.phoneNumTF.contentTF setPlaceholder:@"请输入注册时的手机号"];
    self.phoneNumTF.contentTF.delegate = self;
    [self.phoneNumTF.contentTF setFont:[UIFont boldSystemFontOfSize:14]];
    [self.phoneNumTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:self.phoneNumTF];
    
    self.passwordTF = [[PasswordTextField alloc] initWithFrame:CGRectMake(79, 215 + (iPhone5?44:0), 181, 30)];
    [self.view addSubview:self.passwordTF];

    //记住密码复选框
    agreeButtonTouch = NO;
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeButton setFrame:CGRectMake(35, 298, 17, 17)];
    [agreeButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_sametime_unselect.png"] forState:UIControlStateNormal];
    [agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeButton];

    [self.phoneNumTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    // 手机号赋初值
    self.phoneNumTF.contentTF.text = [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PHONENUM"];
    
    UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
	self.revealController = [[BFTRevealViewController alloc] initWithNibName:nil bundle:nil];
	self.revealController.view.backgroundColor = bgColor;
	
    self.captchaTF.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0];
    RevealBlock revealBlock = ^(){
		[self.revealController toggleSidebar:NO
									duration:kGHRevealSidebarDefaultAnimationDuration];
	};
    NSArray *controllers = @[
                             @[
                                 [[UINavigationController alloc] initWithRootViewController:[[BFTRootViewController alloc] initWithTitle:@"主菜单" withRevealBlock:revealBlock]],
                                 [[SecondMenuViewController alloc] initWithTitle:@"我的管理" withRevealBlock:revealBlock catalogId:1],
                                 [[SecondMenuViewController alloc] initWithTitle:@"我要查询" withRevealBlock:revealBlock catalogId:2],
                                 [[SecondMenuViewController alloc] initWithTitle:@"我要收款" withRevealBlock:revealBlock catalogId:3],
                                 [[SecondMenuViewController alloc] initWithTitle:@"我要提现" withRevealBlock:revealBlock catalogId:4],
                                 [[SecondMenuViewController alloc] initWithTitle:@"系统相关" withRevealBlock:revealBlock catalogId:5]
                                 ]
                             ];
    
	NSArray *cellInfos = @[
                           @[
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"主菜单", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_01.png"], kSidebarCellTextKey: NSLocalizedString(@"我的管理", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_02.png"], kSidebarCellTextKey: NSLocalizedString(@"我要查询", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_03.png"], kSidebarCellTextKey: NSLocalizedString(@"我要收款", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_04.png"], kSidebarCellTextKey: NSLocalizedString(@"我要提现", @"")},
                               @{kSidebarCellImageKey: [UIImage imageNamed:@"BFTLeftMenuIcon_normal_05.png"], kSidebarCellTextKey: NSLocalizedString(@"系统相关", @"")},
                               ]
                           ];
    self.menuController = [[BFTMenuViewController alloc] initWithSidebarViewController:self.revealController
                                                                       withControllers:controllers
                                                                         withCellInfos:cellInfos];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.passwordTF clearInput];
}

- (void)viewDidAppear:(BOOL)animated
{
#ifndef DEMO
    [[Transfer sharedTransfer] startTransfer:@"999000003" fskCmd:nil paramDic:nil];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)agreeButtonAction:(UIButton *)button
{
    if (agreeButtonTouch == NO) {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_comment_sametime_select.png"] forState:UIControlStateNormal];
        agreeButtonTouch = YES;
    }else {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_comment_sametime_unselect.png"] forState:UIControlStateNormal];
        agreeButtonTouch = NO;
    }
}

- (BOOL) checkValue
{
    if ([self.phoneNumTF.contentTF.text length] < 11)
    {
        [ApplicationDelegate showErrorPrompt:@"请输入11位手机号码"];
        return NO;
    }
    else if (self.passwordTF.rsaValue == nil || [self.passwordTF.rsaValue isEqualToString:@""])
    {
        [ApplicationDelegate showErrorPrompt:@"请输入6位商户密码"];
        return NO;
    } 
    return YES;
}

-(IBAction)loginAction:(id)sender
{
//    if ([self checkValue]) {
//        [[AppDataCenter sharedAppDataCenter] setPhoneNum:[[self.phoneNumTF contentTF] text]];
//        
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:[self.passwordTF rsaValue] forKey:@"fieldMerchPWD"]; // 密码
//        [dic setObject:[UserDefaults objectForKey:PUBLICKEY_VERSION]?[UserDefaults objectForKey:PUBLICKEY_VERSION]:INIT_PUBLICKEY_VERSION forKey:@"fieldKeyVersion"];
//        
//        [[Transfer sharedTransfer] startTransfer:@"100005" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
//    }
    [self.navigationController pushViewController:self.revealController animated:YES];
    /**
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"LOGIN"];
    
    NSInteger catalogId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CATALOGID"] intValue];
    
    switch (catalogId) {
        case 11://签到
        {
            SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
            [self.navigationController pushViewController:signInVC animated:YES];
            break;
        }
        case 12://结算
        {
            SettleAccountsViewController *settleAccountsVC = [[SettleAccountsViewController alloc] initWithNibName:@"SettleAccountsViewController" bundle:nil];
            [self.navigationController pushViewController:settleAccountsVC animated:YES];
            break;
        }
        case 13://签退
        {
            SignOutViewController *signOutVC = [[SignOutViewController alloc] initWithNibName:@"SignOutViewController" bundle:nil];
            [self.navigationController pushViewController:signOutVC animated:YES];
            break;
        }
        case 14://修改商户密码
        {
            ModifMerchantViewController *modifiMerchantVC = [[ModifMerchantViewController alloc] initWithNibName:@"ModifMerchantViewController" bundle:nil];
            [self.navigationController pushViewController:modifiMerchantVC animated:YES];
            break;
        }
        case 21://查询银行卡余额
        {
            QueryBalanceViewController *queryBalanceVC = [[QueryBalanceViewController alloc] initWithNibName:@"QueryBalanceViewController" bundle:nil];
            [self.navigationController pushViewController:queryBalanceVC animated:YES];
            break;
        }
        case 22://积点查询
        {
            PointsQueryViewController *pointsQueryVC = [[PointsQueryViewController alloc] initWithNibName:@"PointsQueryViewController" bundle:nil];
            [self.navigationController pushViewController:pointsQueryVC animated:YES];
            break;
        }
        case 23://交易查询
        {
            TradeDetailViewController *vc = [[TradeDetailViewController alloc] initWithNibName:@"TradeDetailViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 24://签购单查询
        {
            SalesSlipViewController *salesSlipVC = [[SalesSlipViewController alloc] initWithNibName:@"SalesSlipViewController" bundle:nil];
            [self.navigationController pushViewController:salesSlipVC animated:YES];
            break;
        }
        case 25://公告查询
        {
            AnnouncementListViewController *announcementVC = [[AnnouncementListViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:announcementVC animated:YES];
            break;
        }
        case 26://流量统计
        {
            FlowCountViewController *flowCountVC = [[FlowCountViewController alloc] initWithNibName:@"FlowCountViewController" bundle:nil];
            [self.navigationController pushViewController:flowCountVC animated:YES];
            break;
        }
        case 31://收款
        {
            GatherViewController *gatherVC = [[GatherViewController alloc] initWithNibName:@"GatherViewController" bundle:nil];
            [self.navigationController pushViewController:gatherVC animated:YES];
            break;
        }
        case 32://收款撤销
        {
            GatherCancelTableViewController *gatherCancelVC = [[GatherCancelTableViewController alloc] initWithNibName:@"GatherCancelTableViewController" bundle:nil];
            [self.navigationController pushViewController:gatherCancelVC animated:YES];
            break;
        }
        case 33://积点消费
        {
            MembershipExpenseViewController *membershipEXpenseVC = [[MembershipExpenseViewController alloc] initWithNibName:@"MembershipExpenseViewController" bundle:nil];
            [self.navigationController pushViewController:membershipEXpenseVC animated:YES];
            break;
        }
        case 34://订单支付　
        {
            OrderPaymentViewController *orderPaymentVC = [[OrderPaymentViewController alloc] initWithNibName:@"OrderPaymentViewController" bundle:nil];
            [self.navigationController pushViewController:orderPaymentVC animated:YES];
            break;
        }
        case 41://商户存款查询
        {
            MerchantDepositsQueryViewController *merchantDepositsVC = [[MerchantDepositsQueryViewController alloc] initWithNibName:@"MerchantDepositsQueryViewController" bundle:nil];
            [self.navigationController pushViewController:merchantDepositsVC animated:YES];
            break;
        }
        case 51://新手引导
        {
            NoviceGuideViewController *noviceGuideVC = [[NoviceGuideViewController alloc]initWithNibName:@"NoviceGuideViewController" bundle:nil];
            [self.navigationController pushViewController:noviceGuideVC animated:YES];
            break;
        }
        case 52://意见反馈
        {
            SuggestionBackViewController *suggestionBackVC = [[SuggestionBackViewController alloc]initWithNibName:@"SuggestionBackViewController" bundle:nil];
            [self.navigationController pushViewController:suggestionBackVC animated:YES];
            break;
        }
        case 53://关于系统
        {
            AboutSystemViewController *aboutSystemVC = [[AboutSystemViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:aboutSystemVC animated:YES];
            break;
        }
        case 54://检查更新
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您目前已是最新版本。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [view show];
            
            break;
        }
        default:
            break;
    }
     **/
}
-(IBAction)regesterAction:(id)sender
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)forgotPasswordAction:(UIButton *)sender
{
    ForgotPasswordViewController *forgotPasswordViewController = [[ForgotPasswordViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:forgotPasswordViewController animated:YES];
}

/**
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTF.contentTF && [[NSString stringWithFormat:@"%@%@",self.phoneNumTF.contentTF.text,string] isEqualToString:@"40051656598"]) {
        ChongZhengViewController *chongzhengVC = [[ChongZhengViewController alloc] initWithNibName:@"ChongZhengViewController" bundle:nil];
        [self.navigationController pushViewController:chongzhengVC animated:YES];
        
        return NO;
    } else if (textField == self.phoneNumTF.contentTF && [[NSString stringWithFormat:@"%@%@",self.phoneNumTF.contentTF.text,string] isEqualToString:@"40058965896"]) {
        RecordDeviceViewController *rdvc = [[RecordDeviceViewController alloc] init];
        [self.navigationController pushViewController:rdvc animated:YES];
    }
    
    if (textField == self.phoneNumTF.contentTF) {
        if(range.location>=11){
            return NO;
        }
    } else if (textField == self.securityCodeTF.contentTF) {
        if(range.location>=4){
            return NO;
        }
    }
    
    return YES;
}
**/
@end
