//
//  BFTMenuCell.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "BFTMenuCell.h"

#pragma mark -
#pragma mark Constants
NSString const *kSidebarCellTextKey = @"CellText";
NSString const *kSidebarCellImageKey = @"CellImage";

#pragma mark -
#pragma mark Implementation
@implementation BFTMenuCell

#pragma mark Memory Management
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.clipsToBounds = YES;
		
        UIImageView *selectBgView = [[UIImageView alloc] init];
        [selectBgView setImage:[UIImage imageNamed:@"BFTLeftMenuCellBg_hightlight.png"]];
        [selectBgView sizeToFit];
		self.selectedBackgroundView = selectBgView;
		
		self.imageView.contentMode = UIViewContentModeCenter;
		
		self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:([UIFont systemFontSize] * 1.1f)];
		self.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		self.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
		self.textLabel.textColor = [UIColor colorWithRed:(196.0f/255.0f) green:(204.0f/255.0f) blue:(218.0f/255.0f) alpha:1.0f];
        
		UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		topLine.backgroundColor = [UIColor colorWithRed:(54.0f/255.0f) green:(61.0f/255.0f) blue:(76.0f/255.0f) alpha:1.0f];
		[self.textLabel.superview addSubview:topLine];
		
		UIView *topLine2 = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		topLine2.backgroundColor = [UIColor colorWithRed:(54.0f/255.0f) green:(61.0f/255.0f) blue:(77.0f/255.0f) alpha:1.0f];
		[self.textLabel.superview addSubview:topLine2];
		
		UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		bottomLine.backgroundColor = [UIColor colorWithRed:(40.0f/255.0f) green:(47.0f/255.0f) blue:(61.0f/255.0f) alpha:1.0f];
		[self.textLabel.superview addSubview:bottomLine];
        
        
	}
	return self;
}

#pragma mark UIView
- (void)layoutSubviews {
	[super layoutSubviews];
	self.textLabel.frame = CGRectMake(40.0f, 4.0f, 120.0f, 43.0f);
	self.imageView.frame = CGRectMake(10.0f, 11.0f, 21.0f, 21.0f);
}

@end

