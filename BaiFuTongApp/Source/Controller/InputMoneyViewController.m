//
//  InputMoneyViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "InputMoneyViewController.h"
#import "StringUtil.h"
#import "DemoClient.h"
//#import "Transfer.h"
#import "ConfirmCancelResultViewController.h"

@implementation InputMoneyViewController

@synthesize moneyStr = _moneyStr;
@synthesize displayLabel = _displayLabel;
@synthesize bgView = _bgView;
@synthesize numCount = _numCount;
@synthesize clearButton = _clearButton;
@synthesize fifteenDouble = _fifteenDouble;
@synthesize des = _des;
@synthesize dateView = _dateView;

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

    self.navigationItem.title = @"输入金额";
    
    self.des = 0.00;
    self.numCount = 0;
    self.moneyStr = [NSMutableString stringWithString:@"0.00"];

    self.displayLabel.text = self.moneyStr;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonAction:(id)sender{
    switch (((UIButton*)sender).tag) {
        case 1001://1
        case 1002://2
        case 1003://3
        case 1004://4
        case 1005://5
        case 1006://6
        case 1007://7
        case 1008://8
        case 1009://9
        case 1000://0
        {
            [self pressNumericButton:((UIButton*)sender).tag%1000];
            break;
        }
        case 1010://删除
        {
            [self pressNumericButton:((UIButton*)sender).tag%1000];
            break;
        }
        case 1011://确定
        {
            ConfirmCancelResultViewController *resultVC = [[ConfirmCancelResultViewController alloc] initWithResultMessage:@"收款成功"];
            [self.navigationController pushViewController:resultVC animated:YES];
            /**
            if ([self.moneyStr isEqualToString:@"0.00"]) {
                [ApplicationDelegate showErrorPrompt:@"请输入有效金额"];
                
            } else if ([self.moneyStr stringByReplacingOccurrencesOfString:@"." withString:@""].length > 12){
                [ApplicationDelegate showErrorPrompt:@"输入金额过长"];
                
            } else {
                // 因为在这里有可能交易后验证服务器响应数据时点付宝发生异常，这时应该检查冲正。
//                if ([[Transfer sharedTransfer] reversalAction]) {
//                    return ;
//                }
                
#ifdef DEMO
                [DemoClient setDemoAmount:[StringUtil amount2String:self.moneyStr]];
#endif
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:[StringUtil amount2String:self.moneyStr] forKey:@"field4"];
                [[Transfer sharedTransfer] startTransfer:@"200000022" fskCmd:[NSString stringWithFormat:@"Request_GetPin|string:%@",[StringUtil amount2String:self.moneyStr]] paramDic:dic];
             
            }
             **/
            
            break;
        }
        case 1012://清除
        {
            [self pressNumericButton:((UIButton*)sender).tag%1000];
            break;
        }
        default:
            break;
    }
    
}

-(void)pressNumericButton:(int) tag
{
    self.moneyStr = (NSMutableString*)[self formatString:self.moneyStr tag:tag];
//    [self displayMoneyStr:self.moneyStr];
    
    self.displayLabel.text = self.moneyStr;
}

-(NSString*)formatString:(NSString*)moneyStr tag:(int)tag
{
    double temp = [moneyStr doubleValue];
    if (tag == 10) {// 删除一位
        self.des = temp / 10;// -0.005防止四舍五入
    } else if(tag == 12){
        self.des = 0.00;
    }else if(moneyStr.length < 15){
        self.des = temp * 10 + 0.01 * tag;
    }
    NSString* str = [NSString stringWithFormat:@"%.3f", self.des];
    return [str substringWithRange:NSMakeRange(0, str.length-1)];
    
}

-(void)displayMoneyStr:(NSString*)moneyStr
{
    for (UIView *view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = moneyStr.length-1; i>=0; i--) {
        [self.bgView addSubview:[self getDigitMoneyImage:[moneyStr characterAtIndex:i]-48 countIndex:moneyStr.length-i-1]];
    }
    
}

-(UIImageView*)getDigitMoneyImage:(int)index countIndex:(int)countIndex
{
    float width = 35.0f;
    float height = 40.0f;
    float origin_x_const = 210.f;
    float origin_y = 10.0f;
    //设置图片缩小比例
    if(self.moneyStr.length > 12) {
        width = 15.0f;
        height = 20.0f;
        origin_y = 22.0f;
    }else if(self.moneyStr.length > 10) {
        width = 20.0f;
        height = 25.0f;
        origin_y = 18.0f;
    }else if (self.moneyStr.length > 8){
        width = 25.0f;
        height = 30.0f;
        origin_y = 14.0f;
    }else if (self.moneyStr.length >7){
        width = 30.0f;
        height = 35.0f;
        origin_y = 12.0f;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(origin_x_const - width*countIndex, origin_y, width, height)];
    NSString *imageName = nil;
    if (index == -2) {
        imageName = @"digit_green_dot.png";
    }else{
        imageName =  [NSString stringWithFormat:@"digit_green_%d.png",index];
    }
    [imageView setImage:[UIImage imageNamed:imageName]];
    return imageView;
}
-(UIImageView*)getDateTimeImage:(int)index  countIndex:(int)countIndex
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150  - 7*countIndex, 0, 7, 20)];
    NSString *imageName = nil;
    if (index == -3) {
        imageName = @"digit_little_dash.png";
    }else{
        imageName =  [NSString stringWithFormat:@"digit_little_%d.png",index];
    }
    [imageView setImage:[UIImage imageNamed:imageName]];
    return imageView;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
