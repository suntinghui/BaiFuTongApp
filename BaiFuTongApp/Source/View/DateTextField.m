//
//  DateTextField.m
//  POS2iPhone
//
//  Created by jia liao on 1/13/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import "DateTextField.h"

@implementation DateTextField

@synthesize leftLabel = _leftLabel;
@synthesize actionSheet = _actionSheet;
@synthesize contentLabel = _contentLabel;
@synthesize datePicker = _datePicker;

- (id)initWithFrame:(CGRect)frame bgImage:(NSString *) imageName leftText:(NSString *) leftText
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
        [self addSubview:bgImageView];
        
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, frame.size.height*3/4)];
        [self.leftLabel setText:leftText];
        [self.leftLabel setTextColor:[UIColor blackColor]];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        [self.leftLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:self.leftLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, frame.size.width-50, frame.size.height)];
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:self.contentLabel];
        
        UIButton *dateButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, frame.size.width-60, frame.size.height)];
        [dateButton setBackgroundColor:[UIColor clearColor]];
        [dateButton addTarget:self action:@selector(dateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dateButton];
        
    }
    return self;
}

-(IBAction)dateButtonAction:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self     cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,40, 320, 190)];
    [self.actionSheet addSubview:self.datePicker];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    
    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,40)];
    tools.barStyle=UIBarStyleBlackOpaque;
    [self.actionSheet addSubview:tools];
    
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinDoneClicked:)];
    doneButton.imageInsets=UIEdgeInsetsMake(200, 5, 50, 30);
    
    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *array = [[NSArray alloc]initWithObjects:flexSpace,flexSpace,doneButton,nil];
    
    [tools setItems:array];
    
    [self.actionSheet showFromRect:CGRectMake(0,480, 320,200) inView:self animated:YES];
    [self.actionSheet setBounds:CGRectMake(0,0, 320, 411)];
}

-(IBAction)btnActinDoneClicked:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:[self.datePicker date]];
    [self.contentLabel setText:destDateString];
    [self.actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}

-(NSString *)value
{
    return self.contentLabel.text;
}
@end
