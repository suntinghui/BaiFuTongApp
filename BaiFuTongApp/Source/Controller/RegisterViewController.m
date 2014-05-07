//
//  RegisterViewController.m
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+HideKeyBoard.h"

#define kSCNavBarImageTag       10
@interface RegisterViewController ()
{
    bool agreeButtonTouch;
}

@end

@implementation RegisterViewController

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
	// Do any additional setup after loading the view.
    self.hasTopView = NO;
    //self.navigationItem.title = @"注册";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 600)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.realNameTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 70, 298, 44) left:@"真实姓名" prompt:@"请输入您的真实姓名" keyBoardType:UIKeyboardTypeNamePhonePad];
    self.realNameTF.contentTF.delegate = self;
    [self.realNameTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.realNameTF];
    
    self.enterNameTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 125, 298, 44) left:@"登录名" prompt:@"请输入您的登录名" keyBoardType:UIKeyboardTypeNamePhonePad];
    self.enterNameTF.contentTF.delegate = self;
    [self.enterNameTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.enterNameTF];
    
    self.pIdNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 180, 298, 44) left:@"身份证" prompt:@"请输入您的身份证号" keyBoardType:UIKeyboardTypeASCIICapable];
    self.pIdNoTF.contentTF.delegate = self;
    [self.pIdNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.pIdNoTF];
    
    self.phoneNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 235, 298, 44) left:@"手机号码" prompt:@"请输入您的手机号码" keyBoardType:UIKeyboardTypePhonePad];
    self.phoneNoTF.contentTF.delegate = self;
    [self.phoneNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.phoneNoTF];
    
    self.PwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 290, 298, 44) left:@"登录密码" prompt:@"请输入6位登录密码"];
    [scrollView addSubview:self.PwdTF];
    
    self.confirmPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 345, 298, 44) left:@"确认密码" prompt:@"请再次输入6位登录密码"];
    [scrollView addSubview:self.confirmPwdTF];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [scrollView addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 400, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [scrollView addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 400, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [scrollView addSubview:_securityCodeButton];
    
    agreeButtonTouch = NO;
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreeButton setFrame:CGRectMake(25, 455, 23, 23)];
    [agreeButton setBackgroundImage:[UIImage imageNamed:@"btn_comment_sametime_unselect.png"] forState:UIControlStateNormal];
    [agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:agreeButton];
    
    UILabel *serverLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 442, 200, 44)];
    serverLabel.text = @"同意 《佰付通》服务协议";
    serverLabel.backgroundColor = [UIColor clearColor];
    serverLabel.textAlignment = NSTextAlignmentLeft;
    serverLabel.font = [UIFont boldSystemFontOfSize:15];
    [scrollView addSubview:serverLabel];
    
    UIButton *serverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [serverButton setFrame:CGRectMake(18, 485, 80, 25)];
    [serverButton setTitle:@"服务协议" forState:UIControlStateNormal];
    [serverButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [serverButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    serverButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [serverButton setBackgroundColor:[UIColor clearColor]];
    [serverButton addTarget:self action:@selector(serverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:serverButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 525, 297, 42)];
    [confirmButton setTitle:@"立即注册" forState:UIControlStateNormal];
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
    label.text = @"注 册";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)serverButtonAction:(UIButton *)button
{
    
}

- (void)confirmButtonAction
{
    
}

//限制textfield的输入字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:PID]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    if (textField == self.pIdNoTF.contentTF)
    {
        if (range.location >= 18) {
            return  NO;
        }
        else {
            return canChange;
        }
        
    }
    else if(self.phoneNoTF.contentTF == textField && range.location >= 11)
    {
        return NO;
    }
    else if(self.securityCodeTF.contentTF == textField && range.location >= 6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
@end
