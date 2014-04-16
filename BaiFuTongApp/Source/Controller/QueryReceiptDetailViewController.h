//
//  QueryReceiptDetailViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface QueryReceiptDetailViewController : AbstractViewController

@property (nonatomic, strong) NSDictionary *paramDic;

- (id)initWithParams:(NSDictionary *) dic;

@end
