//
//  PasswordTextField.m
//  redarrow
//
//  Created by jia liao on 12/16/12.
//  Copyright (c) 2012 GP. All rights reserved.
//

#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif
#import "PwdLeftTextField.h"
#import "EncryptionUtil.h"

@interface PwdLeftTextField ()
{
    __strong NSMutableString        *value;
}
@end

@implementation PwdLeftTextField

@synthesize pwdTF;
@synthesize randomKeyBoardView;
@synthesize rsaValue;
@synthesize md5Value;

- (id)initWithFrame:(CGRect)frame left:(NSString*)leftStr prompt:(NSString*)prompt
{
    self = [super initWithFrame:frame];
    if (self) {
        value = [[NSMutableString alloc] init ];
        rsaValue = nil;
        
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [imageView setImage:[UIImage imageNamed:@"BFTPwdinput.png"]];
        [self addSubview:imageView];
        
        UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 60, 40)];
        [leftlabel setTextColor:[UIColor blackColor]];
        [leftlabel setFont:[UIFont boldSystemFontOfSize:14]];
        [leftlabel setBackgroundColor:[UIColor clearColor]];
        [leftlabel setText:leftStr];
        [self addSubview:leftlabel];
        
        //区分一下系统版本
        if (DeviceVersion >= 7) {
            self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 2, frame.size.width-40, frame.size.height)];
        }else{
            self.pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 14, frame.size.width-40, frame.size.height)];
        }
        
        self.backgroundColor = [UIColor clearColor];
        self.pwdTF.delegate = self;
        [self.pwdTF setPlaceholder:prompt];
        [self.pwdTF setFont:[UIFont boldSystemFontOfSize:14]];
        self.randomKeyBoardView = [[RandomKeyBoardView alloc] initWithFrame:CGRectMake(0, 100, 480, 200)];
        self.pwdTF.inputView = self.randomKeyBoardView;
        self.randomKeyBoardView.delegate = self;
        [self addSubview:self.pwdTF];
    }
    return self;
}

- (void) numberKeyBoardInput:(NSInteger) number
{
#ifndef DEMO
    if (self.rsaValue) {
        return;
    }
#endif
    
    if (value.length < 6) {
        [value appendFormat:@"%d", number];
    }
    
    if(value.length == 6){
        self.md5Value = [EncryptionUtil MD5Encrypt:value];

    }
    NSMutableString *tmpStr = [[NSMutableString alloc] initWithCapacity:6];
    for (int i=0; i<value.length; i++) {
        [tmpStr appendString:@"*"];
    }
    [self.pwdTF setText:tmpStr];
    [self setRsa];
}

- (void) numberKeyBoardDelete
{
    if(value.length>0){
        [value deleteCharactersInRange:NSMakeRange(value.length-1, 1)];
        NSMutableString *tmpStr = [[NSMutableString alloc] initWithCapacity:6];
        for (int i=0; i<value.length; i++) {
            [tmpStr appendString:@"*"];
        }
        [self.pwdTF setText:tmpStr];
    }
    
    rsaValue = nil;
}

- (void) numberKeyBoardConfim
{
    [self.pwdTF resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 40.0f,320,416);
////    CGRect rect = CGRectMake(0.0f, 40.0f,320,VIEWHEIGHT);
//    self.superview.frame = rect;
    [UIView commitAnimations];
}

- (void) numberKeyBoardClear
{
    [value deleteCharactersInRange:NSMakeRange(0, value.length)];
    [self.pwdTF setText:@""];
    
    rsaValue = nil;
}

- (void) numberKeyBoardAbout
{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"关于"
                                                   message:@"完美支付为保护您的密码安全，请您使用定制的键盘输入密码。密码键盘每次随机打乱按键顺序，并且在您输入完6位密码后自动对密码进行加密，全面保护您的账户安全。"
                                                  delegate:self
                                         cancelButtonTitle:@"确 定"
                                         otherButtonTitles:nil];
    [alert show];
}

-(void)setRsa
{
    if([value length] == 6){
        rsaValue = [NSString stringWithString:[EncryptionUtil rsaEncrypt:[NSString stringWithFormat:@"%@FF",value]]];
    }
}

- (NSString *)rsaValue
{
#ifdef DEMO
    return @"308188028180E584FD694E15608D845C9DB15E0F68522E19FDFAE81DE34F64947D37361714315F60B01DC68D6AC2AD5BD7D4A00AF0A12ED3AB8509A04B1350B465135546F5DABC1847B650C7AADF0D9CCF458D75431E6DA31945EBF575C43A527B738DB82425D907BDE4C867508EAFCCD973872FC0FBAB8B8C3410C0800CC2088D2B11D691E70203010001";
#else
    return rsaValue;
#endif
}

#pragma mark - UITextFieldDelegate 每一次弹出密码框都要刷新键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.randomKeyBoardView refresh:nil];
    return YES;
}

@end
