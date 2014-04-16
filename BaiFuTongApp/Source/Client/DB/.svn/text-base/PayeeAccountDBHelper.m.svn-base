//
//  PayeeAccountDBHelper.m
//  POS2iPhone
//
//  Created by  STH on 11/27/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "PayeeAccountDBHelper.h"
#import "FMDatabase.h"
#import "PayeeAccountModel.h"

@implementation PayeeAccountDBHelper

+ (BOOL) createTable:(FMDatabase *) database
{
    BOOL flag = [database executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, accountNo TEXT, name TEXT, phoneNo TEXT, bank TEXT, bankCode TEXT)", kPayeeAccountTableName]];
    
    return flag;
}

- (NSArray*) queryAll
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT accountNo, name, phoneNo, bank, bankCode FROM %@", kPayeeAccountTableName]];
        while ([resultSet next]) {
            PayeeAccountModel *account = [[PayeeAccountModel alloc] init];
            [account setAccountNo:[resultSet stringForColumnIndex:0]];
            [account setAccountName:[resultSet stringForColumnIndex:1]];
            [account setPhoneNo:[resultSet stringForColumnIndex:2]];
            [account setBankName:[resultSet stringForColumnIndex:3]];
            [account setBankCode:[resultSet stringForColumnIndex:4]];
            
            [array addObject:account];
        }
        
        return array;
    }
    @finally {
        [db close];
    }
}

- (PayeeAccountModel *) queryAccountWithAccountNo:(NSString *) theAccountNo
{
    PayeeAccountModel *account = nil;
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        FMResultSet *resultSet = [db executeQuery:[NSString stringWithFormat:@"SELECT name, phoneNo, bank, bankCode FROM %@ WHERE accountNo = ?", kPayeeAccountTableName], theAccountNo];
        while ([resultSet next]) {
            account = [[PayeeAccountModel alloc] init];
            [account setAccountNo:theAccountNo];
            [account setAccountName:[resultSet stringForColumnIndex:0]];
            [account setPhoneNo:[resultSet stringForColumnIndex:1]];
            [account setBankName:[resultSet stringForColumnIndex:2]];
            [account setBankCode:[resultSet stringForColumnIndex:3]];
        }
        
        return account;
    }
    @finally {
        [db close];
    }
}

- (BOOL) insertAPayeeAccount:(PayeeAccountModel *) model
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    @try {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (accountNo, name, phoneNo, bank, bankCode) VALUES (?,?,?,?,?)",kPayeeAccountTableName];
        
        BOOL flag = [db executeUpdate:sql, [model accountNo], [model accountName], [model phoneNo], [model bankName], [model bankCode]];
        
        return flag;
    }
    @finally {
        [db close];
    }
}

- (BOOL) deletePayeeAccounts:(NSArray *) theArray
{
    FMDatabase *db = [BaseDBHelper getOpenedFMDatabase];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE accountNo = ?", kPayeeAccountTableName];
    BOOL result = true;
    @try {
        for (PayeeAccountModel *model in theArray) {
            BOOL flag = [db executeUpdate:sql, [model accountNo]];
            result = result && flag;
        }
        
        return result;
    }
    @catch (NSException *exception) {
        return false;
    }
    @finally {
        [db close];
    }
}

@end
