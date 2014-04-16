//
//  FlowCountViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "FlowCountViewController.h"

#define ORGIN_Y         15
#define MB              (1024*1024)

@implementation FlowCountViewController

@synthesize todayUsedGprsLabel = _todayUsedGprsLabel;
@synthesize monthUsedGprsLabel = _monthUsedGprsLabel;
@synthesize todayUsedWifiLabel = _todayUsedWifiLabel;
@synthesize monthUserdWifiLabel = _monthUserdWifiLabel;

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
    
    NSString *dayWifiLength = @"245 KB";
    NSString *monthWifiLength = @"1.27 MB";
    NSString *dayGprsLength = @"120 KB";
    NSString *monthGprsLength = @"345 KB";
    
#ifndef DEMO
    dayWifiLength = [self formatFlow:([UserDefaults doubleForKey:DAY_WIFISEND] + [UserDefaults doubleForKey:DAY_WIFIRECEIVE])];
    monthWifiLength = [self formatFlow:([UserDefaults doubleForKey:MONTH_WIFISEND] + [UserDefaults doubleForKey:MONTH_WIFIRECEIVE])];
    
    dayGprsLength = [self formatFlow:([UserDefaults doubleForKey:DAY_MOBILESEND] + [UserDefaults doubleForKey:DAY_MOBILESRECEIVE])];
    monthGprsLength = [self formatFlow:([UserDefaults doubleForKey:MONTH_MOBILESEND] + [UserDefaults doubleForKey:MONTH_MOBILESRECEIVE])];
