//
//  GatherCancelTableViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "GatherCancelTableViewController.h"
#import "GatherCancelCell.h"
#import "ConfirmCancelViewController.h"
#import "StringUtil.h"
#import "DateUtil.h"
#import "TransferSuccessDBHelper.h"

#define HEIGHTFORROW 100

@implementation GatherCancelTableViewController

@synthesize myTableView = _myTableView;
@synthesize array = _array;

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
    self.navigationItem.title = @"撤销列表";
    
    //[ApplicationDelegate showProcess:@"正在查询数据"];
    
    TransferSuccessDBHelper *helper = [[TransferSuccessDBHelper alloc] init];
    self.array = [helper queryNeedRevokeTransfer];
    [ApplicationDelegate hideProcess];
    
    if (self.array && [self.array count] > 0) {
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, VIEWHEIGHT) style:UITableViewStylePlain];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        [self.myTableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.myTableView];
    } else {
        UIImageView *emptyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyImage.png"]];
        [emptyView setFrame:CGRectMake(97, 180, 126, 80)];
        [self.view addSubview:emptyView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHTFORROW;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GatherCancelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[GatherCancelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    self.model = (SuccessTransferModel *)[self.array objectAtIndex:indexPath.row];
    cell.accountLabel.text = [StringUtil formatAccountNo:[self.model.content objectForKey:@"field2"]];
    cell.timeLabel.text = [DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [self.model.content objectForKey:@"field13"], [self.model.content objectForKey:@"field12"]]];
    cell.amountLabel.text = [StringUtil string2SymbolAmount:[self.model.content objectForKey:@"field4"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ConfirmCancelViewController *vc = [[ConfirmCancelViewController alloc] initWithModel:[self.array objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
