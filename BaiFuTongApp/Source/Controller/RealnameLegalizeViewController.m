//
//  RealnameLegalizeViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-16.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "RealnameLegalizeViewController.h"

@interface RealnameLegalizeViewController ()

@end

@implementation RealnameLegalizeViewController

-(id)init
{
    self = [self initWithNibName:@"RealnameLegalizeViewController" bundle:nil];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.hidesBackButton = YES;
    UIImage *buttonNormalImage = [UIImage imageNamed:@"BFTNavBackButton_normal.png"];
    UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_selected.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonNormalImage forState:UIControlStateNormal];
    [aButton setImage:buttonSelectedImage forState:UIControlStateSelected];
    aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"实名认证";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