#endif
    
    self.navigationItem.title = @"流量统计";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImageView *littlegouIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORGIN_Y, 19, 19)];
    [littlegouIV setImage:[UIImage imageNamed:@"littlegou.png"]];
    [scrollView addSubview:littlegouIV];
    
    UILabel *flowRichLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, ORGIN_Y-5, 250, 30)];
    [flowRichLabel setText:@"本月剩余流量充足请放心使用"];
    [flowRichLabel setTextColor:[UIColor greenColor]];
    [flowRichLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [flowRichLabel setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:flowRichLabel];
    
    UIImage *flowImage = [UIImage imageNamed:@"flowbg.png"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORGIN_Y+25, 300, 100)];
    [imageView1 setImage:[self stretchImage:flowImage]];
    [scrollView addSubview:imageView1];
    UIImageView *giconIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 19)];
    [giconIV setImage:[UIImage imageNamed:@"gicon.png"]];
    [imageView1 addSubview:giconIV];
    UILabel *gprsLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 8, 200, 30)];
    [gprsLabel setText:@"GPRS流量统计"];
    [gprsLabel setBackgroundColor:[UIColor clearColor]];
    [gprsLabel setTextColor:[UIColor greenColor]];
    [gprsLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [imageView1 addSubview:gprsLabel];
    UILabel *todayUseLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, 70, 30)];
    [todayUseLabel1 setTextColor:[UIColor blackColor]];
    [todayUseLabel1 setFont:[UIFont boldSystemFontOfSize:14]];
    [todayUseLabel1 setText:@"今日已用:"];
    [todayUseLabel1 setBackgroundColor:[UIColor clearColor]];
    [imageView1 addSubview:todayUseLabel1];
    self.todayUsedGprsLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 35, 70, 30)];
    [self.todayUsedGprsLabel setTextColor:[UIColor blackColor]];
    [self.todayUsedGprsLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.todayUsedGprsLabel setBackgroundColor:[UIColor clearColor]];
    [self.todayUsedGprsLabel setText:dayGprsLength];
    [imageView1 addSubview:self.todayUsedGprsLabel];
    UILabel *monthUseLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 70, 30)];
    [monthUseLabel1 setTextColor:[UIColor blackColor]];
    [monthUseLabel1 setFont:[UIFont boldSystemFontOfSize:14]];
    [monthUseLabel1 setText:@"本月已用:"];
    [monthUseLabel1 setBackgroundColor:[UIColor clearColor]];
    [imageView1 addSubview:monthUseLabel1];
    self.monthUsedGprsLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 60, 70, 30)];
    [self.monthUsedGprsLabel setTextColor:[UIColor blackColor]];
    [self.monthUsedGprsLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.monthUsedGprsLabel setBackgroundColor:[UIColor clearColor]];
    [self.monthUsedGprsLabel setText:monthGprsLength];
    [imageView1 addSubview:self.monthUsedGprsLabel];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ORGIN_Y+135, 300, 100)];
    [imageView2 setImage:[self stretchImage:flowImage]];
    [scrollView addSubview:imageView2];
    UIImageView *wiFiIconIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 19)];
    [wiFiIconIV setImage:[UIImage imageNamed:@"wifiicon.png"]];
    [imageView2 addSubview:wiFiIconIV];
    UILabel *wifiLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 8, 200, 30)];
    [wifiLabel setText:@"Wi-Fi流量统计"];
    [wifiLabel setBackgroundColor:[UIColor clearColor]];
    [wifiLabel setTextColor:[UIColor greenColor]];
    [wifiLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [imageView2 addSubview:wifiLabel];
    UILabel *todayUseLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, 70, 30)];
    [todayUseLabel2 setTextColor:[UIColor blackColor]];
    [todayUseLabel2 setFont:[UIFont boldSystemFontOfSize:14]];
    [todayUseLabel2 setText:@"今日已用:"];
    [todayUseLabel2 setBackgroundColor:[UIColor clearColor]];
    [imageView2 addSubview:todayUseLabel2];
    self.todayUsedWifiLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 35, 70, 30)];
    [self.todayUsedWifiLabel setTextColor:[UIColor blackColor]];
    [self.todayUsedWifiLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.todayUsedWifiLabel setBackgroundColor:[UIColor clearColor]];
    [self.todayUsedWifiLabel setText:dayWifiLength];
    [imageView2 addSubview:self.todayUsedWifiLabel];
    UILabel *monthUseLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 70, 30)];
    [monthUseLabel2 setTextColor:[UIColor blackColor]];
    [monthUseLabel2 setFont:[UIFont boldSystemFontOfSize:14]];
    [monthUseLabel2 setText:@"本月已用:"];
    [monthUseLabel2 setBackgroundColor:[UIColor clearColor]];
    [imageView2 addSubview:monthUseLabel2];
    self.monthUserdWifiLabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 60, 70, 30)];
    [self.monthUserdWifiLabel setTextColor:[UIColor blackColor]];
    [self.monthUserdWifiLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.monthUserdWifiLabel setBackgroundColor:[UIColor clearColor]];
    [self.monthUserdWifiLabel setText:monthWifiLength];
    [imageView2 addSubview:self.monthUserdWifiLabel];
    
    UIImage *image = [UIImage imageNamed:@"BFTExplain.png"];
    UIImageView *explainIV = [[UIImageView alloc] initWithImage:[self stretchImage:image]];
    //    [explainIV setFrame:CGRectMake(10, ORGIN_Y+254, 300, 100)];
    
    [explainIV setFrame:CGRectMake(10, VIEWHEIGHT - 110, 300, 100)];
    [scrollView addSubview:explainIV];
    
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 282, 80)];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont systemFontOfSize:14];
    explainLabel.numberOfLines = 0;
    
    explainLabel.text = @"  每笔交易用的流量在8kb左右，如果您的手机套餐上网流量为10M，那您一个月就可以进行128多笔交易，也就是说任何一个运营商的上网最低套餐流量都足以支撑您的月交易量";
    [explainIV addSubview:explainLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) formatFlow:(double) length
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [numberFormatter setPositiveFormat:@"###0.00"];
    
    if (length < MB) {
        return [NSString stringWithFormat:@"%@ KB", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:length/1024]]];
    } else {
        return [NSString stringWithFormat:@"%@ MB", [numberFormatter stringFromNumber:[NSNumber numberWithDouble:length/MB]]];
    }
    
}

@end
