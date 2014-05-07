//
//  RegisterViewController.h
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "PwdLeftTextField.h"
#import "InputTextField.h"
#import "LeftTextField.h"

@interface RegisterViewController : AbstractViewController<UITextFieldDelegate>

@property(nonatomic, strong)InputTextField *realNameTF;
@property(nonatomic, strong)InputTextField *enterNameTF;
@property(nonatomic, strong)InputTextField *pIdNoTF;
@property(nonatomic, strong)InputTextField *phoneNoTF;
@property(nonatomic, strong)PwdLeftTextField *PwdTF;
@property(nonatomic, strong)PwdLeftTextField *confirmPwdTF;
@property(nonatomic, strong) LeftTextField    *securityCodeTF;
@property(nonatomic, strong) UIButton        *securityCodeButton;

@end
