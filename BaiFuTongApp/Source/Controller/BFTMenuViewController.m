//
//  BFTMenuViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "BFTMenuViewController.h"
#import "BFTMenuCell.h"
#import "BFTRevealViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BFTMenuViewController ()

@end

#pragma mark -
#pragma mark Implementation
@implementation BFTMenuViewController

#pragma mark Memory Management
- (id)initWithSidebarViewController:(BFTRevealViewController *)sidebarVC
					withControllers:(NSArray *)controllers
					  withCellInfos:(NSArray *)cellInfos {
	if (self = [super initWithNibName:nil bundle:nil]) {
		_sidebarVC = sidebarVC;
		_controllers = controllers;
		_cellInfos = cellInfos;
		
		_sidebarVC.sidebarViewController = self;
		_sidebarVC.contentViewController = _controllers[0][0];
	}
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.frame = CGRectMake(0.0f, 0.0f, kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds));
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	_menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds))
												  style:UITableViewStylePlain];
	_menuTableView.delegate = self;
	_menuTableView.dataSource = self;
	_menuTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	_menuTableView.backgroundColor = [UIColor clearColor];
	_menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_menuTableView];
}

- (void)viewWillAppear:(BOOL)animated {
	self.view.frame = CGRectMake(0.0f, 0.0f,kGHRevealSidebarWidth, CGRectGetHeight(self.view.bounds));
	[self selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
	return (orientation == UIInterfaceOrientationPortraitUpsideDown)
    ? (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    : YES;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)_cellInfos[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GHMenuCell";
    BFTMenuCell *cell = (BFTMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BFTMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	NSDictionary *info = _cellInfos[indexPath.section][indexPath.row];
	cell.textLabel.text = info[kSidebarCellTextKey];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row != 0)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 21, 21)];
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"BFTLeftMenuIcon_normal_0%ld",(long)indexPath.row]]];
        [image setHighlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"BFTLeftMenuIcon_highlight_0%ld",(long)indexPath.row]]];
        [cell.contentView addSubview:image];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row == 0) {
        //_sidebarVC.contentViewController = _controllers[0][0];
        [(UINavigationController *)_sidebarVC.contentViewController popToRootViewControllerAnimated:YES];
        [_sidebarVC toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
    }
    else{
        [(UINavigationController *)_sidebarVC.contentViewController popToRootViewControllerAnimated:NO];
        [(UINavigationController *)_sidebarVC.contentViewController pushViewController:_controllers[indexPath.section][indexPath.row] animated:YES];
//        _sidebarVC.contentViewController = _controllers[indexPath.section][indexPath.row];
        [_sidebarVC toggleSidebar:NO duration:kGHRevealSidebarDefaultAnimationDuration];
    }
}

#pragma mark Public Methods
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
	[_menuTableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
//	if (scrollPosition == UITableViewScrollPositionNone) {
//		[_menuTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
//	}
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        //_sidebarVC.contentViewController = _controllers[0][0];
//        [(UINavigationController *)_sidebarVC.contentViewController popToRootViewControllerAnimated:NO];
//    }
//    else{
//        [(UINavigationController *)_sidebarVC.contentViewController popToRootViewControllerAnimated:NO];
//        [(UINavigationController *)_sidebarVC.contentViewController pushViewController:_controllers[indexPath.section][indexPath.row] animated:YES];
////        _sidebarVC.contentViewController = _controllers[indexPath.section][indexPath.row];
//    }
}

@end

