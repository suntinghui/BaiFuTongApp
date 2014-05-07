//
//  BFTRootViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-26.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

typedef void (^RevealBlock)();

@interface BFTRootViewController : AbstractViewController {
@private
	RevealBlock _revealBlock;
}

@property (strong, nonatomic) NSArray  *parentCatalogArray;

- (void)initWithButton;
- (void)doAction:(UIButton *) button;

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;

@end
