//
//  ForgotPasswordViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-5-6.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "UITextField+HideKeyBoard.h"

#define kSCNavBarImageTag       10
@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

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
    
    UILabel *adminLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 300, 44)];
    adminLabel.text = @"用户信息";
    adminLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:adminLabel];
    
    self.phoneNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 110, 298, 44) left:@"手机号码" prompt:@"请输入您的安全手机号码" keyBoardType:UIKeyboardTypePhonePad];
    self.phoneNoTF.contentTF.delegate = self;
    [self.phoneNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.phoneNoTF];
    
    self.pIdNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 165, 298, 44) left:@"身份证" prompt:@"请输入您的身份证号" keyBoardType:UIKeyboardTypeASCIICapable];
    self.pIdNoTF.contentTF.delegate = self;
    [self.pIdNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.pIdNoTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 400+ios7_y, 297, 42)];
    [confirmButton setTitle:@"立即验证" forState:UIControlStateNormal];
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
    label.text = @"找回密码";
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    else
    {
        return YES;
    }
}

@end
