//
//  QueryReceiptDetailViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "QueryReceiptDetailViewController.h"
#import "StringUtil.h"
#import "DateUtil.h"

@implementation QueryReceiptDetailViewController

@synthesize paramDic = _paramDic;

- (id)initWithParams:(NSDictionary *) dic
{
    if (self = [super initWithNibName:@"QueryReceiptDetailViewController" bundle:nil]) {
        self.paramDic = [NSDictionary dictionaryWithDictionary:dic];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"签购单";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT + 40)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT + 190)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImage *image = [UIImage imageNamed:@"salesslip.png"];
    UIImageView *bgIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [bgIV setFrame:CGRectMake(5, 0, 310, 550)];
    [scrollView addSubview:bgIV];
    
    UIImage *image1 = [UIImage imageNamed:@"textInput.png"];
    UIImageView *bgIV1 = [[UIImageView alloc] initWithImage:[self stretchImage:image1]];
    [bgIV1 setFrame:CGRectMake(28, 10, 253, 100)];
    [bgIV addSubview:bgIV1];
    
    UILabel *tmpNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
    [tmpNameLabel setText:@"商户名称："];
    [self setLabelStyle:tmpNameLabel];
    [bgIV1 addSubview:tmpNameLabel];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 150, 30)];
    [nameLabel setTextAlignment:NSTextAlignmentRight];
    [nameLabel setText:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__MERCHERNAME"]];
    [self setLabelStyle:nameLabel];
    [bgIV1 addSubview:nameLabel];
    
    UILabel *tmpNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 70, 30)];
    [tmpNumLabel setText:@"商户编号："];
    [self setLabelStyle:tmpNumLabel];
    [bgIV1 addSubview:tmpNumLabel];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 150, 30)];
    [numLabel setTextAlignment:NSTextAlignmentRight];
    [numLabel setText:[self.paramDic objectForKey:@"field42"]];
    [self setLabelStyle:numLabel];
    [bgIV1 addSubview:numLabel];
    
    UILabel *tmpTerminalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 70, 30)];
    [tmpTerminalNumLabel setText:@"终端编号："];
    [self setLabelStyle:tmpTerminalNumLabel];
    [bgIV1 addSubview:tmpTerminalNumLabel];
    UILabel *terminalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 150, 30)];
    [terminalNumLabel setTextAlignment:NSTextAlignmentRight];
    [terminalNumLabel setText:[self.paramDic objectForKey:@"field41"]];
    [self setLabelStyle:terminalNumLabel];
    [bgIV1 addSubview:terminalNumLabel];
    
    //bg2
    UIImage *image2 = [UIImage imageNamed:@"textInput.png"];
    UIImageView *bgIV2 = [[UIImageView alloc] initWithImage:[self stretchImage:image2]];
    [bgIV2 setFrame:CGRectMake(28, 120, 253, 310)];
    [bgIV addSubview:bgIV2];
    
    UILabel *tmpCardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
    [tmpCardNumLabel setText:@"卡号："];
    [self setLabelStyle:tmpCardNumLabel];
    [bgIV2 addSubview:tmpCardNumLabel];
    UILabel *cardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 150, 30)];
    [cardNumLabel setTextAlignment:NSTextAlignmentRight];
    [cardNumLabel setText:[StringUtil formatAccountNo:[self.paramDic objectForKey:@"field2"]]];
    [self setLabelStyle:cardNumLabel];
    [bgIV2 addSubview:cardNumLabel];
    
    UILabel *tmpCardBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 70, 30)];
    [tmpCardBankLabel setText:@"发卡行："];
    [self setLabelStyle:tmpCardBankLabel];
    [bgIV2 addSubview:tmpCardBankLabel];
    UILabel *cardBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 150, 30)];
    [cardBankLabel setTextAlignment:NSTextAlignmentRight];
    [cardBankLabel setText:[self.paramDic objectForKey:@"issuerBank"]];
    [self setLabelStyle:cardBankLabel];
    [bgIV2 addSubview:cardBankLabel];
    
    UILabel *tmpValidityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 70, 30)];
    [tmpValidityLabel setText:@"卡有效期："];
    [self setLabelStyle:tmpValidityLabel];
    [bgIV2 addSubview:tmpValidityLabel];
    UILabel *validityLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 150, 30)];
    [validityLabel setTextAlignment:NSTextAlignmentRight];
    [validityLabel setText:[self.paramDic objectForKey:@"field15"]];
    [self setLabelStyle:validityLabel];
    [bgIV2 addSubview:validityLabel];
    
    UILabel *tmptradeDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 70, 30)];
    [tmptradeDateLabel setText:@"交易日期："];
    [self setLabelStyle:tmptradeDateLabel];
    [bgIV2 addSubview:tmptradeDateLabel];
    UILabel *tradeDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, 150, 30)];
    [tradeDateLabel setTextAlignment:NSTextAlignmentRight];
    [tradeDateLabel setText:[DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [self.paramDic objectForKey:@"field13"], [self.paramDic  objectForKey:@"field12"]]]];
    [self setLabelStyle:tradeDateLabel];
    [bgIV2 addSubview:tradeDateLabel];
    
    UILabel *tmpTradeStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 70, 30)];
    [tmpTradeStyleLabel setText:@"交易类型："];
    [self setLabelStyle:tmpTradeStyleLabel];
    [bgIV2 addSubview:tmpTradeStyleLabel];
    UILabel *tradeStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 105, 150, 30)];
    [tradeStyleLabel setTextAlignment:NSTextAlignmentRight];
    [tradeStyleLabel setText:[[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[self.paramDic objectForKey:@"fieldTrancode"]]];
    [self setLabelStyle:tradeStyleLabel];
    [bgIV2 addSubview:tradeStyleLabel];
    
    UILabel *tmpFlowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 100, 30)];
    [tmpFlowNumLabel setText:@"交易流水号："];
    [self setLabelStyle:tmpFlowNumLabel];
    [bgIV2 addSubview:tmpFlowNumLabel];
    UILabel *flowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 130, 150, 30)];
    [flowNumLabel setTextAlignment:NSTextAlignmentRight];
    [flowNumLabel setText:[self.paramDic objectForKey:@"field11"]];
    [self setLabelStyle:flowNumLabel];
    [bgIV2 addSubview:flowNumLabel];
    
    UILabel *tmpAuthenticationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 70, 30)];
    [tmpAuthenticationLabel setText:@"授权号："];
    [self setLabelStyle:tmpAuthenticationLabel];
    [bgIV2 addSubview:tmpAuthenticationLabel];
    UILabel *authenticationLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 155, 150, 30)];
    [authenticationLabel setTextAlignment:NSTextAlignmentRight];
    [authenticationLabel setText:[self.paramDic objectForKey:@"field38"]];
    [self setLabelStyle:authenticationLabel];
    [bgIV2 addSubview:authenticationLabel];
    
    UILabel *tmpReferenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 70, 30)];
    [tmpReferenceLabel setText:@"参考号："];
    [self setLabelStyle:tmpReferenceLabel];
    [bgIV2 addSubview:tmpReferenceLabel];
    UILabel *referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 180, 150, 30)];
    [referenceLabel setTextAlignment:NSTextAlignmentRight];
    [referenceLabel setText:[self.paramDic objectForKey:@"field37"]];
    [self setLabelStyle:referenceLabel];
    [bgIV2 addSubview:referenceLabel];
    
    UILabel *tmpbatchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 70, 30)];
    [tmpbatchNumLabel setText:@"批次号："];
    [self setLabelStyle:tmpbatchNumLabel];
    [bgIV2 addSubview:tmpbatchNumLabel];
    UILabel *batchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 205, 150, 30)];
    [batchNumLabel setTextAlignment:NSTextAlignmentRight];
    [batchNumLabel setText:[[self.paramDic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)]];
    [self setLabelStyle:batchNumLabel];
    [bgIV2 addSubview:batchNumLabel];
    
    UILabel *tmpTradeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 233, 70, 30)];
    [tmpTradeMoneyLabel setText:@"交易金额："];
    [self setLabelStyle:tmpTradeMoneyLabel];
    [bgIV2 addSubview:tmpTradeMoneyLabel];
    UILabel *tradeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 230, 150, 40)];
    [tradeMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [tradeMoneyLabel setText:[StringUtil string2SymbolAmount:[self.paramDic objectForKey:@"field4"]]];
    [tradeMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [tradeMoneyLabel setTextColor:[UIColor blueColor]];
    [tradeMoneyLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [bgIV2 addSubview:tradeMoneyLabel];
    
    UILabel *tmpCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 70, 30)];
    [tmpCommentLabel setText:@"备注："];
    [self setLabelStyle:tmpCommentLabel];
    [bgIV2 addSubview:tmpCommentLabel];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 270, 150, 30)];
    [commentLabel setTextAlignment:NSTextAlignmentRight];
    [commentLabel setText:[self.paramDic objectForKey:@"remark"]];
    [self setLabelStyle:commentLabel];
    [bgIV2 addSubview:commentLabel];
    
    UILabel *instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 435, 253, 50)];
    [instructionLabel setTextColor:[UIColor grayColor]];
    [instructionLabel setBackgroundColor:[UIColor clearColor]];
    [instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
    instructionLabel.lineBreakMode = UILineBreakModeWordWrap;
    instructionLabel.numberOfLines = 0;
    [instructionLabel setText:@"以上交易信息仅供参考，如有疑问请致电完美支付客服:400-7001717"];
    [bgIV addSubview:instructionLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(35, 495, 250, 40)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonNomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
}

-(IBAction)close:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
