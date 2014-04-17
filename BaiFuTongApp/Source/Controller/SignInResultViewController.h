//
//  SignInResultViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface SignInResultViewController : AbstractViewController

@property (weak, nonatomic) IBOutlet UIImageView *signInImage;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;

@property (nonatomic,assign) BOOL isSuccess;
//-(id)init;

@end
