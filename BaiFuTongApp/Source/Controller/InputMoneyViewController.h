//
//  InputMoneyViewController.h
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"

@interface InputMoneyViewController : AbstractViewController
{
    
}

@property(nonatomic, strong)NSMutableString *moneyStr;
@property(nonatomic, strong)IBOutlet UILabel *displayLabel;
@property(nonatomic, strong)IBOutlet UIView *bgView;
@property(nonatomic, strong)IBOutlet UIView *dateView;
@property(nonatomic, assign)int numCount;
@property(nonatomic, strong)IBOutlet UIButton *clearButton;
@property(nonatomic, assign)double fifteenDouble;
@property(nonatomic, assign)double des;
-(IBAction)buttonAction:(id)sender;
-(void)pressNumericButton:(int) tag;
-(NSString*)formatString:(NSString*)moneyStr tag:(int)tag;
-(void)displayMoneyStr:(NSString*)moneyStr;
-(UIImageView*)getDigitMoneyImage:(int)index countIndex:(int)countIndex;
-(UIImageView*)getDateTimeImage:(int)index  countIndex:(int)countIndex;

@end