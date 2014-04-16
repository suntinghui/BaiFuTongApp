//
//  PasswordTextField.h
//  redarrow
//
//  Created by jia liao on 12/16/12.
//  Copyright (c) 2012 GP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomKeyBoardView.h"
@interface PasswordTextField : UIView<UITextFieldDelegate, RandomKeyBoardDelegate>
{
    UITextField                 *pwdTF;
    RandomKeyBoardView          *randomKeyBoardView;
    NSString                    *rsaValue;
}

@property(nonatomic, strong) UITextField                *pwdTF;
@property(nonatomic, strong) RandomKeyBoardView         *randomKeyBoardView;
@property(nonatomic, strong, readonly)NSString          *rsaValue;

- (void) clearInput;

@end
