//
//  BFTMenuViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFTRevealViewController;

@interface BFTMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
@private
	BFTRevealViewController *_sidebarVC;
	UITableView *_menuTableView;
	NSArray *_controllers;
	NSArray *_cellInfos;
}

- (id)initWithSidebarViewController:(BFTRevealViewController *)sidebarVC
					withControllers:(NSArray *)controllers
					  withCellInfos:(NSArray *)cellInfos;

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
					animated:(BOOL)animated
			  scrollPosition:(UITableViewScrollPosition)scrollPosition;

@end
