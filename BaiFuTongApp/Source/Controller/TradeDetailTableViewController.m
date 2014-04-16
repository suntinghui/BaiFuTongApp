//
//  TradeDetailTableViewController.m
//  BaiFuTongApp
//
//  Created by xushuang on 13-9-27.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "TradeDetailTableViewController.h"
#import "TradeDetailCell.h"
#import "TradeMoreDetailViewController.h"
#import "TradeDetail.h"

#define HEIGHTFORROW 135

@implementation TradeDetailTableViewController

@synthesize myTableView = _myTableView;
@synthesize pageView = _pageView;
@synthesize array = _array;
@synthesize beginString = _beginString;
@synthesize endString = _endString;
@synthesize pageNo = _pageNo;
@synthesize pageSize = _pageSize;
@synthesize tranCode = _tranCode;
@synthesize totalCount = _totalCount;

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
    self.navigationItem.title = @"交易明细列表";
    
    [self requestAction];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

-(void)requestAction
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.pageNo forKey:@"pageNo"];
    [dic setObject:self.pageSize forKey:@"pageSize"];
    [dic setObject:self.tranCode forKey:@"tranCode"];
    [dic setObject:self.beginString forKey:@"BeginDate"];
    [dic setObject:self.endString forKey:@"EndDate"];
    [dic setObject:self.totalCount forKey:@"totalCount"];
    
//    [[Transfer sharedTransfer] startTransfer:@"600000002" fskCmd:@"Request_GetExtKsn#Request_VT" paramDic:dic];
}

-(void)refreshTabelView
{
    if (!self.array || [self.array count] == 0) {
        [self.myTableView setHidden:YES];
        UIImageView *emptyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyImage.png"]];
        [emptyView setFrame:CGRectMake(97, 180, 126, 80)];
        [self.view addSubview:emptyView];
    }else {
        if (self.myTableView == nil) {
            self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, VIEWHEIGHT - 30) style:UITableViewStylePlain];
            self.myTableView.delegate = self;
            self.myTableView.dataSource = self;
            [self.myTableView setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:self.myTableView];
            
            self.pageView = [[PageView alloc] initWithFrame:CGRectMake(0, VIEWHEIGHT + 11, 320, 30)];
            int total = self.totalCount.intValue;
            int size = self.pageSize.intValue;
            [self.pageView setNumerator:@"1" denominator:[NSString stringWithFormat:@"%d", (total + size-1)/size]];
            _pageView.delegate = self;
            [self.view addSubview:_pageView];
        }
    }
    
    [self.myTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    TradeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[TradeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.array && [self.array count] != 0) {
        
        NSString *detailStr =  (NSString*)[self.array objectAtIndex:indexPath.row];
        TradeDetail *detail = [[TradeDetail alloc] initWithString:detailStr];
        cell.typeLabel.text = [[AppDataCenter sharedAppDataCenter].transferNameDic objectForKey:detail.tranCode];
        cell.amountLabel.text = detail.tranAmt;
        cell.timeLabel.text = [NSString stringWithFormat:@"%@ %@", detail.tranDate, detail.tranTime];
        cell.accountLabel.text = detail.cardNo;
        
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.array && [self.array count] != 0) {
        
        NSString *detailStr =  (NSString*)[self.array objectAtIndex:indexPath.row];
        TradeDetail *detail = [[TradeDetail alloc] initWithString:detailStr];
        TradeMoreDetailViewController *vc = [[TradeMoreDetailViewController alloc] initWithNibName:@"TradeMoreDetailViewController" bundle:nil];
        vc.detail = detail;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - PageDelegate
-(void)firstPageButtonAction
{
    int total = self.totalCount.intValue;
    int size = self.pageSize.intValue;
    [self.pageView setNumerator:@"1" denominator:[NSString stringWithFormat:@"%d", (total + size-1)/size]];
    if ([self.pageNo isEqualToString:@"1"]) {
        [ApplicationDelegate showErrorPrompt:@"已经是第一页"];
    }else{
        self.pageNo = @"1";
        [self requestAction];
    }
}
-(void)previousPageButtonAction
{
    int count = self.pageNo.intValue;
    if (count > 1) {
        count --;
        int total = self.totalCount.intValue;
        int size = self.pageSize.intValue;
        [self.pageView setNumerator:[NSString stringWithFormat:@"%d", count] denominator:[NSString stringWithFormat:@"%d", (total + size-1)/size]];
        self.pageNo = [NSString stringWithFormat:@"%d", count];
        [self requestAction];
    }else{
        [ApplicationDelegate showErrorPrompt:@"已经是第一页"];
    }
}
-(void)nextPageButtonAction
{
    int count = self.pageNo.intValue;
    int total = self.totalCount.intValue;
    int size = self.pageSize.intValue;
    if (count < (total + size-1)/size) {
        count ++;
        [self.pageView setNumerator:[NSString stringWithFormat:@"%d", count] denominator:[NSString stringWithFormat:@"%d", (total + size-1)/size]];
        self.pageNo = [NSString stringWithFormat:@"%d", count];
        [self requestAction];
    }else{
        [ApplicationDelegate showErrorPrompt:@"已经是最后一页"];
    }
}
-(void)lastPageButtonAction
{
    int count = self.pageNo.intValue;
    int total = self.totalCount.intValue;
    int size = self.pageSize.intValue;
    if (count == (total + size-1)/size) {
        [ApplicationDelegate showErrorPrompt:@"已经是最后一页"];
    }else{
        [self.pageView setNumerator:[NSString stringWithFormat:@"%d", count] denominator:[NSString stringWithFormat:@"%d", (total + size-1)/size]];
        self.pageNo = [NSString stringWithFormat:@"%d", (total + size-1)/size];
        [self requestAction];
    }
}

@end
