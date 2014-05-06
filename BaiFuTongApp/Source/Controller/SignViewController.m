//
//  SignViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-29.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SignViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Scaling.h"
#import "Transfer+Action.h"
#import "StringUtil.h"

#define STRETCH             5
#define kSCNavBarImageTag   10
#define NUMBERS             @"0123456789\n"

@implementation SignViewController

@synthesize amountLabel = _amountLabel;
@synthesize signPanel = _signPanel;
@synthesize delegate = _delegate;
@synthesize phoneNumTF = _phoneNumTF;

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
    self.navigationItem.title = @"请您签名";
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //if iOS 5.0 and later
        [navBar setBackgroundImage:[UIImage imageNamed:@"BFTNavbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BFTNavbar.png"]];
            [imageView setTag:kSCNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
    
//    [self.amountLabel setText:[StringUtil string2SymbolAmount:[[Transfer sharedTransfer].receDic objectForKey:@"field4"]]];
    
    if (DeviceVersion>=7) {
        for (int i = 0; i<self.view.subviews.count; i++) {
            UIView *view = self.view.subviews[i];
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+40, view.frame.size.width, view.frame.size.height);
            if (iPhone5) {
                if ([self.view.subviews[i] isKindOfClass:[UIButton class]]) {
                    view.frame = CGRectMake(view.frame.origin.x+74, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                }
                else{
                    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width+88, view.frame.size.height);
                }
            }
        }
        
    }
    
    self.phoneNumTF.delegate = self;
    
    UIImage *buttonNormalImage = [UIImage imageNamed:@"backbutton_normal.png"];
    UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_selected.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setImage:buttonNormalImage forState:UIControlStateNormal];
    [aButton setImage:buttonSelectedImage forState:UIControlStateSelected];
    aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
    [aButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // 签名面板
    self.signPanel = [[HandSignPanel alloc] initWithFrame:CGRectMake(0, 40+ios7_y, 480 + (iPhone5?88:0), 190) withText:[[Transfer sharedTransfer].receDic objectForKey:@"MD5"]];
    self.signPanel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.signPanel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}
#pragma mark-  IBAciton Methods
//确定
-(IBAction)finish:(id)sender
{
    if (![self.phoneNumTF.text isEqualToString:@""] && self.phoneNumTF.text.length < 11) {
        [ApplicationDelegate showErrorPrompt:@"手机号不能少于11位" ViewController:self];
        return ;
    }
    
    //[ApplicationDelegate showProcess:@"正在处理请稍候..."];
    if (![self.signPanel isDraw]) {
        [ApplicationDelegate showErrorPrompt:@"请先完成签名" ViewController:self];
        
        return;
    }
    
    // 生成签名图片
	UIGraphicsBeginImageContext(self.signPanel.bounds.size);
	[self.signPanel.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* tempImage=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	//UIImageWriteToSavedPhotosAlbum([image imageByScalingAndCroppingForSize:CGSizeMake(48, 17)], self, nil, nil);
    
    // 压缩图片并生成Base64格式
    UIImage *image = [tempImage imageByScalingAndCroppingForSize:CGSizeMake(300, 110)];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageBase64 = [data base64EncodedString];
    
    // 添加数据
    // TODO 手机号
    [[Transfer sharedTransfer].receDic setObject:(self.phoneNumTF.text ? self.phoneNumTF.text:@"") forKey:@"receivePhoneNo"];
    [[Transfer sharedTransfer].receDic setObject:imageBase64 forKey:@"fieldImage"];
    [[Transfer sharedTransfer].receDic setObject:[[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__UUID"] forKey:@"imei"];
  
    //此处报错　setObjectForKey: object cannot be nil (key: field41)'
//    [[Transfer sharedTransfer] uploadSignImageAction];
    
    [ApplicationDelegate hideProcess];
    
    // 签购单界面执行delegate方法，并关闭本界面
    [self.delegate abstractViewControllerDone:tempImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//清除
-(IBAction)myPalttealllineclear
{
	[self.signPanel myalllineclear];
}

-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
//手指开始触屏开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch=[touches anyObject];
	myBeganpoint=[touch locationInView:self.view ];
	if (DeviceVersion>=7) {
        myBeganpoint = CGPointMake(myBeganpoint.x+5, myBeganpoint.y-88);
    }else{
        myBeganpoint = CGPointMake(myBeganpoint.x-10, myBeganpoint.y-40);
    }
	[self.signPanel Introductionpoint1];
	[self.signPanel Introductionpoint3:myBeganpoint];
	
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray* MovePointArray=[touches allObjects];
	myMovepoint=[[MovePointArray objectAtIndex:0] locationInView:self.signPanel];
	[self.signPanel Introductionpoint3:myMovepoint];
    [self.signPanel setNeedsDisplay];
}

//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.signPanel Introductionpoint2];
    [self.signPanel setNeedsDisplay];
}

// IOS5默认支持竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

// IOS6默认不开启旋转，如果subclass需要支持屏幕旋转，重写这个方法return YES即可
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

// IOS6默认支持竖屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneNumTF) {
        if ([string isEqualToString:@"\n"]) {
            [textField resignFirstResponder];
            return NO;
        }
        
        if(range.location>=11){
            return NO;
        }
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            return NO;
        }
    }
    
    return YES;
}

-(UIImage *)stretchImage:(UIImage *) image
{
    UIImage *returnImage = nil;
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion == 5.0) {
        returnImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(15, STRETCH, STRETCH, STRETCH)];
    }else if(systemVersion >= 6.0){
        returnImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, STRETCH, STRETCH, STRETCH)resizingMode:UIImageResizingModeTile];
    }
    return returnImage;
}

@end
