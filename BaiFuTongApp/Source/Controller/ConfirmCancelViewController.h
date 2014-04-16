//
//  ConfirmCancelViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

#import "PwdLeftTextField.h"
#import "SuccessTransferModel.h"

@interface ConfirmCancelViewController : AbstractViewController

@property (nonatomic, strong) PwdLeftTextField *pwdTF;
@property (nonatomic, strong) SuccessTransferModel *model;

- (id) initWithModel:(SuccessTransferModel *) model;

@end
