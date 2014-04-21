//
//  SignOutViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SignOutViewController.h"

@interface SignOutViewController ()

@end

@implementation SignOutViewController

@synthesize MerchantPwdTF = _MerchantPwdTF;

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
    self.navigationItem.title = @"签退";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 480)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.MerchantPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 10, 300, 44) left:@"商户密码" prompt:@"请输入6位商户密码"];
    [scrollView addSubview:self.MerchantPwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 120, 297, 42)];
    [confirmButton setTitle:@"签  退" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 170, 294, 150)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 280, 70)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、签到至签退区间的所有交易属于一批，签退后需要重新签到才能交易";
    [explainIV addSubview:explainLabel];

}

-(BOOL)checkValue
{
    if (self.MerchantPwdTF.rsaValue == nil || [self.MerchantPwdTF.rsaValue isEqualToString:@""])  {
        [ApplicationDelegate showErrorPrompt:@"请输入6位商户密码"];
        return false;
    }
    return true;
}

-(IBAction)confirmButtonAction:(id)sender
{
//    if ([self checkValue])
//    {
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:[self.MerchantPwdTF rsaValue] forKey:@"fieldMerchPWD"]; // 密码
//    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
