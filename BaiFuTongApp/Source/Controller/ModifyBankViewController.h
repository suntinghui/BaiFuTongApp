//
//  ModifyBankViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "PwdLeftTextField.h"
#import "InputTextField.h"
#import "LeftTextField.h"

@interface ModifyBankViewController : AbstractViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate, UIActionSheetDelegate>
{
    NSInteger           areaFlag;
    NSInteger           bankFlag;
    NSInteger           cityFlag;
    
    NSDictionary        *_receiveDic;
}
@property (nonatomic, strong) UIScrollView  *scrollView;

@property(nonatomic, strong)InputTextField *nameTF;
@property(nonatomic, strong)InputTextField *pIdNoTF;
@property(nonatomic, strong)InputTextField *oldBkCardNoTF;
@property(nonatomic, strong)InputTextField *bkCardNoTF;
@property(nonatomic, strong) LeftTextField    *securityCodeTF;
@property(nonatomic, strong) UIButton        *securityCodeButton;

@property (nonatomic, strong) UIButton      *selectBankButton;
@property (nonatomic, strong) UIButton      *selectAreaButton;
@property (nonatomic, strong) UIButton      *selectCityButton;
@property (nonatomic, strong) UIButton      *banksBranchButton;

@property (nonatomic, strong) NSArray           *bankArray;
@property (nonatomic, strong) NSArray           *areaArray;
@property (nonatomic, strong) NSArray           *cityArray;
@property (nonatomic, strong) NSMutableArray           *selectCityArray;

@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) UIPickerView  *picker;

@property (nonatomic, strong) NSString  *respBankCode;
@property (nonatomic, strong) NSString  *respBankName;

@property (nonatomic, strong) NSDictionary      *receiveDic;

- (void)selectButton:(id)sender;

@end
