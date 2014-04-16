//
//  Palette.m
//  MyPalette
//
//  Created by xiaozhu on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HandSignPanel.h"

@implementation HandSignPanel

@synthesize x;
@synthesize y;

#define  DEFAULT_COLOR         [[UIColor blackColor] CGColor]
#define  DEFAULT_WIDTH          3.0f

- (id)initWithFrame:(CGRect)frame withText:(NSString *) md5Str
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawWaterMarked:md5Str];
    }
    
    return self;
	
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{    
	//获取上下文
	CGContextRef context=UIGraphicsGetCurrentContext();
	//设置笔冒
	CGContextSetLineCap(context, kCGLineCapRound);
	//设置画线的连接处　拐点圆滑
	CGContextSetLineJoin(context, kCGLineJoinRound);
	//第一次时候个myallline开辟空间
	if (allline==NO)
	{
		myallline=[[NSMutableArray alloc] initWithCapacity:10];
		allline=YES;
	}
    
	//画之前线
	if ([myallline count]>0)
	{
		for (int i=0; i<[myallline count]; i++)
		{
			NSArray* tempArray=[NSArray arrayWithArray:[myallline objectAtIndex:i]];
			
			if ([tempArray count]>1)
			{
				CGContextBeginPath(context);
				CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
				CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
				
				for (int j=0; j<[tempArray count]-1; j++)
				{
					CGPoint myEndPoint=[[tempArray objectAtIndex:j+1] CGPointValue];
					CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);	
				}
				CGContextSetStrokeColorWithColor(context, DEFAULT_COLOR);
				CGContextSetLineWidth(context, DEFAULT_WIDTH);
				CGContextStrokePath(context);
			}
		}
	}
    
	//画当前的线
	if ([myallpoint count]>1)
	{
		CGContextBeginPath(context);
		//起点
		CGPoint myStartPoint=[[myallpoint objectAtIndex:0]   CGPointValue];
		CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
		//把move的点全部加入　数组
		for (int i=0; i<[myallpoint count]-1; i++)
		{
			CGPoint myEndPoint=  [[myallpoint objectAtIndex:i+1] CGPointValue];
			CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
		}
		
		//绘制画笔颜色
		CGContextSetStrokeColorWithColor(context, DEFAULT_COLOR);
		CGContextSetFillColorWithColor (context,  DEFAULT_COLOR);
		//绘制画笔宽度
		CGContextSetLineWidth(context, DEFAULT_WIDTH);
		//把数组里面的点全部画出来
		CGContextStrokePath(context);
	}
}

- (void) drawWaterMarked:(NSString *) md5Str
{
    /**
    UIImage *myImage = [UIImage imageNamed:@"sign_middle.png"];
    UIImage *watermarkedImage = nil;
    UIGraphicsBeginImageContext(myImage.size);
    
    [myImage drawAtPoint: CGPointZero];
    [[UIColor lightGrayColor] set];
    
    int a = iPhone5 ? 64 :20;
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<8; j++) {
            [[md5Str substringWithRange:NSMakeRange((i*8)+j, 1)] drawAtPoint: CGPointMake(a+58*j, 20+42*i) withFont: [UIFont italicSystemFontOfSize:35]];
        }
    }
    watermarkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundColor:[UIColor colorWithPatternImage:watermarkedImage]];
     **/
}

//初始化
-(void)Introductionpoint1
{
	myallpoint=[[NSMutableArray alloc] initWithCapacity:10];
}

//把画过的当前线放入　存放线的数组
-(void)Introductionpoint2
{
	[myallline addObject:myallpoint];
}

-(void)Introductionpoint3:(CGPoint)sender
{
	NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
	[myallpoint addObject:pointvalue];
}

//清屏
-(void)myalllineclear
{
	if ([myallline count]>0)
	{
		[myallline removeAllObjects];
		[myallpoint removeAllObjects];
		myallline=[[NSMutableArray alloc] initWithCapacity:10];
		[self setNeedsDisplay];
	}
}

//撤销
-(void)myLineFinallyRemove
{
	if ([myallline count]>0)
	{
		[myallline  removeLastObject];
		[myallpoint removeAllObjects];
	}
	[self setNeedsDisplay];	
}

- (BOOL) isDraw
{
    return [myallline count] > 0;
}

@end
