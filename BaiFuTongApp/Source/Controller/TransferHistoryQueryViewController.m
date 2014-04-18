//
//  TransferHistoryQueryViewController.m
//  YLTiPhone
//
//  Created by liao jia on 14-3-27.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "TransferHistoryQueryViewController.h"
#import "TransListViewController.h"

@interface TransferHistoryQueryViewController ()

@end

@implementation TransferHistoryQueryViewController
@synthesize beginDateTF = _beginDateTF;
@synthesize endDateTF = _endDateTF;
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

    self.title = @"历史查询";
    
    UITextView *tv_prompt = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, 200, 30)];
    [tv_prompt setText:@"请选择查询日期范围"];
    [tv_prompt setBackgroundColor:[UIColor clearColor]];
    [tv_prompt setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:tv_prompt];
    
    //根据已有日期创建日期
    NSTimeInterval secondsPerDay1 = 24*60*60*7 ;
    NSDate *nowDay = [NSDate date];
    
    NSDate *beforeDay = [nowDay dateByAddingTimeInterval:-secondsPerDay1];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  beforString=[dateformatter stringFromDate:beforeDay];
    NSString *  endString=[dateformatter stringFromDate:nowDay];
    
    self.beginDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 80, 300, 44) bgImage:@"textInput.png" leftText:@"开始日期"];
    [self.beginDateTF.contentLabel setText:beforString];
    [self.view addSubview:self.beginDateTF];
    
    self.endDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 140, 300, 44) bgImage:@"textInput.png" leftText:@"结束日期" ];
    [self.endDateTF.contentLabel setText:endString];
    [self.view addSubview:self.endDateTF];
    
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_confirm setFrame:CGRectMake(10, 220, 300, 44)];
    [btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
    [btn_confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_confirm.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn_confirm addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [btn_confirm setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [self.view addSubview:btn_confirm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)confirmAction:(id)sender
{
    if ([self checkValue]) {
        //        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        //        [dic setObject:[[self.beginDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"BeginDate"]; // 开始日期
        //        [dic setObject:[[self.endDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"EndDate"]; // 结束日期
        //
        //
        //        [[Transfer sharedTransfer] startTransfer:@"600000001" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
        
        TransListViewController *transListController = [[TransListViewController alloc]init];
        transListController.pageType = 1;
        transListController.beginString =[[self.beginDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        transListController.endString = [[self.endDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self.navigationController pushViewController:transListController animated:YES];
        
    }
    
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
        
    }else if([endDate timeIntervalSinceDate:beginDate]/86400 > 7){
        [ApplicationDelegate showErrorPrompt:[NSString stringWithFormat:@"开始日期和结束日期相差不能超过%d天", 7]];
        return NO;
        
    }
    
    return TRUE;
}

@end
