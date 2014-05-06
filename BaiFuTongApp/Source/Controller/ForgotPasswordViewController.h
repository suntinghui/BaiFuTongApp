//
//  ForgotPasswordViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-5-6.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "InputTextField.h"

@interface ForgotPasswordViewController : AbstractViewController

@property(nonatomic, strong)InputTextField *pIdNoTF;
@property(nonatomic, strong)InputTextField *phoneNoTF;
@end
