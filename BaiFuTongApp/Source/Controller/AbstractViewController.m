//
//  AbstractViewController.m
//  POS2iPhone
//
//  Created by jia liao on 1/6/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "AbstractViewController.h"


#define STRETCH                 5
#define kSCNavBarImageTag       10

@implementation AbstractViewController

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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //自定义UINavigationBar 和返回按钮
        
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
    
    if (!self.navigationItem.hidesBackButton){
        // 返回按纽
        UIImage *buttonNormalImage = [UIImage imageNamed:@"BFTNavBackButton_normal.png"];
        UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_selected.png"];
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setImage:buttonNormalImage forState:UIControlStateNormal];
        [aButton setImage:buttonSelectedImage forState:UIControlStateSelected];
        aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
        [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
        self.navigationItem.leftBarButtonItem = backButton;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.superview.frame;
    int offset = frame.origin.y + 50 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
    float height = [UIScreen mainScreen].bounds.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UIScrollView class]]) {
            //((UIScrollView*)[self.view.subviews objectAtIndex:0]).frame = rect
            ;
            ((UIScrollView*)[self.view.subviews objectAtIndex:0]).contentOffset = CGPointMake(0, offset);
        }else{
            self.view.frame = rect;
        }
        
    }
    [UIView commitAnimations];
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //    CGRect rect = CGRectMake(0.0f, 0.0f,320,416);
    CGRect rect = CGRectMake(0.0f, 0.0f,320,VIEWHEIGHT + 41);
    self.view.frame = rect;
    [UIView commitAnimations];

}


// IOS5默认支持竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// IOS6默认不开启旋转，如果subclass需要支持屏幕旋转，重写这个方法return YES即可
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

// IOS6默认支持竖屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(IBAction)bgButtonAction:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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

-(IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToCatalogViewController
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void)popToLoginViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setLabelStyle:(UILabel*)label
{
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
}
@end
