//
//  UploadSignImageDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 1/10/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "UploadSignImageDBHelper.h"
#import "StringUtil.h"
#import "SystemConfig.h"

@interface UploadSignImageDBHelper (private)

- (BOOL) updateUploadFlag:(FMDatabase *) db traceNum:(NSString *) traceNum;
- (BOOL) deleteATransfer:(FMDatabase *) db traceNum:(NSString *) traceNum;

@end

@implementation UploadSignImageDBHelper

+ (BOOL) createTable:(FMDatabase *) db
{
    BOOL flag = [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, tracenum TEXT, uploadFlag INTEGER, receMobile TEXT, content TEXT)", kUploadSignImageTableName]];
    
    return flag;
}

// 在交易成功后添加一个成功的交易，这时是没有签名图片和手机号的。在签完字后Update。
- (BOOL) insertATransfer:(NSString *) traceNum receMobile:(NSString *) receMobile content:(NSDictionary *) contentDic
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (tracenum,uploadFlag,receMobile,content) VALUES (?,?,?,?)", kUploadSignImageTableName];
        
        BOOL flag = [db executeUpdate:sql, traceNum, [NSNumber numberWithInt:1], receMobile, [StringUtil dictionary2String:contentDic]];
        
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

- (NSString *) queryReceMobile:(NSString *)traceNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"SELECT receMobile FROM %@ WHERE tracenum = ?", kUploadSignImageTableName];
        FMResultSet *resultSet = [db executeQuery:sql, traceNum];
        if ([resultSet next]) {
            return [resultSet stringForColumnIndex:0];
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

- (NSArray *) queryNeedUploadSignImageTransfer
{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"SELECT tracenum, uploadFlag, content FROM %@", kUploadSignImageTableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            int count = [resultSet intForColumnIndex:1];
            // 已经成功上传或超过设置的上传签购单的最大次数,则删除该交易
            if (count==0 || count > [[SystemConfig sharedSystemConfig] maxUploadSignImageCount]){
                [self deleteATransfer:db traceNum:[resultSet stringForColumnIndex:0]];
            } else {
                [self updateUploadFlag:db traceNum:[resultSet stringForColumnIndex:0]];
                
                [array addObject:[StringUtil string2Dictionary:[resultSet stringForColumnIndex:2]]];
            }
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

- (NSDictionary *) queryAUploadSignImageTransfer
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"SELECT tracenum, uploadFlag, content FROM %@ ORDER BY id DESC LIMIT 0,1", kUploadSignImageTableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            int count = [resultSet intForColumnIndex:1];
            // 已经成功上传或超过设置的上传签购单的最大次数,则删除该交易
            if (count==0 || count > [[SystemConfig sharedSystemConfig] maxUploadSignImageCount]){
                [self deleteATransfer:db traceNum:[resultSet stringForColumnIndex:0]];
            } else {
                [self updateUploadFlag:db traceNum:[resultSet stringForColumnIndex:0]];
                
                return [StringUtil string2Dictionary:[resultSet stringForColumnIndex:2]];
            }
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

- (BOOL) deleteATransfer:(FMDatabase *) db traceNum:(NSString *) traceNum
{
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE tracenum = ?", kTransferSuccessTableName];
        BOOL flag = [db executeUpdate:sql, traceNum];
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return false;
    }
}

- (BOOL) updateUploadFlagSuccess:(NSString *) traceNum
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET uploadFlag = 0 WHERE tracenum = ?", kUploadSignImageTableName];
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

- (BOOL) updateUploadFlag:(FMDatabase *) db traceNum:(NSString *) traceNum
{
    @try {
        NSMutableString *sql = [[NSMutableString alloc] init];
        [sql appendFormat:@"UPDATE %@ SET uploadFlag = (SELECT uploadFlag FROM %@", kUploadSignImageTableName, kUploadSignImageTableName];
        [sql appendFormat:@" WHERE tracenum = ?) + 1 WHERE tracenum = ?"];
        BOOL flag = [db executeUpdate:sql, traceNum, traceNum];
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"exception throw->%@",exception);
        NSLog(@"exception call stack->%@",[exception callStackSymbols]);
        
        return false;
    }
}

@end
