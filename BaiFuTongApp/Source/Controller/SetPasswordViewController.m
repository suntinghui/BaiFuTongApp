//
//  SetPasswordViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "UITextField+HideKeyBoard.h"


@interface SetPasswordViewController ()

@end

@implementation SetPasswordViewController

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
    self.navigationItem.title = @"设置支付密码";
    
    self.PwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 30+ios7_y, 298, 44) left:@"支付密码" prompt:@"请输入6位支付密码"];
    [self.view addSubview:self.PwdTF];
    
    self.pIdNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 85+ios7_y, 298, 44) left:@"身份证号" prompt:@"请输入您的身份证号" keyBoardType:UIKeyboardTypeASCIICapable];
    self.pIdNoTF.contentTF.delegate = self;
    [self.pIdNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [self.view addSubview:self.pIdNoTF];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 140+ios7_y, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [self.view addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 140+ios7_y, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [self.view addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 140+ios7_y, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_securityCodeButton];
    
//    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
//    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
//    [explainIV setFrame:CGRectMake(10, 300, 294, 180)];
//    explainIV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
//    [self.view addSubview:explainIV];
//    
//    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 280, 120)];
//    explainLabel.backgroundColor = [UIColor clearColor];
//    explainLabel.textColor = [UIColor blackColor];
//    explainLabel.font = [UIFont systemFontOfSize:14];
//    explainLabel.numberOfLines = 0;
//    explainLabel.text = @"使用说明\n1、请注意保护您的个人密码\n2、商户密码丢失，可以使用“重置密码”办理重置";
//    [explainIV addSubview:explainLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 280+ios7_y, 297, 42)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confirmButtonAction
{
    [self popToCatalogViewController];
}

- (void)securityCodeButtonAction
{
    //短信验证码按键处理
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
    else if(self.securityCodeTF.contentTF == textField && range.location >=6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
