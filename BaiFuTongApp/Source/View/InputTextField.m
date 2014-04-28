//
//  InputTextField.m
//  POS2iPhone
//
//  Created by jia liao on 1/8/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "InputTextField.h"
#define STRETCH 5

@implementation InputTextField

@synthesize leftLabel = _leftLabel;
@synthesize contentTF = _contentTF;

- (id)initWithFrame:(CGRect)frame left:(NSString *)leftText prompt:(NSString *)prompStr keyBoardType:(int) keyBoardType imageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[self stretchImage:[UIImage imageNamed:imageName]]];
        [bgImageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:bgImageView];
        
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 65, frame.size.height*3/4)];
        [self.leftLabel setText:leftText];
        [self.leftLabel setTextColor:[UIColor blackColor]];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        [self.leftLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:self.leftLabel];
        //区分一下系统版本
        if (DeviceVersion >= 7) {
            self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 4, frame.size.width*2/3, frame.size.height*4/5)];
        }else{
            self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(80, 13, frame.size.width*2/3, frame.size.height*4/5)];
        }

        [self.contentTF setTextColor:[UIColor blackColor]];
        [self.contentTF setBackgroundColor:[UIColor clearColor]];
        [self.contentTF setKeyboardType:keyBoardType];
        [self.contentTF setFont:[UIFont boldSystemFontOfSize:14]];
        [self.contentTF setPlaceholder:prompStr];
        //self.contentTF.delegate = self;
        [self addSubview:self.contentTF];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame left:(NSString *)leftText prompt:(NSString *)prompStr keyBoardType:(int) keyBoardType
{
    if (self = [self initWithFrame:frame left:leftText prompt:prompStr keyBoardType:keyBoardType imageName:@"textInput.png"]) {
        
    }
    
    return self;
}

-(NSString *)getContent
{
    return self.contentTF.text;
}

-(void)setLeftWidth:(float)width
{
    if (width > 70) {
        [self.leftLabel setFrame:CGRectMake(10, 5, width, self.frame.size.height*3/4)];
        [self.contentTF setFrame:CGRectMake(10+width, 12, self.frame.size.width*2/3, self.frame.size.height*4/5)];
    }
    
}

-(UIImage *)stretchImage:(UIImage *) image
{
    UIImage *returnImage = nil;
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion == 5.0) {
        returnImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15, STRETCH, STRETCH, STRETCH)];
    }else if(systemVersion >= 6.0){
        returnImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, STRETCH, STRETCH, STRETCH)resizingMode:UIImageResizingModeTile];
    }
    return returnImage;
}

//- (void)keyboardWillShow:(NSNotification *)noti
//{
//    //键盘输入的界面调整
//    //键盘的高度
//    NSLog(@"keyboardWillShow");
//    float height = 216.0;
//    CGRect frame = self.frame;
//    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
//    [UIView beginAnimations:@"Curl"context:nil];//动画开始
//    [UIView setAnimationDuration:0.30];
//    [UIView setAnimationDelegate:self];
//    [self setFrame:frame];
//    [UIView commitAnimations];
//}
@end
