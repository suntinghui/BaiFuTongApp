//
//  TransferSuccessDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "TransferSuccessDBHelper.h"
#import "FMDatabase.h"
#import "SuccessTransferModel.h"
#import "StringUtil.h"
#import "DateUtil.h"

@implementation TransferSuccessDBHelper

+ (BOOL) createTable:(FMDatabase *) database
{
    BOOL flag = [database executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, tracenum TEXT, transCode TEXT,batchNum TEXT, date TEXT, amount TEXT, content TEXT, revoke INTEGER)", kTransferSuccessTableName]];
    
    return flag;
}

- (BOOL) insertASuccessTrans:(SuccessTransferModel *) model
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (tracenum,transCode,batchNum,date,amount,content,revoke) VALUES (?,?,?,?,?,?,?)", kTransferSuccessTableName];
        
        BOOL flag = [db executeUpdate:sql, [model traceNum], [model transCode], [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__BATCHNUM"], [model date], [model amount], [StringUtil dictionary2String:[model content]], [NSNumber numberWithInt:1]];
        
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return false;
    }
    @finally {
        [db close];
    }
    
}

- (NSArray *) queryNeedRevokeTransfer
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    NSMutableArray *array = [NSMutableArray array];
    @try {
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        [mutableString appendFormat:@"SELECT content FROM %@ WHERE ", kTransferSuccessTableName];
        [mutableString appendString:@"transCode = '200000022' AND revoke = 1 AND batchNum = ?  AND datetime(date) = datetime(?)"];
        FMResultSet *resultSet = [db executeQuery:mutableString, [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__BATCHNUM"], [[AppDataCenter sharedAppDataCenter] getServerDate]];
        
        while ([resultSet next]) {
            SuccessTransferModel *model = [[SuccessTransferModel alloc] init];
            [model setContent:[StringUtil string2Dictionary:[resultSet stringForColumnIndex:0]]];
            [array addObject:model];
        }
        
        return array;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return nil;
    }
    @finally {
        [db close];
    }
}

- (NSArray *) queryTransfersWithMinAmount:(NSString *) minAmount maxAmount:(NSString *) maxAmount startDate:(NSString *) startDate endDate:(NSString *) endDate
{   
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    NSMutableArray *array = [NSMutableArray array];
    @try {
        NSString *sql = [NSString stringWithFormat:@"SELECT content FROM %@ WHERE amount BETWEEN ? AND ? AND datetime(date) >=  datetime(?) AND datetime(date) <= datetime(?)", kTransferSuccessTableName];
        
        FMResultSet *resultSet = [db executeQuery:sql, minAmount, maxAmount, startDate, endDate];

        while ([resultSet next]) {
            [array addObject:[StringUtil string2Dictionary:[resultSet stringForColumnIndex:0]]];
        }
        
        return array;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return nil;
    }
    @finally {
        [db close];
    }
}

- (BOOL) updateRevokeFalg:(NSString *) transNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET revoke = 0 WHERE tracenum = ?", kTransferSuccessTableName];
        BOOL flag = [db executeUpdate:sql, transNum];
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return false;
    }
    @finally {
        [db close];
    }
}

- (BOOL) deleteAllTransfer
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@", kTransferSuccessTableName];
        BOOL flag = [db executeUpdate:sql];
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return false;
    }
    @finally {
        [db close];
    }
}


@end
