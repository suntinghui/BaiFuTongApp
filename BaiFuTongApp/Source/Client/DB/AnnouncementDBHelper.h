//
//  AnnouncementDBHelper.h
//  POS2iPhone
//
//  Created by  STH on 1/10/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDBHelper.h"
#import "FMDatabase.h"
#import "AnnouncementModel.h"

@interface AnnouncementDBHelper : BaseDBHelper

+ (BOOL) createTable:(FMDatabase *) db;

// 保存一条公告信息
- (BOOL) insertAnnouncement:(AnnouncementModel *) model;
// 查询所有公告信息
- (NSArray *) queryAllAnnouncement;
// 删除一条公告
- (BOOL) deleteAnouncement:(NSString *) number;

@end
