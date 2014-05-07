//
//  LoginPwdResetViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-5-7.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "LoginPwdResetViewController.h"
#import "UITextField+HideKeyBoard.h"

#define kSCNavBarImageTag       10
@interface LoginPwdResetViewController ()

@end

@implementation LoginPwdResetViewController

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
    // Do any additional setup after loading the view from its nib.
    self.hasTopView = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 480)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UILabel *loginPwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 300, 44)];
    loginPwdLabel.text = @"设置新的登录密码";
    loginPwdLabel.textAlignment = NSTextAlignmentLeft;
    loginPwdLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:loginPwdLabel];
    
    self.PwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 110, 298, 44) left:@"登录密码" prompt:@"请输入6位登录密码"];
    [scrollView addSubview:self.PwdTF];
    
    self.confirmPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 165, 298, 44) left:@"确认密码" prompt:@"请再次输入6位登录密码"];
    [scrollView addSubview:self.confirmPwdTF];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 220, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [scrollView addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 220, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [scrollView addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 220, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [scrollView addSubview:_securityCodeButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 400+ios7_y, 297, 42)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmButton];
    
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
    label.text = @"登录密码重置";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.shadowColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [navBar addSubview:label];
    
    UIImage *buttonNormalImage = [UIImage imageNamed:@"BFTNavBackButton_normal.png"];
    UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_selected.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonNormalImage forState:UIControlStateNormal];
    [aButton setImage:buttonSelectedImage forState:UIControlStateSelected];
    aButton.frame = CGRectMake(5,6,buttonNormalImage.size.width,buttonNormalImage.size.height);
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:aButton];
    
    [self.view addSubview:navBar];
    
    if (DeviceVersion>=7.0) {
        for (int i = 0; i<self.view.subviews.count; i++) {
            UIView *view = self.view.subviews[i];
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+20, view.frame.size.width, view.frame.size.height);
            
        }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
    }
}

- (void) backButtonAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) confirmButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//限制textfield的输入字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.securityCodeTF.contentTF == textField && range.location >= 6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
