//
//  RealnameLegalizeViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-16.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "RealnameLegalizeViewController.h"
#import "MyPickController.h"
//#import "SearchBankViewController.h"
#import "ParseXMLUtil.h"
#import "BankModel.h"
#import "UITextField+HideKeyBoard.h"
#import "AreaModel.h"
#import "CityModel.h"
#import "SetPasswordViewController.h"

@interface RealnameLegalizeViewController ()
@end

@implementation RealnameLegalizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"实名认证";
    
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
    [_scrollView setContentSize:CGSizeMake(320, 1000+ios7_h)];
    _scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_scrollView];
    
    UILabel *IdCardFrontLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 140, 35)];
    IdCardFrontLabel.backgroundColor = [UIColor clearColor];
    IdCardFrontLabel.text = @"身份证正面：";
    IdCardFrontLabel.font = [UIFont systemFontOfSize:17.0f];
    [_scrollView addSubview:IdCardFrontLabel];
    UIImage *backima = [UIImage imageNamed:@"img_card_head_portrait.png"];
    
    self.IdCardFront = [[UIImageView alloc] initWithFrame:CGRectMake(180, 45, 100, 100)];
    _IdCardFront.image = backima;
    _IdCardFront.userInteractionEnabled = YES;
    _IdCardFront.tag = 400;
    UITapGestureRecognizer *singleTapFront = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageFront)];
    [_IdCardFront addGestureRecognizer:singleTapFront];
    [_scrollView addSubview:_IdCardFront];
    
    UILabel *IdCardBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 165, 140, 35)];
    IdCardBackLabel.backgroundColor = [UIColor clearColor];
    IdCardBackLabel.text = @"身份证照背面：";
    IdCardBackLabel.font = [UIFont systemFontOfSize:17.0f];
    [_scrollView addSubview:IdCardBackLabel];
    
    self.IdCardBack = [[UIImageView alloc] initWithFrame:CGRectMake(180, 165, 100, 100)];
    _IdCardBack.image = backima;
    _IdCardBack.userInteractionEnabled = YES;
    _IdCardBack.tag = 401;
    UITapGestureRecognizer *singleTapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageBack)];
    [_IdCardBack addGestureRecognizer:singleTapBack];
    [_scrollView addSubview:_IdCardBack];
    
    UILabel * dividingLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 279, 300, 1)];
    dividingLine.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:dividingLine];
    
    //银行信息
    UILabel *bankInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 35)];
    bankInfoLabel.backgroundColor = [UIColor clearColor];
    bankInfoLabel.text = @"银行卡开户行";
    bankInfoLabel.font = [UIFont systemFontOfSize:17.0f];
    [_scrollView addSubview:bankInfoLabel];
    
    //选择银行下拉框
    _selectBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBankButton setFrame:CGRectMake(10, 335, 300, 45)];
    [_selectBankButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    [_selectBankButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBankButton.tag = 90001;
    [_selectBankButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBankButton setTitle:[((BankModel *)[self.bankArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectBankButton];
    
    //省份下拉框
    _selectAreaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectAreaButton setFrame:CGRectMake(10, 390, 300, 45)];
    [_selectAreaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectAreaButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    _selectAreaButton.tag = 90002;
    [_selectAreaButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectAreaButton setTitle:[((AreaModel *)[self.areaArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectAreaButton];
    
    //城市下拉框
    _selectCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectCityButton setFrame:CGRectMake(10, 445, 300, 45)];
    [_selectCityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectCityButton setBackgroundImage:[UIImage imageNamed:@"selectField_normal.png"] forState:UIControlStateNormal];
    _selectCityButton.tag = 90003;
    [_selectCityButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectCityButton setTitle:[((CityModel *)[self.selectCityArray objectAtIndex:0]) name] forState:UIControlStateNormal];
    [_scrollView addSubview:_selectCityButton];
    
    
    _banksBranchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_banksBranchButton setFrame:CGRectMake(10, 500, 297, 42)];
    [_banksBranchButton setTitle:@"请选择支行" forState:UIControlStateNormal];
    [_banksBranchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _banksBranchButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_banksBranchButton addTarget:self action:@selector(selectBankButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_normal.png"] forState:UIControlStateNormal];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_highlight.png"] forState:UIControlStateSelected];
    [_banksBranchButton setBackgroundImage:[UIImage imageNamed:@"selectBank_highlight.png"] forState:UIControlStateHighlighted];
    [_scrollView addSubview:_banksBranchButton];
    
    self.bkCardNoTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 550, 298, 44) left:@"银行卡号" prompt:@"请输入您的银行卡号" keyBoardType:UIKeyboardTypePhonePad];
    self.bkCardNoTF.contentTF.delegate = self;
    [self.bkCardNoTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.bkCardNoTF];
    
    UILabel *bankPicLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 605, 140, 35)];
    bankPicLabel.backgroundColor = [UIColor clearColor];
    bankPicLabel.text = @"银行卡图片";
    bankPicLabel.font = [UIFont systemFontOfSize:17.0f];
    [_scrollView addSubview:bankPicLabel];
    
    self.bankPic = [[UIImageView alloc] initWithFrame:CGRectMake(180, 605, 100, 100)];
    _bankPic.image = backima;
    _bankPic.userInteractionEnabled = YES;
    _bankPic.tag = 402;
    UITapGestureRecognizer *singleTapBank = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImageBank)];
    [_bankPic addGestureRecognizer:singleTapBank];
    [_scrollView addSubview:_bankPic];
    
    UILabel * dividingLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 724, 300, 1)];
    dividingLine1.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:dividingLine1];

    
    self.merchantTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 745, 298, 44) left:@"商户名" prompt:@"请输入您的商户名" keyBoardType:UIKeyboardTypeDefault];
    self.merchantTF.contentTF.delegate = self;
    [self.merchantTF.contentTF hideKeyBoard:self.view:3 hasNavBar:YES];
    [_scrollView addSubview:self.merchantTF];
    
    //短信校验码输入框背景
    UIImageView *textFieldImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 800, 150, 44)];
    [textFieldImage1 setImage:[UIImage imageNamed:@"textInput.png"]];
    [_scrollView addSubview:textFieldImage1];
    
    self.securityCodeTF = [[LeftTextField alloc] initWithFrame:CGRectMake(10, 800, 150, 44) isLong:FALSE];
    [self.securityCodeTF.contentTF setKeyboardType:UIKeyboardTypeNumberPad];
    [self.securityCodeTF.contentTF setPlaceholder:@"短信校验码"];
    [self.securityCodeTF.contentTF setFont:[UIFont systemFontOfSize:15]];
    self.securityCodeTF.contentTF.delegate = self;
    [self.securityCodeTF.contentTF hideKeyBoard:self.view :2 hasNavBar:NO];
    [_scrollView addSubview:self.securityCodeTF];
    
    _securityCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_securityCodeButton setFrame:CGRectMake(175, 800, 130, 44)];
    [_securityCodeButton setTitle:@"获取短信校验码" forState:UIControlStateNormal];
    [_securityCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _securityCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_securityCodeButton addTarget:self action:@selector(securityCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_securityCodeButton setBackgroundColor:[UIColor grayColor]];
    [_scrollView addSubview:_securityCodeButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 855, 297, 42)];
    [confirmButton setTitle:@"设置支付密码" forState:UIControlStateNormal];
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

