//
//  SettleAccountResultViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SettleAccountResultViewController.h"

@interface SettleAccountResultViewController ()

@end

@implementation SettleAccountResultViewController

@synthesize confirmButton = _confirmButton;
@synthesize dic = _dic;

-(id) initWithParam:(NSDictionary *) paramDic
{
    if (self = [self initWithNibName:@"SettleAccountResultViewController" bundle:nil]) {
        self.dic = paramDic;
    }
    
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    UIImage *buttonNormalImage = [UIImage imageNamed:@"backbutton_normal.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"结算成功";
    [self.debitAmont setText:[self.dic objectForKey:@"debitAmount"]];
    [self.debitCount setText:[self.dic objectForKey:@"debitCount"]];
    [self.creditAmont setText:[self.dic objectForKey:@"creditAmount"]];
    [self.creditCount setText:[self.dic objectForKey:@"creditCount"]];
}

-(IBAction)confirmButtonAction:(id)sender
{
    [self popToCatalogViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
