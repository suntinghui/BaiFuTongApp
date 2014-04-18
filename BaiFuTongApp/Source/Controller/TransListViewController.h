//
//  TransListViewController.h
//  YLTiPhone
//
//  Created by xushuang on 13-12-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

//交易查询列表 
#import "AbstractViewController.h"
#import "PageView.h"

@interface TransListViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate, PageDelegate>

@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)PageView *pageView;
@property(nonatomic, strong)NSArray *array;
@property(nonatomic, strong)NSString *beginString;
@property(nonatomic, strong)NSString *endString;
@property(nonatomic, strong)NSString *pageNo;
@property(nonatomic, strong)NSString *pageSize;
@property(nonatomic, strong)NSString *tranCode;
@property(nonatomic, strong)NSString *totalCount;
@property(nonatomic, assign)int pageType; //0:当天的记录 1：历史记录

-(void)requestAction;
-(void)refreshTabelView;

@end
