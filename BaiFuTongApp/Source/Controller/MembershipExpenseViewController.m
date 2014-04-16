//
//  MembershipExpenseViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "MembershipExpenseViewController.h"
#import "InputMoneyViewController.h"

@interface MembershipExpenseViewController ()

@end

@implementation MembershipExpenseViewController

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
    self.navigationItem.title = @"积点消费";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"swipcard.png"]];
    [imageView setFrame:CGRectMake(110, 10, 100, 125)];
    [scrollView addSubview:imageView];
    
    UILabel *messageExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 155, 221, 40)];
    messageExplainLabel.text = @"请按[刷卡]按钮开始交易";
    [messageExplainLabel setTextAlignment:NSTextAlignmentCenter];
    messageExplainLabel.font  = [UIFont boldSystemFontOfSize:18];
    messageExplainLabel.textColor = [UIColor blackColor];
    messageExplainLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:messageExplainLabel];
    
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
    
    explainLabel.text = @"使用说明\n1、积点消费";
    [explainIV addSubview:explainLabel];

}

-(IBAction)confirmButtonAction:(id)sender
{
    InputMoneyViewController *inputMoneyVC = [[InputMoneyViewController alloc] initWithNibName:@"InputMoneyViewController" bundle:nil];
    [self.navigationController pushViewController:inputMoneyVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
