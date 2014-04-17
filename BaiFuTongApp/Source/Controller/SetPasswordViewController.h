//
//  SetPasswordViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "PwdLeftTextField.h"
#import "InputTextField.h"
#import "LeftTextField.h"

@interface SetPasswordViewController : AbstractViewController

@property(nonatomic, strong)PwdLeftTextField *PwdTF;
@property(nonatomic, strong)InputTextField *pIdNoTF;
@property(nonatomic, strong) LeftTextField    *securityCodeTF;
@property(nonatomic, strong) UIButton        *securityCodeButton;

@end
