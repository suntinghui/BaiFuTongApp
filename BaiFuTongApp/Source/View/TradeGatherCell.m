//
//  TradeGatherCell.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "TradeGatherCell.h"

@implementation TradeGatherCell
@synthesize typeLabel = _typeLabel;
@synthesize totalLabel = _totalLabel;
@synthesize amountLabel = _amountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *tmpType = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 70, 21)];
        [tmpType setText:@"交易类型"];
        [self setLabelStyle:tmpType];
        [self addSubview:tmpType];
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 13, 210, 21)];
        [_typeLabel setText:@"_typeLabel"];
        [self setLabelStyle:_typeLabel];
        [self addSubview:_typeLabel];
        
        UILabel *tmpTotal = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 70, 21)];
        [tmpTotal setText:@"交易笔数"];
        [self setLabelStyle:tmpTotal];
        [self addSubview:tmpTotal];
        _totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 42, 210, 21)];
        [_totalLabel setText:@"_totalLabel"];
        [self setLabelStyle:_totalLabel];
        [self addSubview:_totalLabel];
        
        UILabel *tmpAmount = [[UILabel alloc] initWithFrame:CGRectMake(10, 71, 70, 21)];
        [tmpAmount setText:@"交易金额"];
        [self setLabelStyle:tmpAmount];
        [self addSubview:tmpAmount];
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 71, 210, 21)];
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
    [label setTextAlignment:NSTextAlignmentRight];
}
@end
