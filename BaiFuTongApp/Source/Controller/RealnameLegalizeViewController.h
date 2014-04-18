//
//  RealnameLegalizeViewController.h
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-16.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "AbstractViewController.h"
#import "InputTextField.h"
#import "LeftTextField.h"

@interface RealnameLegalizeViewController : AbstractViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate, UIActionSheetDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    NSInteger           areaFlag;
    NSInteger           bankFlag;
    NSInteger           cityFlag;
    UIActionSheet       *myActionSheet;
    //图片2进制路径
    NSString* filePath;
    
    NSDictionary        *_receiveDic;
}

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView  *IdCardFront;
@property (nonatomic, strong) UIImageView  *IdCardBack;
@property (nonatomic, strong) UIImageView  *bankPic;

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
@property (nonatomic, strong) InputTextField *bkCardNoTF;
@property(nonatomic, strong)InputTextField *merchantTF;
@property(nonatomic, strong) LeftTextField    *securityCodeTF;
@property(nonatomic, strong) UIButton        *securityCodeButton;

- (void)selectButton:(id)sender;

@end
