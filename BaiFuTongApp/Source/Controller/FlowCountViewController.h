//
//  FlowCountViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface FlowCountViewController : AbstractViewController

@property(nonatomic, strong)UILabel *todayUsedGprsLabel;
@property(nonatomic, strong)UILabel *monthUsedGprsLabel;
@property(nonatomic, strong)UILabel *todayUsedWifiLabel;
@property(nonatomic, strong)UILabel *monthUserdWifiLabel;
@end
