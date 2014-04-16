//
//  PayeeAccountDBHelper.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBHelper.h"

@class PayeeAccountModel;

@interface PayeeAccountDBHelper : BaseDBHelper

+ (BOOL) createTable:(FMDatabase *) db;

// 查询出所有的收款人数据
- (NSArray*) queryAll;
// 根据账号检索一个收款人信息
- (PayeeAccountModel *) queryAccountWithAccountNo:(NSString *) theAccountNo;
// 插入一条数据
- (BOOL) insertAPayeeAccount:(PayeeAccountModel *) model;
// 删除选定的收款人
- (BOOL) deletePayeeAccounts:(NSArray *) theArray;


@end
