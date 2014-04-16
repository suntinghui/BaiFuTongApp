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

#import "PasswordTextField.h"
#import "EncryptionUtil.h"

@interface PasswordTextField ()
{
    __strong NSMutableString        *value;
}

- (void) numberKeyBoardInput:(NSInteger) number;
- (void) numberKeyBoardDelete;
- (void) numberKeyBoardConfim;
- (void) numberKeyBoardClear;
- (void) numberKeyBoardAbout;
- (void) setRsa;

@end

@implementation PasswordTextField

@synthesize pwdTF;
@synthesize randomKeyBoardView;
@synthesize rsaValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        value = [[NSMutableString alloc] init];
        
        
        // Initialization code
        UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgIV setImage:[UIImage imageNamed:@"loginInputbg_long.png"]];
        [self addSubview:bgIV];
        
        pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, frame.size.width, frame.size.height)];
        self.backgroundColor = [UIColor clearColor];
        pwdTF.delegate = self;
        [pwdTF setPlaceholder:@"请输入商户密码"];
        [pwdTF setFont:[UIFont boldSystemFontOfSize:14]];
         randomKeyBoardView = [[RandomKeyBoardView alloc] initWithFrame:CGRectMake(0, 100, 480, 200)];
        pwdTF.inputView = randomKeyBoardView;
        randomKeyBoardView.delegate = self;
        [self addSubview:pwdTF];
    }
    return self;
}

- (void) numberKeyBoardInput:(NSInteger) number
{
#ifndef DEMO
    if (rsaValue) {
        return;
    }
#endif
    
    if (value.length < 6) {
        [value appendFormat:@"%d", number];
    }
    
    NSMutableString *tmpStr = [[NSMutableString alloc] initWithCapacity:6];
    for (int i=0; i<value.length; i++) {
        [tmpStr appendString:@"*"];
    }
    [pwdTF setText:tmpStr];
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
        [pwdTF setText:tmpStr];
    }
    
    rsaValue = nil;
}
- (void) numberKeyBoardConfim
{
    [pwdTF resignFirstResponder];
}

- (void) numberKeyBoardClear
{
    [value deleteCharactersInRange:NSMakeRange(0, value.length)];
    [pwdTF setText:@""];
    
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

- (void) clearInput
{
    [self numberKeyBoardClear];
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
    [randomKeyBoardView refresh:nil];
    return YES;
}

@end
