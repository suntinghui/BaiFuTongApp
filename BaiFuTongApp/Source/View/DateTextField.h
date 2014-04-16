//
//  DateTextField.h
//  POS2iPhone
//
//  Created by jia liao on 1/13/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTextField : UIView<UIActionSheetDelegate, UIPickerViewDelegate>

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UIActionSheet *actionSheet;
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)UIDatePicker *datePicker;

- (id)initWithFrame:(CGRect)frame bgImage:(NSString *) imageName leftText:(NSString *) leftText;
-(NSString *)value;

@end
