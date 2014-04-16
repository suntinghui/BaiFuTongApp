//
//  SalesSlipViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

#import "DateTextField.h"
#import "AbstractViewController.h"
#import "InputTextField.h"


@interface SalesSlipViewController : AbstractViewController

@property(nonatomic, strong)InputTextField *minMoneyLabel;
@property(nonatomic, strong)InputTextField *maxMoneyLabel;
@property(nonatomic, strong)DateTextField *beginDateTF;
@property(nonatomic, strong)DateTextField *endDateTF;

@end