-(void)openMenu:(UIImageView *)sender
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    myActionSheet.tag = sender.tag;
    [myActionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    else
    {
    [self openCameraOrLocalPhoto:actionSheet.tag andtype:buttonIndex];
    }
}


- (void)openCameraOrLocalPhoto:(NSInteger)tag andtype:(NSInteger)type
{

    UIImagePickerController *picker = [[MyPickController alloc] init];
    
    picker.navigationBar.tag = tag;
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    if (type == 0) {
        //打开照相机
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(type == 1){
        //打开本地相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

////打开本地相册
//-(void)LocalPhoto:(NSInteger)tag
//{
//    UIImagePickerController *picker = [[MyPickController alloc] init];
//    
//    
//    picker.navigationBar.tag = tag;
//    picker.delegate = self;
//    //设置选择后的图片可被编辑
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];
//}


- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)onClickImageFront{
    // here, do whatever you wantto do
    [self openMenu:_IdCardFront];
}

-(void)onClickImageBack{
    // here, do whatever you wantto do
    [self openMenu:_IdCardBack];
}

-(void)onClickImageBank{
    // here, do whatever you wantto do
    [self openMenu:_bankPic];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //NSLog(@"%@", info);
    // UIImagePickerControllerOriginalImage 原始图片
    //UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (picker.navigationBar.tag == _IdCardFront.tag) {
        _IdCardFront.image = image;
    }
    else if(picker.navigationBar.tag == _IdCardBack.tag){
        _IdCardBack.image = image;
    }
    else if(picker.navigationBar.tag == _bankPic.tag){
        _bankPic.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
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

//设置支付密码
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
    SetPasswordViewController *setPasswordViewController = [[SetPasswordViewController alloc] initWithNibName:@"SetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:setPasswordViewController animated:YES];
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

@end
