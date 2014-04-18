//
//  TradeDetailTableViewController.h
//  YLTiPhone
//
//  Created by xushuang on 13-12-11.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "TransferDetailModel.h"

@interface TradeDetailTableViewController : AbstractViewController

@property (strong, nonatomic) TransferDetailModel *detailModel;
@property (nonatomic, strong) UIScrollView      *scrollView;

@property (nonatomic, strong) UIButton          *confirmButton;
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) UIImageView       *bgImageView;

@end
