//
//  ResultViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

#define LONGINVC 0
#define CARALOGVC 1

@interface ResultViewController : AbstractViewController

@property(nonatomic, assign)BOOL isSuccess;
@property(nonatomic, strong)NSString *navTitle;
@property(nonatomic, strong)NSString *resultMsg;
@property(nonatomic, strong)NSString *messageExplain;
@property(nonatomic, assign)NSInteger popIndex;

- (id)initWithTitle:(NSString*)navTitle resultFlag:(BOOL)isSuccess resultMsg:(NSString*)resultMsg detailMsg:(NSString*)messageExplain popIndex:(NSInteger) popIndex;

- (id) initwithSuccessMsg:(NSString *) msg;

- (id) initWithFailureMsg:(NSString *) msg;

@end

