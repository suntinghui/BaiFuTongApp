//
//  WithdrawalViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-28.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "ConfirmMoneyViewController.h"
#import "UITextField+HideKeyBoard.h"

#define HEIGHT 1
#define WIDTH_1 200
#define ORIGIN_X 80

@interface WithdrawalViewController ()

@end

@implementation WithdrawalViewController

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
    self.navigationItem.title = @"提  现";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 510+ios7_h)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImageView *gbIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 300, 250)];
    UIImage *tmpImage = [UIImage imageNamed:@"flowbg.png"];
    [gbIV setImage:[self stretchImage:tmpImage]];
    [scrollView addSubview:gbIV];
    
    UILabel *tmpNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT, 120, 30)];
    [tmpNameLabel setText:@"姓名："];
    [tmpNameLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpNameLabel setTextColor:[UIColor blackColor]];
    [tmpNameLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpNameLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpNameLabel];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT, WIDTH_1, 30)];
    [nameLabel setText:@"某某"];
    [nameLabel setTextAlignment:NSTextAlignmentRight];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:15]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:nameLabel];
    
    UILabel *tmpPhoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30, 120, 30)];
    [tmpPhoneNumberLabel setText:@"手机号："];
    [tmpPhoneNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpPhoneNumberLabel setTextColor:[UIColor blackColor]];
    [tmpPhoneNumberLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpPhoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpPhoneNumberLabel];
    UILabel *phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30, WIDTH_1, 30)];
    [phoneNumberLabel setText:@"186********"];
    [phoneNumberLabel setTextAlignment:NSTextAlignmentRight];
    [phoneNumberLabel setTextColor:[UIColor blackColor]];
    [phoneNumberLabel setFont:[UIFont systemFontOfSize:15]];
    [phoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:phoneNumberLabel];
    
    UILabel *tmpAvailableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*2, 120, 30)];
    [tmpAvailableMoneyLabel setText:@"当日可提取余额："];
    [tmpAvailableMoneyLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpAvailableMoneyLabel setTextColor:[UIColor blackColor]];
    [tmpAvailableMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpAvailableMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpAvailableMoneyLabel];
    UILabel *availableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*2, WIDTH_1, 30)];
    [availableMoneyLabel setText:@"¥0.00"];
    [availableMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [availableMoneyLabel setTextColor:[UIColor blackColor]];
    [availableMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [availableMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:availableMoneyLabel];
    
    UILabel *tmpUnavailableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*3, 120, 30)];
    [tmpUnavailableMoneyLabel setText:@"不可提款余额："];
    [tmpUnavailableMoneyLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpUnavailableMoneyLabel setTextColor:[UIColor blackColor]];
    [tmpUnavailableMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpUnavailableMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpUnavailableMoneyLabel];
    UILabel *unavailableMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*3, WIDTH_1, 30)];
    [unavailableMoneyLabel setText:@"¥0.00"];
    [unavailableMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [unavailableMoneyLabel setTextColor:[UIColor blackColor]];
    [unavailableMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [unavailableMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:unavailableMoneyLabel];
    
    UILabel *tmpBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*4, 120, 30)];
    [tmpBankLabel setText:@"收款银行："];
    [tmpBankLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpBankLabel setTextColor:[UIColor blackColor]];
    [tmpBankLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpBankLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpBankLabel];
    UILabel *bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*4, WIDTH_1, 30)];
    [bankLabel setText:@"中国建设银行"];
    [bankLabel setTextAlignment:NSTextAlignmentRight];
    [bankLabel setTextColor:[UIColor blackColor]];
    [bankLabel setFont:[UIFont systemFontOfSize:15]];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:bankLabel];
    
    UILabel *tmpBankAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*5, 120, 30)];
    [tmpBankAddressLabel setText:@"开启行所在城市："];
    [tmpBankAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpBankAddressLabel setTextColor:[UIColor blackColor]];
    [tmpBankAddressLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpBankAddressLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpBankAddressLabel];
    UILabel *bankAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*5, WIDTH_1, 30)];
    [bankAddressLabel setText:@"山西省 太原市"];
    [bankAddressLabel setTextAlignment:NSTextAlignmentRight];
    [bankAddressLabel setTextColor:[UIColor blackColor]];
    [bankAddressLabel setFont:[UIFont systemFontOfSize:15]];
    [bankAddressLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:bankAddressLabel];
    
    UILabel *tmpBkCardNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*6, 120, 30)];
    [tmpBkCardNoLabel setText:@"银行账户："];
    [tmpBkCardNoLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpBkCardNoLabel setTextColor:[UIColor blackColor]];
    [tmpBkCardNoLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpBkCardNoLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpBkCardNoLabel];
    UILabel *bkCardNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*6, WIDTH_1, 30)];
    [bkCardNoLabel setText:@"6228012729************"];
    [bkCardNoLabel setTextAlignment:NSTextAlignmentRight];
    [bkCardNoLabel setTextColor:[UIColor blackColor]];
    [bkCardNoLabel setFont:[UIFont systemFontOfSize:15]];
    [bkCardNoLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:bkCardNoLabel];
    
    UILabel *tmpUnionbkCardNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*7, 120, 30)];
    [tmpUnionbkCardNoLabel setText:@"联行号："];
    [tmpUnionbkCardNoLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpUnionbkCardNoLabel setTextColor:[UIColor blackColor]];
    [tmpUnionbkCardNoLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpUnionbkCardNoLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpUnionbkCardNoLabel];
    UILabel *unionbkCardNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*7, WIDTH_1, 30)];
    [unionbkCardNoLabel setText:@""];
    [unionbkCardNoLabel setTextAlignment:NSTextAlignmentRight];
    [unionbkCardNoLabel setTextColor:[UIColor blackColor]];
    [unionbkCardNoLabel setFont:[UIFont systemFontOfSize:15]];
    [unionbkCardNoLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:unionbkCardNoLabel];
    
    self.moneyTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 280, 298, 44) left:@"金额：¥" prompt:@"请输入提款金额" keyBoardType:UIKeyboardTypeDecimalPad];
    self.moneyTF.contentTF.delegate = self;
    //self.moneyTF.contentTF.textAlignment = NSTextAlignmentRight;
    self.moneyTF.contentTF.textColor = [UIColor blueColor];
    [self.moneyTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.moneyTF];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 335, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [scrollView addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 335, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [scrollView addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 335, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [scrollView addSubview:_securityCodeButton];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(10, 390, 297, 42)];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:nextButton];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.securityCodeTF.contentTF == textField && range.location >=6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)nextButtonAction
{
    ConfirmMoneyViewController *confirmMoneyViewController = [[ConfirmMoneyViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:confirmMoneyViewController animated:YES];
}

- (void)securityCodeButtonAction
{
    //短信验证码按键处理
}
@end
