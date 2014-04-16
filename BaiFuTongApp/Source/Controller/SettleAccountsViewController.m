//
//  SettleAccountsViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SettleAccountsViewController.h"
#import "SettleAccountResultViewController.h"


@interface SettleAccountsViewController ()

@end

@implementation SettleAccountsViewController

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
    self.navigationItem.title = @"结算";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [scrollView setContentSize:CGSizeMake(320, 416)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.MerchantPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 50, 300, 44) left:@"商户密码" prompt:@"请输入6位商户密码"];
    [scrollView addSubview:self.MerchantPwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 150, 297, 42)];
    [confirmButton setTitle:@"结   算" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 200, 294, 200)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 282, 100)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、您可快速得到您当批次的交易结果，了解您的收益情况\n2、结算之后，您必须要重新签到才能进行其他交易";
    [explainIV addSubview:explainLabel];
}

- (BOOL) checkValue
{
    if (self.MerchantPwdTF.rsaValue == nil || [self.MerchantPwdTF.rsaValue isEqualToString:@""])
    {
        [ApplicationDelegate showErrorPrompt:@"请输入6位商户密码"];
        return false;
    }
    return true;
}

-(IBAction)confirmButtonAction:(id)sender
{
//    if ([self checkValue])
//    {
        SettleAccountResultViewController *settleVC = [[SettleAccountResultViewController alloc] initWithNibName:@"SettleAccountResultViewController" bundle:nil];
        [self.navigationController pushViewController:settleVC animated:YES];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
