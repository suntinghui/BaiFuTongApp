//
//  TradeDetailViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "DateTextField.h"
#import "AbstractViewController.h"
#import "PwdLeftTextField.h"

@interface TradeDetailViewController : AbstractViewController

@property(nonatomic, strong) DateTextField       *beginDateTF;
@property(nonatomic, strong) DateTextField       *endDateTF;
@property(nonatomic, strong) PwdLeftTextField    *pwdTF;

-(BOOL)checkValue;

@end