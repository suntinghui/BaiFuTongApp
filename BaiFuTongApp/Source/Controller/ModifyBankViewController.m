//
//  ModifyBankViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-17.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "ModifyBankViewController.h"
#import "MyPickController.h"
//#import "SearchBankViewController.h"
#import "ParseXMLUtil.h"
#import "BankModel.h"
#import "UITextField+HideKeyBoard.h"
#import "AreaModel.h"
#import "CityModel.h"

@interface ModifyBankViewController ()

@end

@implementation ModifyBankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改银行卡";
    
    bankFlag = 0;
    areaFlag = 0;
    cityFlag = 0;
    
    _bankArray = [[NSArray alloc] initWithArray:[ParseXMLUtil parseBankXML]];
    _areaArray = [[NSArray alloc] initWithArray:[ParseXMLUtil parseAreaXML]];
    _cityArray = [[NSArray alloc] initWithArray:[ParseXMLUtil parseCityXML]];
    _selectCityArray = [[NSMutableArray alloc] init];
    
    for (CityModel *model in _cityArray) {
        if ([model.parentCode isEqualToString:[((AreaModel *)[self.areaArray objectAtIndex:areaFlag]) code]])
        {
            [_selectCityArray  addObject:model];
        }
    }
    
    
    self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height)];
    [_scrollView setContentSize:CGSizeMake(320, 750+ios7_h)];
    _scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_scrollView];
    
    self.nameTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 45, 298, 44) left:@"姓名" prompt:@"请输入您的姓名" keyBoardType:UIKeyboardTypeNamePhonePad];
    self.nameTF.contentTF.delegate = self;
    [self.nameTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.nameTF];
    
    self.pIdNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 100, 298, 44) left:@"身份证号" prompt:@"请输入您的身份证号" keyBoardType:UIKeyboardTypeASCIICapable];
    self.pIdNoTF.contentTF.delegate = self;
    [self.pIdNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.pIdNoTF];
    
    UILabel * dividingLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 157, 300, 1)];
    dividingLine.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:dividingLine];
    
    self.oldBkCardNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 175, 298, 44) left:@"原银行卡" prompt:@"请输入您原来的银行卡号" keyBoardType:UIKeyboardTypeNumberPad];
    self.oldBkCardNoTF.contentTF.delegate = self;
    [self.oldBkCardNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.oldBkCardNoTF];
    
    self.bkCardNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 230, 298, 44) left:@"银行卡号" prompt:@"请输入您的银行卡号" keyBoardType:UIKeyboardTypeNumberPad];
    self.bkCardNoTF.contentTF.delegate = self;
    [self.bkCardNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.bkCardNoTF];
    
    //银行信息
    UILabel *bankInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 286, 300, 35)];
    bankInfoLabel.backgroundColor = [UIColor clearColor];
    bankInfoLabel.text = @"银行卡开户行";
    bankInfoLabel.font = [UIFont systemFontOfSize:17.0f];
    [_scrollView addSubview:bankInfoLabel];
    
    //选择银行下拉框
    _selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBankButton setFrame:CGRectMake(10, 320, 300, 45)];
    [_selectBankButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    [_selectBankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBankButton.tag = 90001;
    [_selectBankButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBankButton setTitle:[((BankModel *)[self.bankArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectBankButton];
    
    //省份下拉框
    _selectAreaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectAreaButton setFrame:CGRectMake(10, 375, 300, 45)];
    [_selectAreaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectAreaButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    _selectAreaButton.tag = 90002;
    [_selectAreaButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectAreaButton setTitle:[((AreaModel *)[self.areaArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectAreaButton];
    
    //城市下拉框
    _selectCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectCityButton setFrame:CGRectMake(10, 430, 300, 45)];
    [_selectCityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectCityButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    _selectCityButton.tag = 90003;
    [_selectCityButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectCityButton setTitle:[((CityModel *)[self.selectCityArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectCityButton];
    
    
    _banksBranchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_banksBranchButton setFrame:CGRectMake(10, 485, 297, 42)];
    [_banksBranchButton setTitle:@"请选择支行" forState:UIControlStateNormal];
    [_banksBranchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _banksBranchButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_banksBranchButton addTarget:self action:@selector(selectBankButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_normal.png"] forState:UIControlStateNormal];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_highlight.png"] forState:UIControlStateSelected];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_highlight.png"] forState:UIControlStateHighlighted];
    [_scrollView addSubview:_banksBranchButton];
    
    UILabel * dividingLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 543, 300, 1)];
    dividingLine1.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:dividingLine1];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 560, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [_scrollView addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 560, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [_scrollView addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 560, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [_scrollView addSubview:_securityCodeButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 625, 297, 42)];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:confirmButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)securityCodeButtonAction
{
    //短信验证码按键处理
}

- (void)selectButton:(id)sender
{
    //弹出pickerview
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, 320, 190)];
    self.picker.showsSelectionIndicator=YES;
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 90001:
            self.picker.tag = 10000;
            break;
        case 90002:
            self.picker.tag = 20000;
            break;
        case 90003:
            self.picker.tag = 30000;
            break;
        default:
            break;
    }
    
    
    [self.actionSheet addSubview:self.picker];
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,40)];
    tools.barStyle = UIBarStyleBlack;
    tools.delegate = self;
    //    tools.barTintColor = [UIColor clearColor];
    [self.actionSheet addSubview:tools];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinDoneClicked:)];
    doneButton.imageInsets=UIEdgeInsetsMake(200, 5, 50, 30);
    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *array = [[NSArray alloc]initWithObjects:flexSpace,flexSpace,doneButton,nil];
    [tools setItems:array];
    
    [self.actionSheet showFromRect:CGRectMake(0,480, 320,200) inView:self.view animated:YES];
    [self.actionSheet setBounds:CGRectMake(0,0, 320, 411)];
}

