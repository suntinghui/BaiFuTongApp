//
//  AnnouncementDetailViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@class AnnouncementModel;

@interface AnnouncementDetailViewController : AbstractViewController<UIAlertViewDelegate>

@property(nonatomic, strong)AnnouncementModel *model;
-(id)initWithModel:(AnnouncementModel*)model;
@end

