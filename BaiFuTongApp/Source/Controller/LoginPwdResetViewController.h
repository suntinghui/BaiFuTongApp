//
//  LoginPwdResetViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-5-7.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "PwdLeftTextField.h"
#import "LeftTextField.h"

@interface LoginPwdResetViewController : AbstractViewController

@property(nonatomic, strong)PwdLeftTextField *PwdTF;
@property(nonatomic, strong)PwdLeftTextField *confirmPwdTF;
@property(nonatomic, strong) LeftTextField    *securityCodeTF;
@property(nonatomic, strong) UIButton        *securityCodeButton;

@end
