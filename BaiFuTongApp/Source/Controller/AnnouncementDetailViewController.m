//
//  AnnouncementDetailViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AnnouncementDetailViewController.h"
#import "AnnouncementModel.h"
#import "AnnouncementDBHelper.h"
@interface AnnouncementDetailViewController ()

@end

@implementation AnnouncementDetailViewController
@synthesize model = _model;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithModel:(AnnouncementModel*)model
{
    if (self = [super initWithNibName:@"AnnouncementDetailViewController" bundle:nil]) {
        self.model = model;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公告详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self
                                              action:@selector(deleteAction:)] ;
    
    
    
    // 背景
    UIImage *image = [UIImage imageNamed:@"announcementBg.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    [explainIV setFrame:CGRectMake(10, 5 ,301, 345)];
    [self.view addSubview:explainIV];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 240, 55)];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = self.model.title;
    titleLabel.numberOfLines = 2;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:titleLabel];
    
    /***
     // 日期
     UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 280, 25)];
     dateLabel.textAlignment = UITextAlignmentRight;
     dateLabel.backgroundColor = [UIColor clearColor];
     dateLabel.text = self.model.date;
     dateLabel.font = [UIFont systemFontOfSize:14];
     [self.view addSubview:dateLabel];
     ****/
    
    // 内容
    UIFont *fontOne = [UIFont systemFontOfSize:14.0];//设置字体大小
    CGSize maximumLabelSizeOne = CGSizeMake(290,MAXFLOAT); //290为我需要的UILabel的长度
    CGSize expectedLabelSizeOne = [self.model.content sizeWithFont:fontOne
                                                 constrainedToSize:maximumLabelSizeOne
                                                     lineBreakMode:UILineBreakModeWordWrap]; //expectedLabelSizeOne.height 就是内容的高度
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 300, 235)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setAlwaysBounceVertical:YES];
    scrollView.contentSize = expectedLabelSizeOne;
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 280, expectedLabelSizeOne.height)];
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.numberOfLines = 0;//上面两行设置多行显示
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.text = self.model.content;
    
    [scrollView addSubview:contentLabel];
    [self.view addSubview:scrollView];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 365, 297, 42)];
    [confirmButton setTitle:@"已   阅" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonNomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"confirmButtonPress.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:confirmButton];
}

-(IBAction)deleteAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除" message:@"您确定要删除该条公告吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AnnouncementDBHelper *helper = [[AnnouncementDBHelper alloc] init];
        [helper deleteAnouncement:_model.number];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(buttonIndex == 0){
        
    }
}

-(IBAction)confirmButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
