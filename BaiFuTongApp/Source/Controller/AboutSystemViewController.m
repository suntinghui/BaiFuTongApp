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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"关于系统";
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"service_bg.png"]];
    [bgImageView setFrame:CGRectMake(0, 100, 320, 145)];
    [self.view addSubview:bgImageView];
    
    UILabel *versionNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 165, 100, 30)];
    [versionNumLabel setBackgroundColor:[UIColor clearColor]];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    [versionNumLabel setText:[NSString stringWithFormat:@"V %@", version]];
    [versionNumLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:versionNumLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(40, 290, 240, 38)];
    [button setBackgroundImage:[UIImage imageNamed:@"phone_button.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
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
