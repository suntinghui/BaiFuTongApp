//
//  SignViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-29.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandSignPanel.h"
#import "AbstractViewController.h"
#import "InputTextField.h"

@interface SignViewController :UIViewController <UITextFieldDelegate>
{
	CGPoint myBeganpoint;
	CGPoint myMovepoint;
}

@property (nonatomic, strong) IBOutlet UILabel *amountLabel;
@property (nonatomic, strong) HandSignPanel *signPanel;
@property (nonatomic, weak )id <AbstractViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *phoneNumTF;


-(IBAction)myPalttealllineclear;
-(IBAction)close:(id)sender;
//-(IBAction)backBUttonAction:(id)sender;
@end
