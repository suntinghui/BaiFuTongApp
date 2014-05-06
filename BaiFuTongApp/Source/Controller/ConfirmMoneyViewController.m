//
//  ConfirmMoneyViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-29.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "ConfirmMoneyViewController.h"
#import "UITextField+HideKeyBoard.h"

#define HEIGHT 1
#define WIDTH_1 200
#define ORIGIN_X 80

@interface ConfirmMoneyViewController ()

@end

@implementation ConfirmMoneyViewController

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
    self.navigationItem.title = @"交易确认";
    
    UIImageView *gbIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 65+ios7_y, 300, 95)];
    UIImage *tmpImage = [UIImage imageNamed:@"flowbg.png"];
    [gbIV setImage:[self stretchImage:tmpImage]];
    [self.view addSubview:gbIV];
    
    UILabel *tmpTradeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT, 120, 30)];
    [tmpTradeNameLabel setText:@"交易名称："];
    [tmpTradeNameLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpTradeNameLabel setTextColor:[UIColor blackColor]];
    [tmpTradeNameLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeNameLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeNameLabel];
    UILabel *tradeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT, WIDTH_1, 30)];
    [tradeNameLabel setText:@"手机号提款"];
    [tradeNameLabel setTextAlignment:NSTextAlignmentRight];
    [tradeNameLabel setTextColor:[UIColor blackColor]];
    [tradeNameLabel setFont:[UIFont systemFontOfSize:15]];
    [tradeNameLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeNameLabel];
    
    UILabel *tmpAccontNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30, 120, 30)];
    [tmpAccontNumberLabel setText:@"账号："];
    [tmpAccontNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpAccontNumberLabel setTextColor:[UIColor blackColor]];
    [tmpAccontNumberLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpAccontNumberLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpAccontNumberLabel];
    UILabel *accontNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30, WIDTH_1, 30)];
    [accontNumberLabel setText:@"无"];
    [accontNumberLabel setTextAlignment:NSTextAlignmentRight];
    [accontNumberLabel setTextColor:[UIColor blackColor]];
    [accontNumberLabel setFont:[UIFont systemFontOfSize:15]];
    [accontNumberLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:accontNumberLabel];
    
    UILabel *tmpMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT+30*2, 120, 30)];
    [tmpMoneyLabel setText:@"交易金额："];
    [tmpMoneyLabel setTextAlignment:NSTextAlignmentLeft];
    [tmpMoneyLabel setTextColor:[UIColor blackColor]];
    [tmpMoneyLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpMoneyLabel];
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT+30*2, WIDTH_1, 30)];
    [moneyLabel setText:@"¥0.00"];
    [moneyLabel setTextAlignment:NSTextAlignmentRight];
    [moneyLabel setTextColor:[UIColor blackColor]];
    [moneyLabel setFont:[UIFont systemFontOfSize:15]];
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:moneyLabel];
    
    self.PwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 170+ios7_y, 298, 44) left:@"支付密码" prompt:@"请输入6位支付密码"];
    [self.view addSubview:self.PwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 235+ios7_y, 297, 42)];
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

- (void)confirmButtonAction
{
    [self popToCatalogViewController];
}
@end
