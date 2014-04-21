//
//  ConfirmCancelViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "ConfirmCancelViewController.h"
#import "ConfirmCancelResultViewController.h"
#import "StringUtil.h"
#import "DateUtil.h"
#import "DemoClient.h"
//#import "Transfer.h"
//#import "Transfer+Action.h"

#define HEIGHT          5
#define ORIGIN_X        130
#define WIDTH_1         180

@implementation ConfirmCancelViewController

@synthesize pwdTF = _pwdTF;

- (id) initWithModel:(SuccessTransferModel *) model
{
    if (self = [super initWithNibName:@"ConfirmCancelViewController" bundle:nil]) {
        self.model = model;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"确认撤销";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, 620)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
    [messageLabel setTextColor:[UIColor grayColor]];
    messageLabel.text = @"请仔细核对以下交易信息";
    [messageLabel setBackgroundColor:[UIColor clearColor]];
    [messageLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:messageLabel];
    
    UIImageView *gbIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 300, 190)];
    UIImage *tmpImage = [UIImage imageNamed:@"flowbg.png"];
    [gbIV setImage:[self stretchImage:tmpImage]];
    [scrollView addSubview:gbIV];
    
    UILabel *tmpFlowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT, 100, 30)];
    [tmpFlowNumLabel setText:@"交易流水号："];
    [tmpFlowNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpFlowNumLabel setTextColor:[UIColor blackColor]];
    [tmpFlowNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tmpFlowNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpFlowNumLabel];
    UILabel *flowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT, WIDTH_1, 30)];
    [flowNumLabel setText:[self.model.content objectForKey:@"field11"]];
    [flowNumLabel setTextAlignment:NSTextAlignmentLeft];
    [flowNumLabel setTextColor:[UIColor blackColor]];
    [flowNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [flowNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:flowNumLabel];
    
    UILabel *tmpBatchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30, 100, 30)];
    [tmpBatchNumLabel setText:@"批次号："];
    [tmpBatchNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpBatchNumLabel setTextColor:[UIColor blackColor]];
    [tmpBatchNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tmpBatchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpBatchNumLabel];
    UILabel *batchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30, WIDTH_1, 30)];
    [batchNumLabel setText:[[self.model.content objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)]];
    [batchNumLabel setTextAlignment:NSTextAlignmentLeft];
    [batchNumLabel setTextColor:[UIColor blackColor]];
    [batchNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [batchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:batchNumLabel];
    
    UILabel *tmpSearchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*2, 100, 30)];
    [tmpSearchNumLabel setText:@"检索参考号："];
    [tmpSearchNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpSearchNumLabel setTextColor:[UIColor blackColor]];
    [tmpSearchNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tmpSearchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpSearchNumLabel];
    UILabel *searchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*2, WIDTH_1, 30)];
    [searchNumLabel setText:[self.model.content objectForKey:@"field37"]];
    [searchNumLabel setTextAlignment:NSTextAlignmentLeft];
    [searchNumLabel setTextColor:[UIColor blackColor]];
    [searchNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [searchNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:searchNumLabel];
    
    UILabel *tmpTradeCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*3, 100, 30)];
    [tmpTradeCdNumLabel setText:@"交易卡号："];
    [tmpTradeCdNumLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeCdNumLabel setTextColor:[UIColor blackColor]];
    [tmpTradeCdNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tmpTradeCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeCdNumLabel];
    UILabel *tradeCdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*3, WIDTH_1, 30)];
    [tradeCdNumLabel setText:[StringUtil formatAccountNo:[self.model.content objectForKey:@"field2"]]];
    [tradeCdNumLabel setTextAlignment:NSTextAlignmentLeft];
    [tradeCdNumLabel setTextColor:[UIColor blackColor]];
    [tradeCdNumLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tradeCdNumLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeCdNumLabel];
    
    UILabel *tmpTradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*4, 100, 30)];
    [tmpTradeAmountLabel setText:@"交易金额："];
    [tmpTradeAmountLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeAmountLabel setTextColor:[UIColor blackColor]];
    [tmpTradeAmountLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tmpTradeAmountLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeAmountLabel];
    UILabel *tradeAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*4, WIDTH_1, 30)];
    [tradeAmountLabel setText:[StringUtil string2SymbolAmount:[self.model.content objectForKey:@"field4"]]];
    [tradeAmountLabel setTextAlignment:NSTextAlignmentLeft];
    [tradeAmountLabel setTextColor:[UIColor blueColor]];
    [tradeAmountLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [tradeAmountLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeAmountLabel];
    
    UILabel *tmpTradeTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEIGHT + 30*5, 100, 30)];
    [tmpTradeTimeLabel setText:@"交易时间："];
    [tmpTradeTimeLabel setTextAlignment:NSTextAlignmentRight];
    [tmpTradeTimeLabel setTextColor:[UIColor blackColor]];
    [tmpTradeTimeLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [tmpTradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tmpTradeTimeLabel];
    UILabel *tradeTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN_X, HEIGHT + 30*5, WIDTH_1, 30)];
    [tradeTimeLabel setText:[DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [self.model.content objectForKey:@"field13"], [self.model.content objectForKey:@"field12"]]]];
    [tradeTimeLabel setTextAlignment:NSTextAlignmentLeft];
    [tradeTimeLabel setTextColor:[UIColor blackColor]];
    [tradeTimeLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [tradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [gbIV addSubview:tradeTimeLabel];
    
    self.pwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 250, 300, 44) left:@"商户密码" prompt:@"请输入6位商户密码"];
    [scrollView addSubview:self.pwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 315, 298, 42)];
    [confirmButton setTitle:@"确认撤销" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"explain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 370, 298, 240)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 282, 220)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.lineBreakMode = NSLineBreakByWordWrapping;
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"使用说明\n1、您可以对撤销列表中所有的交易进行撤销\n2、消费者只可以对当日 未结算的交易 进行撤销\n3、撤销成功后，交易资金将不会转到您的银行账户中\n4、持卡人需要在签购单上正确签名，作为撤销凭证\n5、商户可以使用“签购单查询”来调阅签购单 ，也可以在完美支付门户网站 上调阅\n6、可以将该交易的签购单以短信方式发送给消费者查阅";
    [explainIV addSubview:explainLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) checkValue
{
    if (self.pwdTF.rsaValue == nil || [self.pwdTF.rsaValue isEqualToString:@""]) {
        [ApplicationDelegate showErrorPrompt:@"请输入6位商户密码"];
        return NO;
    }
    
    return YES;
}

-(IBAction)confirmButtonAction:(id)sender
{
    if ([self checkValue]) {
        
        // 因为在这里有可能交易后验证服务器响应数据时点付宝发生异常，这时应该检查冲正。
//        if ([[Transfer sharedTransfer] reversalAction])
//            return;
        
#ifdef DEMO
        [DemoClient setDemoAmount:[self.model.content objectForKey:@"field4"]];
#endif
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self.model.content];
        [dic setObject:[self.pwdTF rsaValue] forKey:@"fieldMerchPWD"];
        
//        [[Transfer sharedTransfer] startTransfer:@"200200023" fskCmd:[NSString stringWithFormat:@"Request_GetExtKsn#Request_VT#Request_GetDes#Request_GetPin|string:%@",[self.model.content objectForKey:@"field4"]] paramDic:dic];
    }
}

@end
