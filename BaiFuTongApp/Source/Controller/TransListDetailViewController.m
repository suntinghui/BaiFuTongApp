//
//  TransListDetailViewController.m
//  YLTiPhone
//
//  Created by xushuang on 13-12-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "TransListDetailViewController.h"

#define HEIGHT 1
#define WIDTH_1 200
#define ORIGIN_X 80

@interface TransListDetailViewController ()

@end

@implementation TransListDetailViewController

@synthesize detail = _detail;

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
    
    self.navigationItem.title = @"交易明细";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT + 54)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImageView *gbIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 300, 340)];
    UIImage *tmpImage = [UIImage imageNamed:@"flowbg.png"];
    [gbIV setImage:[self stretchImage:tmpImage]];
    [scrollView addSubview:gbIV];
    
    UILabel *tmpTradeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT, 100, 30)];
    [tmpTradeTypeLabel setText:@"交易类型："];
    [tmpTradeTypeLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeTypeLabel setTextColor:[UIColor blackColor]];
    [tmpTradeTypeLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeTypeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeTypeLabel];
    UILabel *tradeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT, WIDTH_1, 30)];
    [tradeTypeLabel setText:(self.detail.tranCode ? self.detail.tranCode:@"")];
    [tradeTypeLabel setTextAlignment:NSTextAlignmentRight];
    [tradeTypeLabel setTextColor:[UIColor blackColor]];
    [tradeTypeLabel setFont:[UIFont systemFontOfSize:15]];
    [tradeTypeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeTypeLabel];
    
    UILabel *tmpFlowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30, 100, 30)];
    [tmpFlowNumLabel setText:@"交易流水号："];
    [tmpFlowNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpFlowNumLabel setTextColor:[UIColor blackColor]];
    [tmpFlowNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpFlowNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpFlowNumLabel];
    UILabel *flowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30, WIDTH_1, 30)];
    [flowNumLabel setText:(self.detail.tranSerial ? self.detail.tranSerial:@"")];
    [flowNumLabel setTextAlignment:NSTextAlignmentRight];
    [flowNumLabel setTextColor:[UIColor blackColor]];
    [flowNumLabel setFont:[UIFont systemFontOfSize:15]];
    [flowNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:flowNumLabel];
    
    UILabel *tmpTradeTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*2, 100, 30)];
    [tmpTradeTimeLabel setText:@"交易时间："];
    [tmpTradeTimeLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeTimeLabel setTextColor:[UIColor blackColor]];
    [tmpTradeTimeLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeTimeLabel];
    UILabel *tradeTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*2, WIDTH_1, 30)];
    [tradeTimeLabel setText:[NSString stringWithFormat:@"%@ %@", self.detail.tranDate, self.detail.tranTime]];
    [tradeTimeLabel setTextAlignment:NSTextAlignmentRight];
    [tradeTimeLabel setTextColor:[UIColor blackColor]];
    [tradeTimeLabel setFont:[UIFont systemFontOfSize:15]];
    [tradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeTimeLabel];
    
    UILabel *tmpTradeCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*3, 100, 30)];
    [tmpTradeCdNumLabel setText:@"交易卡号："];
    [tmpTradeCdNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeCdNumLabel setTextColor:[UIColor blackColor]];
    [tmpTradeCdNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeCdNumLabel];
    UILabel *tradeCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*3, WIDTH_1, 30)];
    [tradeCdNumLabel setText:(self.detail.cardNo ? self.detail.cardNo:@"")];
    [tradeCdNumLabel setTextAlignment:NSTextAlignmentRight];
    [tradeCdNumLabel setTextColor:[UIColor blackColor]];
    [tradeCdNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tradeCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeCdNumLabel];
    
    UILabel *tmpShiftToCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*4, 100, 30)];
    [tmpShiftToCdNumLabel setText:@"转入卡号："];
    [tmpShiftToCdNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpShiftToCdNumLabel setTextColor:[UIColor blackColor]];
    [tmpShiftToCdNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpShiftToCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpShiftToCdNumLabel];
    UILabel *shiftToCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*4, WIDTH_1, 30)];
    [shiftToCdNumLabel setText:(self.detail.aimCardNo ? self.detail.aimCardNo:@"")];
    [shiftToCdNumLabel setTextAlignment:NSTextAlignmentRight];
    [shiftToCdNumLabel setTextColor:[UIColor blackColor]];
    [shiftToCdNumLabel setFont:[UIFont systemFontOfSize:15]];
    [shiftToCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:shiftToCdNumLabel];
    
    UILabel *tmpTradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*5, 100, 30)];
    [tmpTradeAmountLabel setText:@"交易金额："];
    [tmpTradeAmountLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeAmountLabel setTextColor:[UIColor blackColor]];
    [tmpTradeAmountLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeAmountLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeAmountLabel];
    UILabel *tradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*5, WIDTH_1, 30)];
    [tradeAmountLabel setText:(self.detail.tranAmt ? self.detail.tranAmt:@"")];
    [tradeAmountLabel setTextAlignment:NSTextAlignmentRight];
    [tradeAmountLabel setTextColor:[UIColor blueColor]];
    [tradeAmountLabel setFont:[UIFont systemFontOfSize:16]];
    [tradeAmountLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeAmountLabel];
    
    UILabel *tmpBatchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*6, 100, 30)];
    [tmpBatchNumLabel setText:@"批次号："];
    [tmpBatchNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpBatchNumLabel setTextColor:[UIColor blackColor]];
    [tmpBatchNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpBatchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpBatchNumLabel];
    UILabel *batchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*6, WIDTH_1, 30)];
    [batchNumLabel setText:(self.detail.batchNo ? self.detail.batchNo:@"")];
    [batchNumLabel setTextAlignment:NSTextAlignmentRight];
    [batchNumLabel setTextColor:[UIColor blackColor]];
    [batchNumLabel setFont:[UIFont systemFontOfSize:15]];
    [batchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:batchNumLabel];
    
    UILabel *tmpReferToNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*7, 100, 30)];
    [tmpReferToNumLabel setText:@"参考号："];
    [tmpReferToNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpReferToNumLabel setTextColor:[UIColor blackColor]];
    [tmpReferToNumLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpReferToNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpReferToNumLabel];
    UILabel *referToNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*7, WIDTH_1, 30)];
    [referToNumLabel setText:(self.detail.hostSerial ? self.detail.hostSerial:@"")];
    [referToNumLabel setTextAlignment:NSTextAlignmentRight];
    [referToNumLabel setTextColor:[UIColor blackColor]];
    [referToNumLabel setFont:[UIFont systemFontOfSize:15]];
    [referToNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:referToNumLabel];
    
    UILabel *tmpSettleDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*8, 100, 30)];
    [tmpSettleDateLabel setText:@"结算日期："];
    [tmpSettleDateLabel setTextAlignment:NSTextAlignmentRight];
    [tmpSettleDateLabel setTextColor:[UIColor blackColor]];
    [tmpSettleDateLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpSettleDateLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpSettleDateLabel];
    UILabel *settleDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*8, WIDTH_1, 30)];
    [settleDateLabel setText:(self.detail.settleDate ? self.detail.settleDate:@"")];
    [settleDateLabel setTextAlignment:NSTextAlignmentRight];
    [settleDateLabel setTextColor:[UIColor blackColor]];
    [settleDateLabel setFont:[UIFont systemFontOfSize:15]];
    [settleDateLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:settleDateLabel];
    
    UILabel *tmpSettleStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*9, 100, 30)];
    [tmpSettleStatusLabel setText:@"结算状态："];
    [tmpSettleStatusLabel setTextAlignment:NSTextAlignmentRight];
    [tmpSettleStatusLabel setTextColor:[UIColor blackColor]];
    [tmpSettleStatusLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpSettleStatusLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpSettleStatusLabel];
    UILabel *settleStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*9, WIDTH_1, 30)];
    [settleStatusLabel setText:([self.detail.settleFlag isEqualToString:@"0"] ? @"未清算":@"已清算")];
    [settleStatusLabel setTextAlignment:NSTextAlignmentRight];
    [settleStatusLabel setTextColor:[UIColor blackColor]];
    [settleStatusLabel setFont:[UIFont systemFontOfSize:15]];
    [settleStatusLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:settleStatusLabel];
    
    UILabel *tmpTradeStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*10, 100, 30)];
    [tmpTradeStatusLabel setText:@"交易状态："];
    [tmpTradeStatusLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeStatusLabel setTextColor:[UIColor blackColor]];
    [tmpTradeStatusLabel setFont:[UIFont systemFontOfSize:15]];
    [tmpTradeStatusLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeStatusLabel];
    UILabel *tradeStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*10, WIDTH_1, 30)];
    [tradeStatusLabel setText:[self getTranFlag:self.detail.tranFlag]];
    [tradeStatusLabel setTextAlignment:NSTextAlignmentRight];
    [tradeStatusLabel setTextColor:[UIColor blackColor]];
    [tradeStatusLabel setFont:[UIFont systemFontOfSize:15]];
    [tradeStatusLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeStatusLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 376, 297, 42)];
    [confirmButton setTitle:@"确  定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonNomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)confirmButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)getTranFlag:(NSString*)flag
{
    NSString *str = @"未知";
    switch (flag.intValue) {
        case 0:
            str = @"正常";
            break;
            
        case 1:
            str = @"被撤销";
            break;
            
        case 5:
            str = @"失败";
            break;
            
        default:
            str = @"未知";
            break;
    }
    return  str;
}

@end
