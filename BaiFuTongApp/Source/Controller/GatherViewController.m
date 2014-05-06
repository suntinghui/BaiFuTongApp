//
//  GatherViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "GatherViewController.h"
#import "InputMoneyViewController.h"

@interface GatherViewController ()

@end

@implementation GatherViewController

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
    self.navigationItem.title = @"收款";
    
    self.navigationItem.title = @"请消费者刷卡";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, 320, 445+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 480)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipcard.png"]];
    [imageView setFrame:CGRectMake(82, 30, 157, 196)];
    [scrollView addSubview:imageView];
    
    UILabel *messageExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 236, 221, 40)];
    messageExplainLabel.text = @"请按[刷卡]按钮开始交易";
    [messageExplainLabel setTextAlignment:NSTextAlignmentCenter];
    messageExplainLabel.font  = [UIFont boldSystemFontOfSize:18];
    messageExplainLabel.textColor = [UIColor blackColor];
    messageExplainLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:messageExplainLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 320 +(iPhone5?58:0), 297, 42)];
    [confirmButton setTitle:@"刷  卡" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];

    [scrollView addSubview:confirmButton];
}

-(IBAction)confirmButtonAction:(id)sender
{
    InputMoneyViewController *inputMoneyVC = [[InputMoneyViewController alloc] initWithNibName:@"InputMoneyViewController" bundle:nil];
    [self.navigationController pushViewController:inputMoneyVC animated:YES];
//    [[Transfer sharedTransfer] startTransfer:nil fskCmd:@"Request_GetExtKsn#Request_VT#Request_GetDes" paramDic:nil nextVC:inputMoneyVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
