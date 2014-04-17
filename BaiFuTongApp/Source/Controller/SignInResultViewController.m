//
//  SignInResultViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "SignInResultViewController.h"

@interface SignInResultViewController ()

@end

@implementation SignInResultViewController

//-(id)init
//{
//    self = [self initWithNibName:@"SignInResultViewController" bundle:nil];
//    return self;
//}

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
    _isSuccess = NO;
    UIImage *successIma = [UIImage imageNamed:@"BFTSuccess.png"];
    UIImage *failedIma = [UIImage imageNamed:@"BFTFailed.png"];
    if (_isSuccess) {
        self.navigationItem.title = @"签到成功";
        _signInImage.image = successIma;
        _signInLabel.text = @"签到成功";
        _explainLabel.text = @"设备已成功更新工作密钥";
    }
    else
    {
        self.navigationItem.title = @"签到失败";
        _signInImage.image = failedIma;
        _signInLabel.text = @"签到失败";
        _explainLabel.text = @"失败原因未知，请重新签到";
    }
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 280, 297, 42)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confirmButtonAction
{
    [self popToCatalogViewController];
}

@end
