//
//  AboutSystemViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AboutSystemViewController.h"

@interface AboutSystemViewController ()

@end

@implementation AboutSystemViewController

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
    self.navigationItem.title = @"关于系统";
    // Do any additional setup after loading the view from its nib.
    UIImageView *aboutSystemBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutSystemBg.png"]];
    [aboutSystemBg setFrame:CGRectMake(60, 80, 250*0.8, 74*0.8)];
    [self.view addSubview:aboutSystemBg];
    
    UILabel *webSite = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 44)];
    webSite.text = @"-- http://www.baifutong.cn  --";
    webSite.backgroundColor = [UIColor clearColor];
    webSite.font = [UIFont boldSystemFontOfSize:17.0f];
    [webSite setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:webSite];
    
    UILabel *adLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 199, 320, 44)];
    adLabel1.text = @"你好，我是佰付通";
    
    adLabel1.backgroundColor = [UIColor clearColor];
    adLabel1.font = [UIFont boldSystemFontOfSize:17.0f];
    [adLabel1 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:adLabel1];
    
    UILabel *adLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 243, 320, 44)];
    adLabel2.text = @"安全  方便  快捷";
    adLabel2.backgroundColor = [UIColor clearColor];
    adLabel2.font = [UIFont boldSystemFontOfSize:17.0f];
    [adLabel2 setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:adLabel2];
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 380+(iPhone5 ? 88:0), 100, 30)];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    versionLabel.text = @"V1.0.0";
    [self.view addSubview:versionLabel];
    
    
}

-(IBAction)callButtonAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://01051656598"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
