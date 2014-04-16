//
//  SuggestionBackViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SuggestionBackViewController.h"
#import "NSData+Base64Additions.h"
#import "UITextField+HideKeyBoard.h"

#define PLACEHOLDER  @"您的意见对我们进步非常重要，我们将为您不断改进"

@implementation SuggestionBackViewController

@synthesize inputTF =_inputTF;
@synthesize yourMailAdressTF = _yourMailAdressTF;
@synthesize countLabel = _countLabel;

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
    self.navigationItem.title = @"意见反馈";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, VIEWHEIGHT)];
    [scrollView setContentSize:CGSizeMake(320, VIEWHEIGHT)];
    scrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    UIImage *flowImage = [UIImage imageNamed:@"flowbg.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 298, 180)];
    [imageView setImage:[self stretchImage:flowImage]];
    [scrollView addSubview:imageView];
    
    self.inputTF = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 295, 170)];
    self.inputTF.text = PLACEHOLDER;
    self.inputTF.textColor = [UIColor lightGrayColor];
    [self.inputTF setBackgroundColor:[UIColor clearColor]];
    [self.inputTF setFont:[UIFont boldSystemFontOfSize:15]];
    self.inputTF.delegate = self;
    [scrollView addSubview:self.inputTF];
    
    self.yourMailAdressTF = [[InputTextField alloc] initWithFrame:CGRectMake(10, 200, 300, 44) left:@"联系方式" prompt:@"选填，便于我们给您答复" keyBoardType:UIKeyboardTypeEmailAddress imageName:@"textInput.png"];
    [self.yourMailAdressTF.contentTF hideKeyBoard:self.view:2 hasNavBar:YES];
    self.yourMailAdressTF.contentTF.delegate = self;
    [scrollView addSubview:self.yourMailAdressTF];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 160, 150, 30)];
    [self.countLabel setText:@"您还可输入150个字"];
    [self.countLabel setTextColor:[UIColor grayColor]];
    [self.countLabel setBackgroundColor:[UIColor clearColor]];
    [self.countLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [scrollView addSubview:self.countLabel];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setFrame:CGRectMake(10, 320, 297, 42)];
    [confirmButton setTitle:@"发   送" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_nomal.png"] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateSelected];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"BFTConfirmButton_highlight.png"] forState:UIControlStateHighlighted];
    [scrollView addSubview:confirmButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)confirmButtonAction:(id)sender
{
    if ([self.inputTF.text length] == 0 || [self.inputTF.text isEqualToString:PLACEHOLDER]) {
        [ApplicationDelegate showErrorPrompt:@"请输入意见反馈的内容"];
        return;
    }
    
    [ApplicationDelegate showProcess:@"正在发送..."];
    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = @"service-snd@ruiyinxin.com";
    testMsg.toEmail =@"service-rcv@ruiyinxin.com";
    testMsg.relayHost = @"smtp.ruiyinxin.com";
    testMsg.requiresAuth = YES;
    testMsg.login = @"service-snd@ruiyinxin.com";
    testMsg.pass = @"1m2n3b4v";
    testMsg.subject = @"WMPay"; // 中文会乱码  完美支付意见反馈
    testMsg.bccEmail = @"tinghuisun@163.com";
    testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    
    NSString *content = [NSString stringWithFormat:@"%@ \n(来自于:%@)", self.inputTF.text, self.yourMailAdressTF.contentTF.text];
    /***
     NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
     content,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
     ***/
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithCString:[content UTF8String] encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    
    [testMsg send];
}

#pragma mark SKPSMTPMessage Delegate Methods
- (void)messageState:(SKPSMTPState)messageState;
{
    //    NSLog(@"HighestState:%d", HighestState);
    //    if (messageState > HighestState)
    //        HighestState = messageState;
    //
    //    ProgressBar.progress = (float)HighestState/(float)kSKPSMTPWaitingSendSuccess;
}
- (void)messageSent:(SKPSMTPMessage *)SMTPmessage
{
    [ApplicationDelegate hideProcess];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"发送成功!"
                                                   delegate:self cancelButtonTitle:@"确  定" otherButtonTitles: nil];
    [alert setTag:100];
    [alert show];
}
- (void)messageFailed:(SKPSMTPMessage *)SMTPmessage error:(NSError *)error
{
    [ApplicationDelegate hideProcess];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"发送失败，请重试"
                                                   delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
    [alert setTag:101];
    [alert show];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.inputTF.text.length < 150) {
        [self.countLabel setText:[NSString stringWithFormat:@"您还可输入%d个字", 150 - self.inputTF.text.length]];
    }
}

-(IBAction)dismissKeyBoard
{
    [self.inputTF resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        [self popToCatalogViewController];
    }
}

@end