//
//  ModifMerchantViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "ModifMerchantViewController.h"

@interface ModifMerchantViewController ()

@end

@implementation ModifMerchantViewController

@synthesize originalPwdTF = _originalPwdTF;
@synthesize freshPwdTF = _freshPwdTF;
@synthesize confirmPwdTF = _confirmPwdTF;

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
    
    self.navigationItem.title = @"修改商户密码";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.originalPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 10, 298, 44) left:@"原  密  码" prompt:@"请输入原密码"];
    [scrollView addSubview:self.originalPwdTF];
    
    self.freshPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 64, 298, 44) left:@"新  密  码" prompt:@"请输入6位商户密码"];
    [scrollView addSubview:self.freshPwdTF];
    
    self.confirmPwdTF = [[PwdLeftTextField alloc] initWithFrame:CGRectMake(10, 118, 298, 44) left:@"确认密码" prompt:@"请再次输入商户密码"];
    [scrollView addSubview:self.confirmPwdTF];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 180, 297, 42)];
    [confirmButton setTitle:@"确    定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 230, 294, 180)];
    explainIV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 280, 120)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    explainLabel.text = @"使用说明\n1、请注意保护您的个人密码\n2、商户密码丢失，可以使用“重置密码”办理重置";
    [explainIV addSubview:explainLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)checkValue
{
    if(self.originalPwdTF.rsaValue == nil || [self.originalPwdTF.rsaValue isEqualToString:@""]){
        [ApplicationDelegate showErrorPrompt:@"请输入6位原密码"];
        return NO;
        
    }else if(self.freshPwdTF.rsaValue == nil || [self.freshPwdTF.rsaValue isEqualToString:@""]){
        [ApplicationDelegate showErrorPrompt:@"请输入6位新商户密码"];
        return NO;
        
    }else if(self.confirmPwdTF.rsaValue == nil || [self.confirmPwdTF.rsaValue isEqualToString:@""]){
        [ApplicationDelegate showErrorPrompt:@"请再次输入6位新商户密码"];
        return NO;
        
    }else if(![self.freshPwdTF.md5Value isEqualToString:self.confirmPwdTF.md5Value]){
        [ApplicationDelegate showErrorPrompt:@"两次新密码输入不一致"];
        return NO;
        
    }
    return YES;
}
-(IBAction)confirmButtonAction:(id)sender
{
    /**
    if ([self checkValue])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[self.originalPwdTF rsaValue] forKey:@"fieldMerchPWD"];
        [dic setObject:[self.confirmPwdTF rsaValue] forKey:@"fieldNewPWD"];
        [[Transfer sharedTransfer] startTransfer:@"100004" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
    }
     */
}
@end
