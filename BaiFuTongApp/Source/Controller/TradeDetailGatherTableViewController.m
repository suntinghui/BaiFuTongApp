//
//  TradeDetailGatherTableViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "TradeDetailGatherTableViewController.h"
#import "TradeGatherCell.h"
#import "TradeDetailTableViewController.h"
#import "SystemConfig.h"
#import "StringUtil.h"

#define HEIGHTFORROW 100

@interface TradeDetailGatherTableViewController ()

@end

@implementation TradeDetailGatherTableViewController

@synthesize myTableView = _myTableView;
@synthesize dataArray = _dataArray;
@synthesize beginString = _beginString;
@synthesize  endString = _endString;

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
    self.navigationItem.title = @"交易明细汇总";
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, VIEWHEIGHT) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.myTableView];
    
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
    TradeGatherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[TradeGatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //解决刷新重用cell事字体重复问题
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for(UIView*subview in subviews) {
        [subview removeFromSuperview];
    }
    if (self.dataArray && [self.dataArray count] != 0) {
        NSArray *tmpArray = [(NSString*)[self.dataArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"];
        if (tmpArray && [tmpArray count] != 0) {
            cell.amountLabel.text = [StringUtil string2SymbolAmount:[StringUtil amount2String:(NSString*)[[(NSString*)[tmpArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:1]]];
            cell.totalLabel.text = (NSString*)[[(NSString*)[tmpArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
            NSString *typeStr = (NSString*)[[(NSString*)[tmpArray objectAtIndex:2] componentsSeparatedByString:@":"] objectAtIndex:1];
            cell.typeLabel.text = [[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:typeStr];
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *totalStr = nil;
    NSString *typeStr = nil;
    
    if(self.dataArray && [self.dataArray count] != 0)
    {
        NSArray *tmpArray = [(NSString*)[self.dataArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"];
        NSString *total = (NSString*)[[(NSString*)[tmpArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
        if (![total isEqualToString:@"0"]) {
            NSArray *tmpArray = [(NSString*)[self.dataArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"^"];
            if (tmpArray && [tmpArray count] != 0) {
                totalStr = (NSString*)[[(NSString*)[tmpArray objectAtIndex:1] componentsSeparatedByString:@":"] objectAtIndex:1];
                typeStr = (NSString*)[[(NSString*)[tmpArray objectAtIndex:2] componentsSeparatedByString:@":"] objectAtIndex:1];
                
            }
            TradeDetailTableViewController *vc = [[TradeDetailTableViewController alloc] initWithNibName:@"TradeDetailTableViewController" bundle:nil];
            vc.totalCount = totalStr;
            vc.tranCode = typeStr;
            vc.beginString = self.beginString;
            vc.endString = self.endString;
            vc.pageNo = @"1";
            vc.pageSize = [NSString stringWithFormat:@"%d", [SystemConfig sharedSystemConfig].pageSize];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

@end
