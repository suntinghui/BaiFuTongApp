//
//  AnnouncementCell.m
//  POS2iPhone
//
//  Created by xushuang on 13-1-30.
//  Copyright (c) 2013年 RYX. All rights reserved.
//

#import "AnnouncementCell.h"

@implementation AnnouncementCell

@synthesize dateLabel;
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 210, 25)];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        titleLabel.backgroundColor = [UIColor clearColor];
        //日期
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 100, 25)];
        dateLabel.backgroundColor = [UIColor clearColor];
        [dateLabel setTextAlignment:NSTextAlignmentRight];
        [dateLabel setFont:[UIFont systemFontOfSize:14]];
        //内容
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 200, 25)];
        contentLabel.backgroundColor = [UIColor clearColor];
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

@end
