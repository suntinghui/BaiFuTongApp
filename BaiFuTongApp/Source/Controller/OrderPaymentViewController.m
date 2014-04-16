//
//  OrderPaymentViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "OrderPaymentViewController.h"
#import "OrderDetailViewController.h"

@interface OrderPaymentViewController ()

@end

@implementation OrderPaymentViewController

@synthesize orderNODateTF = _orderNODateTF;

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
    self.navigationItem.title = @"订单支付";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.orderNODateTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 10, 300, 44) left:@"订单号" prompt:@"请输入订单号" keyBoardType:UIKeyboardTypeDecimalPad];
    self.orderNODateTF.contentTF.delegate = self;
//    [self.orderNODateTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.orderNODateTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 200, 297, 42)];
    [confirmButton setTitle:@"刷会员卡" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 250, 297, 140)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 282, 60)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、订单支付";
    [explainIV addSubview:explainLabel];
    
}

-(IBAction)confirmButtonAction:(id)sender
{
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
