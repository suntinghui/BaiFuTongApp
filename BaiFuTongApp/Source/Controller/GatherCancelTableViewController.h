//
//  GatherCancelTableViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import"AbstractViewController.h"
#import "SuccessTransferModel.h"

@interface GatherCancelTableViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView           *myTableView;
@property (nonatomic, strong) NSArray               *array;
@property (nonatomic, strong) SuccessTransferModel  *model;

@end

