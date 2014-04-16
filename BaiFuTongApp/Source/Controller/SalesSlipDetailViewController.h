//
//  SalesSlipDetailViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-29.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface SalesSlipDetailViewController : AbstractViewController<AbstractViewControllerDelegate>

@property (nonatomic, strong) UIScrollView      *scrollView;

@property (nonatomic, strong) UIButton          *gotoSignButton;
@property (nonatomic, strong) UIButton          *confirmButton;
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) UIImageView       *bgImageView;


@end
