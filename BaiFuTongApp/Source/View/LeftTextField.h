//
//  LeftTextField.h
//  POS2iPhone
//
//  Created by jia liao on 1/24/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"

@interface LeftTextField : UIView

@property(nonatomic, strong)UITextField *contentTF;

- (id)initWithFrame:(CGRect)frame isLong:(BOOL)isLong;

@end
