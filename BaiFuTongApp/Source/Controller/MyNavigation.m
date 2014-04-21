//
//  MyNavigation.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-21.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "MyNavigation.h"

@interface MyNavigation ()

@end

@implementation MyNavigation

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
        return [[self.viewControllers lastObject] shouldAutorotate];
    }
-(NSUInteger)supportedInterfaceOrientations {
        return [[self.viewControllers lastObject] supportedInterfaceOrientations];
    }
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
        return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
