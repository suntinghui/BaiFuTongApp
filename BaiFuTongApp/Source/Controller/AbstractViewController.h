//
//  AbstractViewController.h
//  POS2iPhone
//
//  Created by jia liao on 1/6/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AbstractViewControllerDelegate <NSObject>

@required
- (void) abstractViewControllerDone:(id) obj;

@end

@interface AbstractViewController : UIViewController <UITextFieldDelegate>

-(IBAction)textFiledReturnEditing:(id)sender;
-(UIImage *)stretchImage:(UIImage *) image;
-(void)popToCatalogViewController;
-(void)popToLoginViewController;
-(void)setLabelStyle:(UILabel*)label;


-(IBAction)backButtonAction:(id)sender;
@end