#pragma mark -btnActinDoneClicked
-(IBAction)btnActinDoneClicked:(id)sender
{
    [self.actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}

//查找支行
- (void)selectBankButtonAction
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PHONENUM"] forKey:@"PHONENUM"];
    [dic setObject:[((AreaModel *)[self.areaArray objectAtIndex:areaFlag]) code] forKey:@"provinceid"];
    [dic setObject:[((CityModel *)[self.selectCityArray objectAtIndex:cityFlag]) code] forKey:@"cityid"];
    [dic setObject:[((BankModel *)[self.bankArray objectAtIndex:bankFlag]) code] forKey:@"bankid"];//银行卡号
    [dic setObject:@"1" forKey:@"page_current"];
    [dic setObject:@"20" forKey:@"page_size"];
    
    //    SearchBankViewController *searchBank = [[SearchBankViewController alloc] initWithNibName:nil bundle:nil bankDic:dic];
    //    searchBank.modifyAccountVC = self;
    //    [self.navigationController pushViewController:searchBank animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([_respBankName length] == 0) {
        _respBankName = @"请选择支行";
    }
    [self.banksBranchButton setTitle:_respBankName forState:UIControlStateNormal];
}

-(BOOL)checkValue
{
    if([_respBankName isEqualToString:@"请选择支行"]){
        [ApplicationDelegate showErrorPrompt:@"请选择支行"];
        return NO;
    }
    return YES;
}

//设置成功，返回上级界面
- (void)confirmButtonAction
{
    //    if ([self checkValue]) {
    //        //检查界面输入情况
    //        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //        [dic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__PHONENUM"] forKey:@"PHONENUM"];
    ////        [dic setObject:[UserDefaults objectForKey:MERCHANT_NAME] forKey:@"merchant_name"];
    ////        [dic setObject:self.accountInfoTF.contentTF.text forKey:@"mastername"];
    ////        [dic setObject:self.receiveAcctNumTF.contentTF.text forKey:@"bankaccount"];//银行卡号
    //        [dic setObject:[((BankModel *)[self.bankArray objectAtIndex:bankFlag]) name] forKey:@"banks"];
    //        [dic setObject:[((BankModel *)[self.bankArray objectAtIndex:bankFlag]) code] forKey:@"bankno"];
    //        [dic setObject:[((AreaModel *)[self.areaArray objectAtIndex:areaFlag]) code] forKey:@"area"];
    //        [dic setObject:[((CityModel *)[self.selectCityArray objectAtIndex:cityFlag]) code] forKey:@"city"];
    //        [dic setObject:self.respBankCode forKey:@"addr"];
    //        //修改提款银行账号
    //        //[[Transfer sharedTransfer] startTransfer:@"089009" fskCmd:nil paramDic:dic];
    //    }
    [self popToCatalogViewController];
}

#pragma mark -
#pragma mark * UIPickerViewDelegate
//返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
// 返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 10000){
		return _bankArray == nil ? 0 : _bankArray.count;
	}else if (pickerView.tag == 20000){
		return _areaArray == nil ? 0 : _areaArray.count;
	}else if (pickerView.tag == 30000){
		return _selectCityArray == nil ? 0 : _selectCityArray.count;
	}
	return 0;
}
// 设置当前行的内容，若果行没有显示则自动释放
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView.tag == 10000){
		if (_bankArray != nil && _bankArray.count > row){
			return [((BankModel *)[self.bankArray objectAtIndex:row]) name];
		}
	}else if (pickerView.tag == 20000){
		if (_areaArray != nil && _areaArray.count > row){
			return [((AreaModel *)[self.areaArray objectAtIndex:row]) name];
		}
	}else if (pickerView.tag == 30000){
		if (_selectCityArray != nil && _selectCityArray.count > row){
			return [((CityModel *)[self.selectCityArray objectAtIndex:row]) name];
		}
	}
	return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 10000) {
		if (_bankArray != nil && _bankArray.count > row) {
            [self.selectBankButton setTitle:[((BankModel *)[self.bankArray objectAtIndex:row]) name] forState:UIControlStateNormal];
            bankFlag = row;
		}
	}else if (pickerView.tag == 20000) {
        if (_areaArray != nil && _areaArray.count > row) {
            [self.selectAreaButton setTitle:[((AreaModel *)[self.areaArray objectAtIndex:row]) name] forState:UIControlStateNormal];
            areaFlag = row;
            [_selectCityArray removeAllObjects];
            for (CityModel *model in _cityArray) {
                if ([model.parentCode isEqualToString:[((AreaModel *)[self.areaArray objectAtIndex:areaFlag]) code]])
                {
                    [_selectCityArray  addObject:model];
                }
            }
		}
    }else if (pickerView.tag == 30000) {
        if (_selectCityArray != nil && _selectCityArray.count > row) {
            [self.selectCityButton setTitle:[((CityModel *)[self.selectCityArray objectAtIndex:row]) name] forState:UIControlStateNormal];
            cityFlag = row;
		}
    }
}

//限制textfield的输入字数和输入类型
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:PID]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    if (textField == self.pIdNoTF.contentTF)
    {
        if (range.location >= 18) {
            return  NO;
        }
        else {
            return canChange;
        }
        
    }
    else if (textField == self.bkCardNoTF.contentTF && range.location >= 22)
    {
        return NO;
    }
    else if (textField == self.oldBkCardNoTF.contentTF && range.location >= 22)
    {
        return NO;
    }
    else if (self.securityCodeTF.contentTF == textField && range.location >=6)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


@end
