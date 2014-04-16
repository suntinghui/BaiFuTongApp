//
//  OrderPaymentViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "InputTextField.h"

@interface OrderPaymentViewController : AbstractViewController<UITextFieldDelegate>

@property(nonatomic, strong) InputTextField       *orderNODateTF;

@end
