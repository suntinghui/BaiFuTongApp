//
//  Palette.h
//  MyPalette
//
//  Created by xiaozhu on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandSignPanel : UIView
{
	float       x;
	float       y;
    
    BOOL        allline;
    
	NSMutableArray* myallpoint;
	NSMutableArray* myallline;	
}

@property float x;
@property float y;

- (id)initWithFrame:(CGRect)frame withText:(NSString *) md5Str;
- (void) drawWaterMarked:(NSString *) md5Str;

- (BOOL) isDraw;

-(void)Introductionpoint1;
-(void)Introductionpoint2;
-(void)Introductionpoint3:(CGPoint)sender;

-(void)myalllineclear;
-(void)myLineFinallyRemove;

@end
