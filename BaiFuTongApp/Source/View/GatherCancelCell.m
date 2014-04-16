//
//  GatherCancelCell.m
//  POS2iPhone
//
//  Created by jia liao on 1/17/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "GatherCancelCell.h"

@implementation GatherCancelCell
@synthesize timeLabel = _timeLabel;
@synthesize amountLabel = _amountLabel;
@synthesize accountLabel = _accountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *tmpTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 70, 21)];
        [tmpTime setText:@"交易时间:"];
        [tmpTime setTextAlignment:NSTextAlignmentLeft];
        [self setLabelStyle:tmpTime];
        [self addSubview:tmpTime];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 13, 220, 21)];
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
        [_timeLabel setText:@"_timeLabel"];
        [self setLabelStyle:_timeLabel];
        [self addSubview:_timeLabel];
        
        UILabel *tmpAccount = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 70, 21)];
        [tmpAccount setTextAlignment:NSTextAlignmentLeft];
        [tmpAccount setText:@"交易账号:"];
        [self setLabelStyle:tmpAccount];
        [self addSubview:tmpAccount];
        
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 42, 220, 21)];
        [_accountLabel setTextAlignment:NSTextAlignmentRight];
        [_accountLabel setText:@"_accountLabel"];
        [self setLabelStyle:_accountLabel];
        [self addSubview:_accountLabel];
        
        UILabel *tmpAmount = [[UILabel alloc] initWithFrame:CGRectMake(10, 71, 70, 21)];
        [tmpAmount setTextAlignment:NSTextAlignmentLeft];
        [tmpAmount setText:@"交易金额:"];
        [self setLabelStyle:tmpAmount];
        [self addSubview:tmpAmount];
        
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 71, 220, 21)];
        [_amountLabel setTextAlignment:NSTextAlignmentRight];
        [_amountLabel setText:@"_amountLabel"];
        [self setLabelStyle:_amountLabel];
        [self addSubview:_amountLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLabelStyle:(UILabel*)label
{
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:15]];
}
@end
