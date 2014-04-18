//
//  TransferHistoryQueryViewController.h
//  YLTiPhone
//
//  Created by liao jia on 14-3-27.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "DateTextField.h"

@interface TransferHistoryQueryViewController : AbstractViewController

@property(nonatomic, strong) DateTextField       *beginDateTF;
@property(nonatomic, strong) DateTextField       *endDateTF;
@end
