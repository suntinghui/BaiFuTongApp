//
//  ReversalDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "ReversalDBHelper.h"
#import "FMDatabase.h"
#import "ReversalTransferModel.h"
#import "StringUtil.h"
#import "SystemConfig.h"

@implementation ReversalDBHelper

+ (BOOL) createTable:(FMDatabase *) database
{
    BOOL flag = [database executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, tracenum TEXT, batchNum TEXT, date TEXT, content TEXT, state INTEGER, count INTEGER)", kReversalTableName]];
    
    return flag;
}

- (BOOL) insertATransfer:(ReversalTransferModel *) model
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (tracenum, batchNum, date, content, state, count) VALUES (?,?,?,?,?,?)", kReversalTableName];
        
        BOOL flag = [db executeUpdate:sql, [model traceNum], [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__BATCHNUM"], [model date], [StringUtil dictionary2String:[model content]], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0]];
        
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

- (NSArray *) queryAllReversalTrans
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSMutableArray *array = [NSMutableArray array];
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT content, state, count FROM %@", kReversalTableName]];
        while ([resultSet next]) {
            ReversalTransferModel *model = [[ReversalTransferModel alloc] init];
            [model setContent:[StringUtil string2Dictionary:[resultSet stringForColumnIndex:0]]];
            [model setState:[resultSet intForColumnIndex:1]];
            [model setCount:[resultSet intForColumnIndex:2]];
            
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

- (NSDictionary *) queryTheNeedReversalTrans
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSMutableString *mutableStr = [[NSMutableString alloc] init];
        [mutableStr appendFormat:@"SELECT content FROM %@", kReversalTableName];
        [mutableStr appendFormat:@" WHERE state=1 AND count<%d", [[SystemConfig sharedSystemConfig] maxReversalCount]];
        [mutableStr appendFormat:@" AND datetime(date) = datetime('%@", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__yyyy-MM-dd"]];
        [mutableStr appendFormat:@"') AND batchNum = '%@", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__BATCHNUM"]];
        [mutableStr appendFormat:@"' AND id = (SELECT MAX(id) FROM %@ )", kReversalTableName];
        
        FMResultSet *resultSet = [db executeQuery:mutableStr];
        if ([resultSet next]) {
            return [StringUtil string2Dictionary:[resultSet stringForColumnIndex:0]];
        }
        
        return nil;
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

- (BOOL) updateReversalState:(NSString *) transNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET state=0 WHERE tracenum = ?", kReversalTableName];
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

- (BOOL) updateReversalCount:(NSString *) transNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSMutableString *sql = [[NSMutableString alloc] init];
        [sql appendFormat:@"UPDATE %@ SET count = (SELECT count FROM %@", kReversalTableName, kReversalTableName];
        [sql appendFormat:@" WHERE tracenum = ?) + 1 WHERE tracenum = ?"];
        BOOL flag = [db executeUpdate:sql, transNum, transNum];
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

- (BOOL) deleteAReversalTrans:(NSString *) traceNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE tracenum = ?", kReversalTableName];
        BOOL flag = [db executeUpdate:sql, traceNum];
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

- (BOOL) deleteAll
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@", kReversalTableName];
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
