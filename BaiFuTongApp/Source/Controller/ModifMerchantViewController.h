//
//  ModifMerchantViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "PwdLeftTextField.h"
#import "InputTextField.h"

@interface ModifMerchantViewController : AbstractViewController

@property(nonatomic, strong)PwdLeftTextField *originalPwdTF;
@property(nonatomic, strong)PwdLeftTextField *freshPwdTF;
@property(nonatomic, strong)PwdLeftTextField *confirmPwdTF;

@end
