//
//  RealnameLegalizeViewController.m
//  BaiFuTongApp
//
//  Created by 霍庚浩 on 14-4-16.
//  Copyright (c) 2014年 xushuang. All rights reserved.
//

#import "RealnameLegalizeViewController.h"

@interface RealnameLegalizeViewController ()<UIImagePickerControllerDelegate>
- (IBAction)openCamera:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *IDcardFront;
@property (weak, nonatomic) IBOutlet UIButton *IDcardBack;


@end

@implementation RealnameLegalizeViewController

-(id)init
{
    self = [self initWithNibName:@"RealnameLegalizeViewController" bundle:nil];
    return self;
}

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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openCamera:(UIButton *)sender {
//    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//    if (!isCamera) {
//        NSLog(@"没有摄像头");
//        return ;
//    }
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePicker.delegate = self;
//    // 编辑模式
//    imagePicker.allowsEditing = YES;
//    
//    [self  presentViewController:imagePicker animated:YES completion:^{
//    }];
    NSLog(@"123");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.mediaTypes = temp_MediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
    }

    [self presentViewController:picker animated:YES completion:^{
        
    }];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
