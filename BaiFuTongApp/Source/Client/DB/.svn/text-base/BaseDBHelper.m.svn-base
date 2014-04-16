//
//  BaseDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "BaseDBHelper.h"
#import "FMDatabase.h"
#import "PayeeAccountDBHelper.h"
#import "ReversalDBHelper.h"
#import "TransferSuccessDBHelper.h"
#import "UploadSignImageDBHelper.h"
#import "AnnouncementDBHelper.h"

@implementation BaseDBHelper

+ (void) createDataBase
{
    BOOL success;
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:[self getDatabaseFilePath]];

    //　如果数据库存在，则直接返回
    if (success) {
        return;
    }
	
    //　数据库不存在，则创建数据库和各种表
	FMDatabase *database = [self getFMDatabase];
    if ([database open]) {
        [database setShouldCacheStatements:YES];
        
        [PayeeAccountDBHelper createTable:database];
        [ReversalDBHelper createTable:database];
        [TransferSuccessDBHelper createTable:database];
        [UploadSignImageDBHelper createTable:database];
        [AnnouncementDBHelper createTable:database];
        
        [database close];
    }else{
        
        NSLog(@"打开数据库失败！");
    }

}

+ (NSString *) getDatabaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:kDataBaseName];
    
    return dbFilePath;
}

+ (FMDatabase *) getFMDatabase
{
    return [FMDatabase databaseWithPath:[self getDatabaseFilePath]];
}

+ (FMDatabase *) getOpenedFMDatabase
{
    FMDatabase *database = [FMDatabase databaseWithPath:[self getDatabaseFilePath]];
    if ([database open]) {
        [database setShouldCacheStatements:YES];
    }
    
    // TODO 如果数据库打开失败应该怎么处理？
    
    return database;
}

@end
