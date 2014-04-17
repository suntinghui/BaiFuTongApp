//
//  NoviceGuideViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "NoviceGuideViewController.h"
#import "BFTRootViewController.h"

@implementation NoviceGuideViewController
@synthesize gotoMainViewBtn = _gotoMainViewBtn;

@synthesize imageView;
@synthesize left = _left;
@synthesize right = _right;
@synthesize pageScroll;
@synthesize pageControl;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    // self.navigationController.delegate = self;
    //
    
    [UserDefaults setBool:YES forKey:ALREAD_SHOWGUIDE];
    
    pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    pageScroll.pagingEnabled = YES;
    pageScroll.showsHorizontalScrollIndicator = NO;
    pageScroll.delegate = self;
    
    UIImageView *guideView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(iPhone5?@"guide_1-568h":@"guide_1")]];
    [guideView1 setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [pageScroll addSubview:guideView1];
    
    UIImageView *guideView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(iPhone5?@"guide_2-568h":@"guide_2")]];
    [guideView2 setFrame:CGRectMake(320, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [pageScroll addSubview:guideView2];
    
    UIImageView *guideView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(iPhone5?@"guide_3-568h":@"guide_3")]];
    [guideView3 setFrame:CGRectMake(640, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [pageScroll addSubview:guideView3];
    
    UIImageView *guideView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(iPhone5?@"guide_4-568h":@"guide_4")]];
    [guideView4 setFrame:CGRectMake(960, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [pageScroll addSubview:guideView4];
    
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mainButton setFrame:CGRectMake(960 + 92, 306 + (iPhone5?88:0), 136, 32)];
    [mainButton setTitle:@"立刻体验" forState:UIControlStateNormal];
    [mainButton setBackgroundImage:[UIImage imageNamed:@"guidebutton.png"] forState:UIControlStateNormal];
    [mainButton addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
    [pageScroll addSubview:mainButton];
    
    [self.view addSubview:pageScroll];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(141, 420 + (iPhone5?88:0), 38, 36)];
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    
    pageScroll.contentSize = CGSizeMake(320 * 4, [UIScreen mainScreen].bounds.size.height);
    
}

- (void)viewDidUnload
{
    [self setGotoMainViewBtn:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)gotoMainView:(id)sender {
    if ([UserDefaults boolForKey:ALREAD_SHOWGUIDE]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [ApplicationDelegate.rootNavigationController pushViewController:[[BFTRootViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

#pragma mark - UINavigationControllerDelegate Method
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animate
{
    if ( self == viewController) {
        [navigationController setNavigationBarHidden:YES animated:animate];
    } else  {
        [navigationController setNavigationBarHidden:NO animated:animate];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBarHidden = NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end