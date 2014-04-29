//
//  WithdrawalViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-28.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "InputTextField.h"
#import "LeftTextField.h"

@interface WithdrawalViewController : AbstractViewController

@property (nonatomic, strong) InputTextField      *moneyTF;
@property (nonatomic, strong) LeftTextField      *securityCodeTF;
@property (nonatomic, strong) UIButton           *securityCodeButton;

@end
