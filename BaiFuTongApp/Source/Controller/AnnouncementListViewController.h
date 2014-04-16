//
//  AnnouncementListViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface AnnouncementListViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)UITableView *tableView;

- (void) refreshTabelView;

@end
