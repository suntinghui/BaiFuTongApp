//
//  ConfirmCancelResultViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

#define LONGINVC 0
#define CARALOGVC 1

@interface ConfirmCancelResultViewController : AbstractViewController<UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSString      *resultMsg;

- (id)initWithResultMessage:(NSString*)resMsg;

- (void) repeatPrint:(NSString *) errReason;

@end
