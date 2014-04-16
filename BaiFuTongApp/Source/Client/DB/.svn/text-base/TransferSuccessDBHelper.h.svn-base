//
//  TransferSuccessDBHelper.h
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBHelper.h"

@class SuccessTransferModel;

@interface TransferSuccessDBHelper : BaseDBHelper

+ (BOOL) createTable:(FMDatabase *) db;

// 在交易成功后添加一个成功的交易，这时是没有签名图片和手机号的。在签完字后Update。
- (BOOL) insertASuccessTrans:(SuccessTransferModel *) model;
// 查询出所有的需要进行消费撤销的交易，注意查询条件必须是 当日 本批次的交易 且 是消费交易 且 该消费交易没有被撤销过
- (NSArray *) queryNeedRevokeTransfer;
// 查询符合条件的成功交易
- (NSArray *) queryTransfersWithMinAmount:(NSString *) minAmount maxAmount:(NSString *) maxAmount startDate:(NSString *) startDate endDate:(NSString *) endDate;
// 当一个交易被撤销成功后，将原消费交易置为已经撤销
- (BOOL) updateRevokeFalg:(NSString *) transNum;
// 在更换批次时删除所有的交易
- (BOOL) deleteAllTransfer;

@end
