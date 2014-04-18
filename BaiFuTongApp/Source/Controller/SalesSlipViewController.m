//
//  SalesSlipViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SalesSlipViewController.h"
#import "SystemConfig.h"
#import "UITextField+HideKeyBoard.h"
#import "TransferSuccessDBHelper.h"
#import "InputTextField.h"
#import "StringUtil.h"
#import "SalesSlipListViewController.h"

@implementation SalesSlipViewController

@synthesize minMoneyLabel = _minMoneyLabel;
@synthesize maxMoneyLabel = _maxMoneyLabel;
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
    
    self.navigationItem.title = @"签购单查询";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [scrollView setContentSize:CGSizeMake(320, 500)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.minMoneyLabel = [[InputTextField alloc] initWithFrame:CGRectMake(10, 10, 300, 44) left:@"最小金额" prompt:@"请输入最小金额" keyBoardType:UIKeyboardTypeDecimalPad];
    self.minMoneyLabel.contentTF.delegate = self;
    [self.minMoneyLabel.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.minMoneyLabel];
    
    self.maxMoneyLabel = [[InputTextField alloc] initWithFrame:CGRectMake(10, 64, 300, 44) left:@"最大金额" prompt:@"请输入最大金额" keyBoardType:UIKeyboardTypeDecimalPad];
    self.maxMoneyLabel.contentTF.delegate = self;
    [self.maxMoneyLabel.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [scrollView addSubview:self.maxMoneyLabel];
    
    //根据已有日期创建日期
    NSTimeInterval secondsPerDay1 = 24*60*60*([SystemConfig sharedSystemConfig].historyInterval);
    NSDate *nowDay = [NSDate date];
    
    NSDate *beforeDay = [nowDay dateByAddingTimeInterval:-secondsPerDay1];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  beforString=[dateformatter stringFromDate:beforeDay];
    NSString *  endString=[dateformatter stringFromDate:nowDay];
    
    self.beginDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 118, 297, 44) bgImage:@"textInput.png" leftText:@"开始日期"];
    [self.beginDateTF.contentLabel setText:beforString];
    [scrollView addSubview:self.beginDateTF];
    
    self.endDateTF = [[DateTextField alloc] initWithFrame:CGRectMake(10, 172, 297 , 44) bgImage:@"textInput.png" leftText:@"结束日期" ];
    [self.endDateTF.contentLabel setText:endString];
    [scrollView addSubview:self.endDateTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 236 +(iPhone5?18:0), 297, 42)];
    [confirmButton setTitle:@"确   定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 298 +(iPhone5?18:0), 297, 130)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 282, 110)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、您可通过“最大金额”和“最小金额”选择您的目标金额进行查询\n2、您可通过“开始日期”和“结束日期”选择您的目标日期进行查询\n3、您可查询到您帐户发生交易的签购单信息";
    [explainIV addSubview:explainLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkValue
{
    // http://my249645546.iteye.com/blog/1571121
    NSString *regularStr=@"^(([1-9]\\d*)|0)(\\.\\d{1,2})?$";
    NSPredicate *predicateID = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularStr];
    if (![predicateID evaluateWithObject:self.minMoneyLabel.contentTF.text]) {
        [ApplicationDelegate showErrorPrompt:@"最小金额输入不正确"];
        return NO;
    } else if (![predicateID evaluateWithObject:self.maxMoneyLabel.contentTF.text]) {
        [ApplicationDelegate showErrorPrompt:@"最大金额输入不正确"];
        return NO;
    } else if(self.minMoneyLabel.contentTF.text.intValue > self.maxMoneyLabel.contentTF.text.intValue){
        [ApplicationDelegate showErrorPrompt:@"最小金额不能大于最大金额"];
        return false;
    }
    
    return YES;
}

-(IBAction)confirmButtonAction:(id)sender
{
    SalesSlipListViewController *vc = [[SalesSlipListViewController alloc] initWithNibName:@"SalesSlipListViewController" bundle:nil];
//    vc.dataArray = array;
    [self.navigationController pushViewController:vc animated:YES];
    
    /**
    if ([self checkValue]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[[self.beginDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"BeginDate"]; // 开始日期
        [dic setObject:[[self.endDateTF value] stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"EndDate"]; // 结束日期
        
        TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
        NSString *min = [StringUtil amount2String:self.minMoneyLabel.contentTF.text];
        NSString *max = [StringUtil amount2String:self.maxMoneyLabel.contentTF.text];
        NSString *begin = [self.beginDateTF value];
        NSString *end = [self.endDateTF value];
        NSArray *array = [helper queryTransfersWithMinAmount:min maxAmount:max startDate:begin endDate:end];
        
        SalesSlipListViewController *vc = [[SalesSlipListViewController alloc] initWithNibName:@"SalesSlipListViewController" bundle:nil];
        vc.dataArray = array;
        [self.navigationController pushViewController:vc animated:YES];
    }
     */
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.minMoneyLabel.contentTF) {
        if (range.location >= 13) {
            return NO;
        }
    } else if (textField == self.maxMoneyLabel.contentTF) {
        if (range.location >= 13) {
            return NO;
        }
    }
    
    return YES;
}

@end
