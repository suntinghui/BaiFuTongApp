//
//  SalesSlipListViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SalesSlipListViewController.h"
#import "SystemConfig.h"
#import "TradeDetailCell.h"
#import "DateUtil.h"
#import "StringUtil.h"
#import "QueryReceiptDetailViewController.h"

#define HEIGHTFORROW 130
@interface SalesSlipListViewController ()

@end

@implementation SalesSlipListViewController
@synthesize beginString = _beginString;
@synthesize endString = _endString;

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
    self.navigationItem.title = @"签购单列表";
    
    if (!self.dataArray || [self.dataArray count] == 0) {
        UIImageView *emptyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyImage.png"]];
        [emptyView setFrame:CGRectMake(97, 180, 126, 80)];
        [self.view addSubview:emptyView];
    }else{
        self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, VIEWHEIGHT) style:UITableViewStylePlain];
        self.myTableView.delegate = self;
        self.myTableView.dataSource = self;
        [self.myTableView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.myTableView];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
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
    TradeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[TradeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.dataArray && [self.dataArray count] != 0) {
        NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
        cell.typeLabel.text = [[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:[dic objectForKey:@"fieldTrancode"]];
        cell.timeLabel.text = [DateUtil formatDateTime:[NSString stringWithFormat:@"%@%@", [dic objectForKey:@"field13"], [dic objectForKey:@"field12"]]];
        cell.amountLabel.text = [StringUtil string2SymbolAmount:[dic objectForKey:@"field4"]];
        cell.accountLabel.text = [StringUtil formatAccountNo:[dic objectForKey:@"field2"]];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QueryReceiptDetailViewController *vc = [[QueryReceiptDetailViewController alloc] initWithParams:[self.dataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
