//
//  SalesSlipDetailViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-29.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

/****
 关于IOS IMEI的替代方案
 
 1.IOS IMEI已经被拒绝使用
 http://stackoverflow.com/questions/11342094/imei-as-a-fallback-of-udid-is-it-a-good-idea
 
 2、替换方案
 http://www.cnblogs.com/zhulin/archive/2012/03/26/2417860.html
 
 
 现在程序中使用已经得到的UUID来替换。但是缺点是删除应用后又会重新生成一个。
 
 *****/

#import "SalesSlipDetailViewController.h"
#import "SignViewController.h"
#import "StringUtil.h"
#import "DateUtil.h"
#import "EncryptionUtil.h"
#import "Transfer.h"

@implementation SalesSlipDetailViewController

@synthesize scrollView = _scrollView;
@synthesize gotoSignButton = _gotoSignButton;
@synthesize confirmButton = _confirmButton;
@synthesize imageView = _imageView;
@synthesize bgImageView = _bgImageView;

- (id)init
{
    self = [super initWithNibName:@"SalesSlipDetailViewController" bundle:nil];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"签购单";
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [self.scrollView setContentSize:CGSizeMake(320, 560)];
    self.scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.scrollView];
    
    self.bgImageView = [[UIImageView alloc] initWithImage:[self stretchImage:[UIImage imageNamed:@"salesslip.png"]]];
    [self.bgImageView setFrame:CGRectMake(5, 0, 310, 540)];
    [self.scrollView addSubview:self.bgImageView];
    
    //bg1
    UIImage *image1 = [UIImage imageNamed:@"textInput.png"];
    UIImageView *bgIV1 = [[UIImageView alloc] initWithImage:[self stretchImage:image1]];
    [bgIV1 setFrame:CGRectMake(28, 10, 253, 100)];
    [self.bgImageView addSubview:bgIV1];
    
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
    [numLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field42"]];
    [self setLabelStyle:numLabel];
    [bgIV1 addSubview:numLabel];
    
    UILabel *tmpTerminalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 70, 30)];
    [tmpTerminalNumLabel setText:@"终端编号："];
    [self setLabelStyle:tmpTerminalNumLabel];
    [bgIV1 addSubview:tmpTerminalNumLabel];
    UILabel *terminalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 150, 30)];
    [terminalNumLabel setTextAlignment:NSTextAlignmentRight];
    [terminalNumLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field41"]];
    [self setLabelStyle:terminalNumLabel];
    [bgIV1 addSubview:terminalNumLabel];
    
    //bg2
    UIImage *image2 = [UIImage imageNamed:@"textInput.png"];
    UIImageView *bgIV2 = [[UIImageView alloc] initWithImage:[self stretchImage:image2]];
    [bgIV2 setFrame:CGRectMake(28, 120, 253, 310)];
    [self.bgImageView addSubview:bgIV2];
    
    UILabel *tmpCardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 30)];
    [tmpCardNumLabel setText:@"卡号："];
    [self setLabelStyle:tmpCardNumLabel];
    [bgIV2 addSubview:tmpCardNumLabel];
    UILabel *cardNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 150, 30)];
    [cardNumLabel setTextAlignment:NSTextAlignmentRight];
    [cardNumLabel setText:[StringUtil formatAccountNo:[[Transfer sharedTransfer].receDic objectForKey:@"field2"]]];
    [self setLabelStyle:cardNumLabel];
    [bgIV2 addSubview:cardNumLabel];
    
    UILabel *tmpCardBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 70, 30)];
    [tmpCardBankLabel setText:@"发卡行："];
    [self setLabelStyle:tmpCardBankLabel];
    [bgIV2 addSubview:tmpCardBankLabel];
    UILabel *cardBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 150, 30)];
    [cardBankLabel setTextAlignment:NSTextAlignmentRight];
    [cardBankLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"issuerBank"]];
    [self setLabelStyle:cardBankLabel];
    [bgIV2 addSubview:cardBankLabel];
    
    UILabel *tmpValidityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 70, 30)];
    [tmpValidityLabel setText:@"卡有效期："];
    [self setLabelStyle:tmpValidityLabel];
    [bgIV2 addSubview:tmpValidityLabel];
    UILabel *validityLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 150, 30)];
    [validityLabel setTextAlignment:NSTextAlignmentRight];
    [validityLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field15"]];
    [self setLabelStyle:validityLabel];
    [bgIV2 addSubview:validityLabel];
    
    UILabel *tmptradeDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 70, 30)];
    [tmptradeDateLabel setText:@"交易日期："];
    [self setLabelStyle:tmptradeDateLabel];
    [bgIV2 addSubview:tmptradeDateLabel];
    UILabel *tradeDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, 150, 30)];
    [tradeDateLabel setTextAlignment:NSTextAlignmentRight];
    [tradeDateLabel setText:[DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [[Transfer sharedTransfer].receDic objectForKey:@"field13"], [[Transfer sharedTransfer].receDic  objectForKey:@"field12"]]]];
    [self setLabelStyle:tradeDateLabel];
    [bgIV2 addSubview:tradeDateLabel];
    
    UILabel *tmpTradeStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 70, 30)];
    [tmpTradeStyleLabel setText:@"交易类型："];
    [self setLabelStyle:tmpTradeStyleLabel];
    [bgIV2 addSubview:tmpTradeStyleLabel];
    UILabel *tradeStyleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 105, 150, 30)];
    [tradeStyleLabel setTextAlignment:NSTextAlignmentRight];
    [tradeStyleLabel setText:[[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[[Transfer sharedTransfer].receDic objectForKey:@"fieldTrancode"]]];
    [self setLabelStyle:tradeStyleLabel];
    [bgIV2 addSubview:tradeStyleLabel];
    
    UILabel *tmpFlowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 100, 30)];
    [tmpFlowNumLabel setText:@"交易流水号："];
    [self setLabelStyle:tmpFlowNumLabel];
    [bgIV2 addSubview:tmpFlowNumLabel];
    UILabel *flowNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 130, 150, 30)];
    [flowNumLabel setTextAlignment:NSTextAlignmentRight];
    [flowNumLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field11"]];
    [self setLabelStyle:flowNumLabel];
    [bgIV2 addSubview:flowNumLabel];
    
    UILabel *tmpAuthenticationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 155, 70, 30)];
    [tmpAuthenticationLabel setText:@"授权号："];
    [self setLabelStyle:tmpAuthenticationLabel];
    [bgIV2 addSubview:tmpAuthenticationLabel];
    UILabel *authenticationLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 155, 150, 30)];
    [authenticationLabel setTextAlignment:NSTextAlignmentRight];
    [authenticationLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field38"]];
    [self setLabelStyle:authenticationLabel];
    [bgIV2 addSubview:authenticationLabel];
    
    UILabel *tmpReferenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 70, 30)];
    [tmpReferenceLabel setText:@"参考号："];
    [self setLabelStyle:tmpReferenceLabel];
    [bgIV2 addSubview:tmpReferenceLabel];
    UILabel *referenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 180, 150, 30)];
    [referenceLabel setTextAlignment:NSTextAlignmentRight];
    [referenceLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"field37"]];
    [self setLabelStyle:referenceLabel];
    [bgIV2 addSubview:referenceLabel];
    
    UILabel *tmpbatchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 205, 70, 30)];
    [tmpbatchNumLabel setText:@"批次号："];
    [self setLabelStyle:tmpbatchNumLabel];
    [bgIV2 addSubview:tmpbatchNumLabel];
    UILabel *batchNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 205, 150, 30)];
    [batchNumLabel setTextAlignment:NSTextAlignmentRight];
    [batchNumLabel setText:[[[Transfer sharedTransfer].receDic objectForKey:@"field60"] substringWithRange:NSMakeRange(2, 6)]];
    [self setLabelStyle:batchNumLabel];
    [bgIV2 addSubview:batchNumLabel];
    
    UILabel *tmpTradeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 233, 70, 30)];
    [tmpTradeMoneyLabel setText:@"交易金额："];
    [self setLabelStyle:tmpTradeMoneyLabel];
    [bgIV2 addSubview:tmpTradeMoneyLabel];
    UILabel *tradeMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 230, 150, 40)];
    [tradeMoneyLabel setTextAlignment:NSTextAlignmentRight];
    [tradeMoneyLabel setText:[StringUtil string2SymbolAmount:[[Transfer sharedTransfer].receDic objectForKey:@"field4"]]];
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
    [commentLabel setText:[[Transfer sharedTransfer].receDic objectForKey:@"remark"]];
    [self setLabelStyle:commentLabel];
    [bgIV2 addSubview:commentLabel];
    
    UILabel *instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 435, 253, 30)];
    [instructionLabel setTextColor:[UIColor grayColor]];
    [instructionLabel setBackgroundColor:[UIColor clearColor]];
    [instructionLabel setFont:[UIFont boldSystemFontOfSize:14]];
    instructionLabel.numberOfLines = 0;
    [instructionLabel setText:@"本人确认以上信息同意将其计入本卡账户"];
    [self.bgImageView addSubview:instructionLabel];
    
    self.gotoSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.gotoSignButton setFrame:CGRectMake(35, 485, 250, 40)];
    [self.gotoSignButton setTitle:@"请持卡人签名" forState:UIControlStateNormal];
    [self.gotoSignButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.gotoSignButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.gotoSignButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.gotoSignButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [self.gotoSignButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [self.gotoSignButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:self.gotoSignButton];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 470, 250, 90)];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setFrame:CGRectMake(35, 575, 250, 40)];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.confirmButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)confirmButtonAction:(id)sender
{
    [[Transfer sharedTransfer].receDic setObject:[self getMD5Value] forKey:@"MD5"];
    
    SignViewController *signVC = [[SignViewController alloc] initWithNibName:@"SignViewController" bundle:nil];
    signVC.delegate = self;
    UINavigationController *navigationControl = [[UINavigationController alloc] initWithRootViewController:signVC];
    [self presentModalViewController:navigationControl animated:YES];
}

-(IBAction)close:(id)sender
{
    [self popToCatalogViewController];
}

- (NSString *) getMD5Value
{
    // 银联返回的检索参考号（12位）
    NSString *indexNo = [[Transfer sharedTransfer].receDic objectForKey:@"field37"];
    // 时间戳
    NSString *dateTime = [DateUtil getSystemDateTime2];
    // 手机中已经保存的UUID
    NSString *UUID = [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__UUID"];
    
    return [EncryptionUtil MD5Encrypt:[NSString stringWithFormat:@"%@%@%@", indexNo, dateTime, UUID]];
}

- (void)abstractViewControllerDone:(id) obj
{
    NSLog(@"完成签名后回调...");
    
    [self.gotoSignButton removeFromSuperview];
    
    [self.scrollView setContentSize:CGSizeMake(320, 650)];
    [self.bgImageView setFrame:CGRectMake(5, 0, 310, 640)];
    self.bgImageView = [[UIImageView alloc] initWithImage:[self stretchImage:[UIImage imageNamed:@"salesslip.png"]]];
    [self.imageView setImage:obj];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.confirmButton];
}

@end
