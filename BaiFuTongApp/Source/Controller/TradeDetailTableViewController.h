//
//  TradeDetailTableViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AboutSystemViewController.h"
#import "PageView.h"

@interface TradeDetailTableViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate, PageDelegate>

@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)PageView *pageView;
@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)NSString *beginString;
@property(nonatomic, strong)NSString *endString;
@property(nonatomic, strong)NSString *pageNo;
@property(nonatomic, strong)NSString *pageSize;
@property(nonatomic, strong)NSString *tranCode;
@property(nonatomic, strong)NSString *totalCount;

-(void)requestAction;
-(void)refreshTabelView;

@end

