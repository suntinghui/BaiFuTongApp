//
//  LeftTextField.m
//  POS2iPhone
//
//  Created by jia liao on 1/24/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "LeftTextField.h"

@implementation LeftTextField

@synthesize contentTF = _contentTF;

- (id)initWithFrame:(CGRect)frame isLong:(BOOL)isLong
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        NSString *imageName = nil;
        if (isLong) {
            imageName = @"loginInputbg_long.png";
        }else{
            imageName = @"loginInputbg_short.png";
        }
        [bgIV setImage:[UIImage imageNamed:@"loginInputbg_long.png"]];
        [self addSubview:bgIV];
        
        self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, frame.size.width, frame.size.height)];
        [self.contentTF setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.contentTF];
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
