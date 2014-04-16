//
//  InputTextField.h
//  POS2iPhone
//
//  Created by jia liao on 1/8/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTextField : UIView<UITextFieldDelegate>
{
    
}

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UITextField *contentTF;

-(NSString *)getContent;

- (id)initWithFrame:(CGRect)frame left:(NSString *)leftText prompt:(NSString *)prompStr keyBoardType:(int) keyBoardType;
- (id)initWithFrame:(CGRect)frame left:(NSString *)leftText prompt:(NSString *)prompStr keyBoardType:(int) keyBoardType imageName:(NSString *)imageName;
-(void)setLeftWidth:(float)width;

@end
