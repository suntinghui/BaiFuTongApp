//
//  BFTRevealViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSTimeInterval kGHRevealSidebarDefaultAnimationDuration;
extern const CGFloat kGHRevealSidebarWidth;

@interface BFTRevealViewController : UIViewController
{
@private
	UIView *_sidebarView;
	UIView *_contentView;
	UITapGestureRecognizer *_tapRecog;
}

@property (nonatomic, readonly, getter = isSidebarShowing) BOOL sidebarShowing;
@property (nonatomic, readonly, getter = isSearching) BOOL searching;
@property (strong, nonatomic) UIViewController *sidebarViewController;
@property (strong, nonatomic) UIViewController *contentViewController;

- (void)dragContentView:(UIPanGestureRecognizer *)panGesture;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration;
- (void)toggleSidebar:(BOOL)show duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;
- (void)toggleSearch:(BOOL)showSearch withSearchView:(UIView *)searchView duration:(NSTimeInterval)duration;
- (void)toggleSearch:(BOOL)showSearch withSearchView:(UIView *)searchView duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

@end
