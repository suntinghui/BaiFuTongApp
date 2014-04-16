//
//  LoginViewController.h
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "LeftTextField.h"
#import "PasswordTextField.h"

@interface LoginViewController : AbstractViewController<UITextFieldDelegate>
{
    BOOL            agreeButtonTouch;
}
@property(nonatomic, strong)IBOutlet LeftTextField    *phoneNumTF;
@property(nonatomic, strong)IBOutlet PasswordTextField    *passwordTF;
@property(nonatomic, strong)IBOutlet UIButton   *forgetPwdButton;
@property(nonatomic, strong)IBOutlet UIButton   *loginButton;
@property(nonatomic, strong)IBOutlet UIButton   *registerButton;

-(IBAction)loginAction:(id)sender;
-(IBAction)regesterAction:(id)sender;

@end