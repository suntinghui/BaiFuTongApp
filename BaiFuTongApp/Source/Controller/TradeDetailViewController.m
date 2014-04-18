//
//  TradeDetailViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "TradeDetailViewController.h"
#import "SystemConfig.h"
#import "TradeDetailGatherTableViewController.h"

@implementation TradeDetailViewController

@synthesize beginDateTF = _beginDateTF;
@synthesize endDateTF = _endDateTF;
@synthesize pwdTF = _pwdTF;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"交易查询";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 500)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    
    //根据已有日期创建日期
    NSTimeInterval secondsPerDay1 = 24*60*60*([SystemConfig sharedSystemConfig].historyInterval) ;
    NSDate *nowDay = [NSDate date];
    
    NSDate *beforeDay = [nowDay dateByAddingTimeInterval:-secondsPerDay1];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  beforString=[dateformatter stringFromDate:beforeDay];
    NSString *  endString=[dateformatter stringFromDate:nowDay];
    
    self.beginDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 10, 300, 44) bgImage:@"textInput.png" leftText:@"开始日期"];
    [self.beginDateTF.contentLabel setText:beforString];
    [scrollView addSubview:self.beginDateTF];
    
    self.endDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 64, 300, 44) bgImage:@"textInput.png" leftText:@"结束日期" ];
    [self.endDateTF.contentLabel setText:endString];
    [scrollView addSubview:self.endDateTF];
    
    self.pwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 118, 300, 44) left:@"商户密码" prompt:@"请输入6位商户密码"];
    [scrollView addSubview:self.pwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 210 +(iPhone5?18:0), 298, 42)];
    [confirmButton setTitle:@"确  定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];

    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 272 +(iPhone5?18:0) , 298, 155)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 282, 135)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、您可通过“开始日期”和“结束日期”选择您的目标日期进行查询\n2、您可点选交易类型的下拉列表选择您要查询的交易类型\n3、您可以查询到您帐户下发生交易的时间、卡号、金额等信息";
    [explainIV addSubview:explainLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)confirmButtonAction:(id)sender
{
    TradeDetailGatherTableViewController *controller = [[TradeDetailGatherTableViewController alloc] initWithNibName:@"TradeDetailGatherTableViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    /*
    if ([self checkValue]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[[self.beginDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"BeginDate"]; // 开始日期
        [dic setObject:[[self.endDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"EndDate"]; // 结束日期
        [dic setObject:[self.pwdTF rsaValue] forKey:@"fieldMerchPWD"]; // 密码
        
        [[Transfer sharedTransfer] startTransfer:@"600000001" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
    }
     */
    
}

-(BOOL)checkValue
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *beginDate = [dateFormat dateFromString:[self.beginDateTF value]];
    NSDate *endDate = [dateFormat dateFromString:[self.endDateTF value]];
    if ([endDate timeIntervalSinceDate:beginDate]/86400 < 0){
        [ApplicationDelegate showErrorPrompt:@"结束日期应大于开始日期"];
        return NO;
        
    }else if([endDate timeIntervalSinceDate:beginDate]/86400 > [SystemConfig sharedSystemConfig].historyInterval){
        [ApplicationDelegate showErrorPrompt:[NSString stringWithFormat:@"开始日期和结束日期相差不能超过%d天", [SystemConfig sharedSystemConfig].historyInterval]];
        return NO;
        
    }else if([self.pwdTF rsaValue] == nil || [self.pwdTF.rsaValue isEqualToString:@""] ){
        [ApplicationDelegate showErrorPrompt:@"请输入6位商户密码"];
        return NO;
    }
    
    return TRUE;
}

@end

