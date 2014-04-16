//
//  InsertAnnouncementModel.h
//  POS2iPhone
//
//  Created by  STH on 1/11/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnouncementModel : NSObject
{
    NSString        *_number;
    NSString        *_title;
    NSString        *_date;
    NSString        *_content;
}

@property (nonatomic, strong) NSString      *number;
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSString      *date;
@property (nonatomic, strong) NSString      *content;

- (AnnouncementModel *) initWithDic:(NSDictionary *) dic;

@end
