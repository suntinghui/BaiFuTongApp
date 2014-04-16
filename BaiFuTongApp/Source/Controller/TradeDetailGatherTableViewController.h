//
//  TradeDetailGatherTableViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface TradeDetailGatherTableViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)NSArray *dataArray;
@property(nonatomic, strong)NSString *beginString;
@property(nonatomic, strong)NSString *endString;
@end
