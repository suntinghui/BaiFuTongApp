//
//  SecondMenuViewController.h
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"

typedef void (^RevealBlock)();

@interface SecondMenuViewController : AbstractViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView             *_panelTableView;
    NSInteger               _catalogId;
    NSArray                 *_catalogArray;
    NSMutableArray          *_currentCatalogArray;
    
@private
	RevealBlock _revealBlock;
}
@property (nonatomic, strong) UITableView           *panelTableView;
@property (nonatomic, strong) NSArray               *catalogArray;
@property (nonatomic, strong) NSMutableArray        *currentCatalogArray;

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock
          catalogId:(NSInteger)catalogId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil catalogId:(NSInteger)catalogId;

@end
