//
//  NoviceGuideViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface NoviceGuideViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UIImageView *left;
@property (nonatomic,strong) UIImageView *right;

@property (retain, nonatomic) IBOutlet UIScrollView *pageScroll;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)gotoMainView:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *gotoMainViewBtn;

@end