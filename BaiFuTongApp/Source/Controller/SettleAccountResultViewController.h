//
//  SettleAccountResultViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface SettleAccountResultViewController : AbstractViewController

@property (nonatomic, strong) NSDictionary      *dic;

@property (nonatomic, strong) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong) IBOutlet UILabel *debitAmont;
@property (nonatomic, strong) IBOutlet UILabel *debitCount;
@property (nonatomic, strong) IBOutlet UILabel *creditAmont;
@property (nonatomic, strong) IBOutlet UILabel *creditCount;

- (id) initWithParam:(NSDictionary *) dic;
- (IBAction) confirmButtonAction:(id)sender;

@end
