//
//  AnnouncementDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 1/10/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "AnnouncementDBHelper.h"

@implementation AnnouncementDBHelper

+ (BOOL) createTable:(FMDatabase *) db
{
    BOOL flag = [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, number TEXT, title TEXT, date TEXT, content TEXT)", kAnnouncementTableName]];
    
    return flag;
}

// 保存一条公告信息
- (BOOL) insertAnnouncement:(AnnouncementModel *) model
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (number, title, date, content) VALUES (?,?,?,?)", kAnnouncementTableName];
        
        BOOL flag = [db executeUpdate:sql, [model number], [model title], [model date], [model content]];
        
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

// 查询所有公告信息
- (NSArray *) queryAllAnnouncement
{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"SELECT number, title, date, content FROM %@", kAnnouncementTableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            AnnouncementModel *model = [[AnnouncementModel alloc] init];
            [model setNumber:[resultSet stringForColumnIndex:0]];
            [model setTitle:[resultSet stringForColumnIndex:1]];
            [model setDate:[resultSet stringForColumnIndex:2]];
            [model setContent:[resultSet stringForColumnIndex:3]];
            
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

// 删除一条公告
- (BOOL) deleteAnouncement:(NSString *) number
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE number = ?", kAnnouncementTableName];
        BOOL flag = [db executeUpdate:sql, number];
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
