//
//  RandomKeyBoardView.m
//  RandomKeyBoard
//
//  Created by jia liao on 7/8/12.
//  Copyright (c) 2012 huaihua. All rights reserved.
//

#import "RandomKeyBoardView.h"

#define kButtonSizeWidth 67.0f
#define kButtonSizeHeight 40.0f
#define kConfirmButtonSizeWidth 65.0f
#define kConfirmButtonSizeHeight 89.0f
#define kIntervalWidth 11.0f
#define kIntervalHeight 8.0f

@implementation RandomKeyBoardView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self refresh:nil];
    }
    return self;
}

-(void)refresh:(id)sender
{
    // set the background image
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320, 238)];
    [backgroundImageView setImage:[UIImage imageNamed:@"bg.png"]];
    [self addSubview:backgroundImageView];
    
    NSMutableArray *numberMuArray = [[NSMutableArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
    // add the button
    int i = 10;
    NSString *nomalStr = @"button_nomal";
    NSString *selectStr = @"button_nomal";

    for (int x = 0; x < 14; x++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(x%3*(kButtonSizeWidth + kIntervalWidth) + kIntervalWidth, x/3*(kButtonSizeHeight + kIntervalHeight) + kIntervalHeight, 
                                 kButtonSizeWidth, kButtonSizeHeight)];
        if (x < 9) 
        {
            nomalStr = @"button_nomal";
            selectStr = @"button_nomal";
            int aa = 0;
            aa = arc4random() % (i--);
            [btn setTag:(((NSString*)[numberMuArray objectAtIndex:aa]).intValue)];
            [numberMuArray removeObjectAtIndex:aa];
            [btn setTitle:[NSString stringWithFormat:@"%d", btn.tag] forState:UIControlStateNormal];
        }
        else if(x == 9){
            nomalStr = @"button_nomal";
            selectStr = @"button_nomal";
            btn.tag = 10;
            [btn setTitle:@"关 于" forState:UIControlStateNormal];
            
        }
        else if (x == 11)
        {
            nomalStr = @"button_nomal";
            selectStr = @"button_nomal";
            btn.tag = x;
            [btn setTitle:@"清 空" forState:UIControlStateNormal];
           
        }
        else if (x == 10)
        {
            nomalStr = @"button_nomal";
            selectStr = @"button_nomal";
            btn.tag = ((NSString*)[numberMuArray lastObject]).intValue;
            [btn setTitle:[NSString stringWithFormat:@"%d", btn.tag] forState:UIControlStateNormal];
            
        } else if(x == 12){
            nomalStr = @"confirmButton_nomal";
            selectStr = @"confirmButton_select";
            btn.tag = x;
            [btn setFrame:CGRectMake(3*(kButtonSizeWidth + kIntervalWidth) + kIntervalWidth, kIntervalHeight, kConfirmButtonSizeWidth, kConfirmButtonSizeHeight)];
            [btn setTitle:@"确 定" forState:UIControlStateNormal];
            
        } else if(x == 13){
            nomalStr = @"delete_nomal";
            selectStr = @"delete_select";
            btn.tag = x;
            [btn setFrame:CGRectMake(3*(kButtonSizeWidth + kIntervalWidth) + kIntervalWidth, kConfirmButtonSizeHeight + 2*kIntervalHeight, kConfirmButtonSizeWidth, kConfirmButtonSizeHeight)];
            [btn setTitle:@"删 除" forState:UIControlStateNormal];
        
        }
        else
        {
            // btn.tag = x;
        }
        [btn setBackgroundImage:[UIImage imageNamed:nomalStr] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:selectStr] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:selectStr] forState:UIControlStateHighlighted];
        if(x == 12){
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        btn.adjustsImageWhenHighlighted = TRUE;
        [btn addTarget:self action:@selector(numbleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)numbleButtonClicked:(id)sender
{
    UIButton* btn = (UIButton*)sender;
    
    NSInteger number = btn.tag;
    
    
    // no delegate, print log info
    if (nil == _delegate) 
    {
        NSLog(@"button tag [%d]",number);
        return;
    }
    
    if (number <= 9 && number >= 0) 
    {
        [_delegate numberKeyBoardInput:number];
        return;
    }
    
    if (10 == number) 
    {
        [_delegate numberKeyBoardAbout];
        return;
    }
    
    if (11 == number) 
    {
        [_delegate numberKeyBoardClear];
        return;
    }
    
    if(12 == number)
    {
        [_delegate numberKeyBoardConfim];
        return;
    }
    if(13 == number)
    {
        [_delegate numberKeyBoardDelete];
        return;
    }
}

@end
