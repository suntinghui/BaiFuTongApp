//
//  ReversalDBHelper.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBHelper.h"

@class ReversalTransferModel;

@interface ReversalDBHelper : BaseDBHelper

+ (BOOL) createTable:(FMDatabase *) db;

// 当一个交易需要冲正时，记录该交易的发送报文，以备冲正
- (BOOL) insertATransfer:(ReversalTransferModel *) model;
// 查询出所有的冲正记录
- (NSArray *) queryAllReversalTrans;
// 查询出需要冲正的那条记录，如果存在的话
- (NSDictionary *) queryTheNeedReversalTrans;
// 当冲正成功后，修改冲正状态为成功
- (BOOL) updateReversalState:(NSString *) transNum;
// 当冲正失败后，修改冲正次数
- (BOOL) updateReversalCount:(NSString *) transNum;
// 删除一条冲正记录
- (BOOL) deleteAReversalTrans:(NSString *) traceNum;
// 清空冲正表
- (BOOL) deleteAll;

@end
