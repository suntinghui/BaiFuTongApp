//
//  InsertAnnouncementModel.m
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "AnnouncementModel.h"

@implementation AnnouncementModel

@synthesize number = _number;
@synthesize title = _title;
@synthesize date = _date;
@synthesize content = _content;

- (id)init
{
    if (self = [super init]) {
        self.number = @"";
        self.title = @"" ;
        self.date = @"";
        self.content = @"";
    }
    
    return self;
}

- (AnnouncementModel *) initWithDic:(NSDictionary *) dic
{
    if (self = [super init]) {
        if ([[dic allKeys] containsObject:@"id_notice"]) {
            self.number = [dic objectForKey:@"id_notice"];
        }
        if ([[dic allKeys] containsObject:@"title_notice"]) {
            self.title = [dic objectForKey:@"title_notice"];
        }
        if ([[dic allKeys] containsObject:@"content_notice"]) {
            self.content = [dic objectForKey:@"content_notice"];
        }
        if ([[dic allKeys] containsObject:@"effective_date"]) {
            self.date = [dic objectForKey:@"effective_date"];
        }
    }
    
    return self;
}

@end
