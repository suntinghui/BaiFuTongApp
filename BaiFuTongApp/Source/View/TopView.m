//
//  TopView.m
//  POS2iPhone
//
//  Created by jia liao on 1/9/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "TopView.h"

#define ORIGIN 10
#define HEIGHT 40
@implementation TopView
@synthesize localPhoneLabel = _localPhoneLabel;
@synthesize dateLabel = _dateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"torn.png"]]];
        UILabel *tmpLocalPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORIGIN, 0, 70, HEIGHT)];
        [tmpLocalPhoneLabel setBackgroundColor:[UIColor clearColor]];
        tmpLocalPhoneLabel.text = @"注册号码:";
        [tmpLocalPhoneLabel setTextColor:[UIColor orangeColor]];
        [tmpLocalPhoneLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:tmpLocalPhoneLabel];
        
        self.localPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 110, HEIGHT)];
        [self.localPhoneLabel setTextColor:[UIColor orangeColor]];
        [self.localPhoneLabel setFont:[UIFont systemFontOfSize:14]];
        [self.localPhoneLabel setBackgroundColor:[UIColor clearColor]];
        self.localPhoneLabel.text = [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PHONENUM"];
        [self addSubview:self.localPhoneLabel];
        
        NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *curDate = [NSDate date];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSString * curTime = [formater stringFromDate:curDate];
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 80, HEIGHT)];
        dateLabel.text = curTime;
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor blackColor]];
        [dateLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:dateLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
