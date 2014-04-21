//
//  AnnouncementListViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "AnnouncementListViewController.h"
#import "AnnouncementDBHelper.h"
#import "AnnouncementModel.h"
#import "AnnouncementCell.h"
#import "AnnouncementDetailViewController.h"

#define CELL_HEIGHT 100

@implementation AnnouncementListViewController

@synthesize array = _array;
@synthesize tableView = _tableView;

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"公告";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+iPhone5_height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    NSLog(@"服务器最新公告编号:%@", [UserDefaults stringForKey:SERVER_ANNOUNCEMENT_LASTEST_NUM]);
    NSLog(@"数据库最新公告编号:%@", [UserDefaults stringForKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM]);
    
    if ([[UserDefaults stringForKey:SERVER_ANNOUNCEMENT_LASTEST_NUM] isEqualToString:[UserDefaults stringForKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM]]) {
        [self refreshTabelView];
        
    } else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:[UserDefaults stringForKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM]?[UserDefaults stringForKey:SYSTEM_ANNOUNCEMENT_LASTEST_NUM]:@"0" forKey:@"noticeVersion"];
    
//        [[Transfer sharedTransfer] startTransfer:@"999000001" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) refreshTabelView
{
    AnnouncementDBHelper *helper = [[AnnouncementDBHelper alloc] init];
    self.array = [NSArray arrayWithArray:[helper queryAllAnnouncement]];
    if (self.array == nil || [self.array count] == 0) {
        UIImageView *emptyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyImage.png"]];
        [emptyView setFrame:CGRectMake(97, 180, 126, 80)];
        [self.view addSubview:emptyView];
    } else {
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_array count];
    //return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text = ((AnnouncementModel*)[_array objectAtIndex:indexPath.row]).title;
    cell.dateLabel.text = ((AnnouncementModel*)[_array objectAtIndex:indexPath.row]).date;
    cell.contentLabel.text = ((AnnouncementModel*)[_array objectAtIndex:indexPath.row]).content;
//    cell.titleLabel.text = @"123";
//    cell.dateLabel.text =  @"2013-01-05";
//    cell.contentLabel.text = @"jfiejfioejfiejifjeifjepijfipejfijseoifjeoijfeifiejwsifjiejfiepowjpfojepoiwjfpoejwpofjkejpfojeopsfjkesjf";
//    NSString *contentStr = @"jfiejfioejfiejifjeifjepijfipejfijseoifjeoijfeifiejwsifjiejfiepowjpfojepoiwjfpoejwpofjkejpfojeopsfjkesjf";
    NSString *contentStr = ((AnnouncementModel*)[_array objectAtIndex:indexPath.row]).content;
    CGFloat constrainedSize = 290.0f;
    UIFont * myFont = [UIFont fontWithName:@"Arial" size:14];
    cell.contentLabel.font=myFont;
    CGSize textSize = [contentStr sizeWithFont: myFont constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX)
                       
                                 lineBreakMode:NSLineBreakByWordWrapping];
    cell.contentLabel.textColor=[UIColor blackColor];
    cell.contentLabel.numberOfLines=2;
    cell.contentLabel.text=contentStr;
    cell.contentLabel.frame=CGRectMake(10, 40, textSize.width, 50);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AnnouncementDetailViewController *vc = [[AnnouncementDetailViewController alloc] initWithModel:[self.array objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
