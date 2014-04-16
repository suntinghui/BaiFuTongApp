//
//  SuggestionBackViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

#import"AbstractViewController.h"
#import "SKPSMTPMessage.h"
#import "InputTextField.h"
@interface SuggestionBackViewController : AbstractViewController<SKPSMTPMessageDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property(nonatomic, strong)UITextView *inputTF;
@property(nonatomic, strong)InputTextField *yourMailAdressTF;
@property(nonatomic, strong)UILabel *countLabel;

@end
