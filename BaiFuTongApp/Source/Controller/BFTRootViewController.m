//
//  BFTRootViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "BFTRootViewController.h"
#import "CatalogModel.h"
#import "SecondMenuViewController.h"
#import "ParseXMLUtil.h"

#pragma mark -
#pragma mark Private Interface
@interface BFTRootViewController ()
- (void)pushViewController;
@end


#pragma mark -
#pragma mark Implementation
@implementation BFTRootViewController

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
	}
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName, [UIColor colorWithWhite:0.0 alpha:0.0], NSBackgroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.navigationItem.title = @"主菜单";
    self.navigationItem.hidesBackButton = YES;
	self.parentCatalogArray = [ParseXMLUtil parseCatalogXML];
    [self initWithButton];
}

#pragma mark - * initWithButton
- (void)initWithButton
{
    for (int i = 0; i < [self.parentCatalogArray count]; i++) {
        
        CatalogModel *catalog = (CatalogModel *)[self.parentCatalogArray objectAtIndex:i];
        if (catalog.parentId != 0)
            return;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i > 2) {
            [button setFrame:CGRectMake(20 + (i-3)*103, 165+ios7_y, 72, 72)];
        }else {
            [button setFrame:CGRectMake(20 + i*103, 30+ios7_y, 72, 72)];
        }
        
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"BFTMainIcon_normal_0%d.png",catalog.iconId]] forState:UIControlStateNormal];
        button.tag = catalog.catalogId;
        [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        if (i>2) {
            [label setFrame:CGRectMake(25+ (i-3)*103,240+ios7_y, 70, 20)];
        }
        else {
            [label setFrame:CGRectMake(25+ i*103, 107+ios7_y, 70, 20)];
        }
        label.text = catalog.title;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        [self.view addSubview:label];
    }
}

- (void)doAction:(UIButton *) button
{
    CatalogModel *catalog = (CatalogModel *)[self.parentCatalogArray objectAtIndex:(button.tag -1)];
    SecondMenuViewController *vc = [[SecondMenuViewController alloc] initWithTitle:catalog.title withRevealBlock:nil catalogId:button.tag];
	[self.navigationController pushViewController:vc animated:YES];
}

@end
