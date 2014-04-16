//
//  ResultViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize isSuccess = _isSuccess;
@synthesize navTitle = _navTitle;
@synthesize resultMsg = _resultMsg;
@synthesize messageExplain = _messageExplain;
@synthesize popIndex = _popIndex;

- (id)initWithTitle:(NSString*)navTitle resultFlag:(BOOL)isSuccess resultMsg:(NSString*)resultMsg detailMsg:(NSString*)messageExplain popIndex:(NSInteger) popIndex
{
    self = [super initWithNibName:@"ResultViewController" bundle:nil];
    if (self) {
        // Custom initialization
        self.navTitle = navTitle;
        self.isSuccess = isSuccess;
        self.resultMsg = resultMsg;
        self.messageExplain = messageExplain;
        self.popIndex = popIndex;
    }
    return self;
}

- (id) initwithSuccessMsg:(NSString *) msg
{
    return [self initWithTitle:@"交易成功" resultFlag:true resultMsg:msg detailMsg:nil popIndex:-1];
}

- (id) initWithFailureMsg:(NSString *) msg
{
    return [self initWithTitle:@"交易失败" resultFlag:false resultMsg:[self formatMKNetWorkingTip:msg] detailMsg:nil popIndex:-1];
}

- (NSString *) formatMKNetWorkingTip:(NSString *) msg
{
    // The Internet connection appears to be offline.
    if ([msg rangeOfString:@"offline"].location != NSNotFound) {
        return @"无法链接到服务器";
        
        // The request timed out.
    } else if ([msg rangeOfString:@"out"].location != NSNotFound) {
        return @"链接服务器超时，请重试";
    }
    
    return msg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.navTitle;
    NSString *resultImageName = @"";
    if (self.isSuccess) {
        resultImageName = @"success.png";
    }else{
        resultImageName = @"fail.png";
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:resultImageName]];
    [imageView setFrame:CGRectMake(122, 80, 77, 75)];
    [self.view addSubview:imageView];
    
    UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 165, 250, 120)];
    [errorLabel setBackgroundColor:[UIColor clearColor]];
    errorLabel.textColor = [UIColor blackColor];
    errorLabel.lineBreakMode = UILineBreakModeWordWrap;
    errorLabel.numberOfLines = 0;
    [errorLabel setTextAlignment:NSTextAlignmentCenter];
    if (self.resultMsg) {
        errorLabel.text = self.resultMsg;
    }
    errorLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:errorLabel];
    
    UILabel *messageExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 161, 40)];
    [messageExplainLabel setBackgroundColor:[UIColor clearColor]];
    messageExplainLabel.textColor = [UIColor blackColor];
    [messageExplainLabel setTextAlignment:NSTextAlignmentCenter];
    //设置自动行数与字符换行
    [messageExplainLabel setNumberOfLines:0];
    if (self.messageExplain) {
        messageExplainLabel.text = self.messageExplain;
        messageExplainLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    [self.view addSubview:messageExplainLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 360, 297, 42)];
    [confirmButton setTitle:@"确  定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonNomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:confirmButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    UIImage *buttonNormalImage = [UIImage imageNamed:@"backbutton_normal.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [ApplicationDelegate hideProcess];
}

-(IBAction)confirmButtonAction:(id)sender
{
    if (self.popIndex != -1) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.popIndex] animated:YES];
        
        return;
    }
    
    if ([ApplicationDelegate hasLogin]) {
        [self popToCatalogViewController];
    }else{
        if (self.isSuccess) {
            [self popToLoginViewController];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
