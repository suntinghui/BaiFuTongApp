//
//  TradeDetailCell.m
//  POS2iPhone
//
//  Created by jia liao on 1/15/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "TradeDetailCell.h"

@implementation TradeDetailCell
@synthesize typeLabel = _typeLabel;
@synthesize amountLabel = _amountLabel;
@synthesize timeLabel = _timeLabel;
@synthesize accountLabel = _accountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *tmpType = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 68, 21)];
        [tmpType setText:@"交易类型"];
        [self setLabelStyle:tmpType];
        [self addSubview:tmpType];
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 13, 200, 21)];
        [_typeLabel setText:@"_typeLabel"];
        [self setLabelStyle:_typeLabel];
        [self addSubview:_typeLabel];
        
        UILabel *tmpAmount = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 68, 21)];
        [tmpAmount setText:@"交易金额"];
        [self setLabelStyle:tmpAmount];
        [self addSubview:tmpAmount];
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 42, 200, 21)];
        [_amountLabel setText:@"_amountLabel"];
        [self setLabelStyle:_amountLabel];
        [self addSubview:_amountLabel];
        
        UILabel *tmpTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 71, 68, 21)];
        [tmpTime setText:@"交易时间"];
        [self setLabelStyle:tmpTime];
        [self addSubview:tmpTime];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 71, 200, 21)];
        [_timeLabel setText:@"_timeLabel"];
        [self setLabelStyle:_timeLabel];
        [self addSubview:_timeLabel];
        
        UILabel *tmpAccount = [[UILabel alloc] initWithFrame:CGRectMake(10, 99, 68, 21)];
        [tmpAccount setText:@"付款卡号"];
        [self setLabelStyle:tmpAccount];
        [self addSubview:tmpAccount];
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 99, 200, 21)];
        [_accountLabel setText:@"_accountLabel"];
        [self setLabelStyle:_accountLabel];
        [self addSubview:_accountLabel];
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
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    [label setTextAlignment:NSTextAlignmentRight];
}
@end
