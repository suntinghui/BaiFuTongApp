//
//  SecondMenuViewController.m
//  BFTApp
//
//  Created by xushuang on 13-8-30.
//  Copyright (c) 2013年 xushuang. All rights reserved.
//

#import "SecondMenuViewController.h"
#import "CatalogModel.h"
#import "ParseXMLUtil.h"
#import "LoginViewController.h"
#import "TransListViewController.h"

@interface SecondMenuViewController ()

- (void)revealSidebar;

@end

@implementation SecondMenuViewController

@synthesize panelTableView          = _panelTableView;
@synthesize catalogArray            = _catalogArray;
@synthesize currentCatalogArray     = _currentCatalogArray;

- (void)revealSidebar {
	_revealBlock();
}

- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock
          catalogId:(NSInteger)catalogId
{
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
        _catalogId = catalogId;
        _currentCatalogArray = [[NSMutableArray alloc] init];
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil catalogId:(NSInteger)catalogId
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
    
    self.catalogArray = [ParseXMLUtil parseCatalogXML];
    
    //显示具体二级菜单界面
    if (DeviceVersion >= 7)
    {
        _panelTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 480+iPhone5_height) style:UITableViewStyleGrouped];
    }
    else
    {
        _panelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420+iPhone5_height) style:UITableViewStyleGrouped];
    }
    _panelTableView.showsVerticalScrollIndicator = false;
    self.panelTableView.backgroundColor = [UIColor clearColor];
    self.panelTableView.delegate        = self;
    self.panelTableView.dataSource      = self;
    [self.view addSubview:self.panelTableView];
    
    //    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [self.panelTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(IBAction)backButtonAction:(id)sender
{
    [self revealSidebar];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - *tableView methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self.currentCatalogArray removeAllObjects];
    
    for (CatalogModel *model in self.catalogArray) {
        if (model.parentId == _catalogId) {
            [self.currentCatalogArray addObject:model];
        }
    }
    return [self.currentCatalogArray count];
    
//    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString     *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    CatalogModel *catalog = ((CatalogModel *)[self.currentCatalogArray objectAtIndex:indexPath.section]);
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 4, 200, 36)];
    textLabel.textColor = [UIColor blackColor];
    textLabel.text = catalog.title;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:textLabel];
    
    //选中这张图片看不太明显　是否该换一张？　
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BFTSecondMenuCellBg_highlight2.png"]];
    cell.selectedBackgroundView = bgView;
    
    UIView *normalbgView = [[UIView alloc] init];
    normalbgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BFTSecondMenuCellBg_normal.png"]];
    cell.backgroundView = normalbgView;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 38, 38)];
    [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"BFTSecondMenuIcon_%d.png",catalog.iconId]]];
    [cell.contentView addSubview:image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CatalogModel *catalogModel = (CatalogModel *)[self.currentCatalogArray objectAtIndex:indexPath.section];
    
//    if ( [[[NSUserDefaults standardUserDefaults] objectForKey:@"LOGIN"] isEqualToString:@"NO"])
//    {
//        //记录登录过后跳转到哪个界面　
//        [[NSUserDefaults standardUserDefaults] setObject:catalogModel.title forKey:@"ACTIONNAME"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",catalogModel.catalogId] forKey:@"CATALOGID"];
//        
//        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        [self.navigationController pushViewController:login animated:YES];
//    }
//    else
//    {
        [self doAction:catalogModel];
    //}
    
}

//右边tableView事件
- (void)doAction:(CatalogModel *)catalog
{
    if ([[catalog actionType] caseInsensitiveCompare:@"viewController"] == NSOrderedSame)
    {
        id theClass = NSClassFromString(catalog.action);
        if (!theClass)
        {
            NSLog(@"没有找到类 %@", [catalog action]);
            return;
        }
        
        UIViewController *theViewController = [[theClass alloc] init];
        //因为账户交易查询和卡交易查询界面基本相同，只是相关的值有区别，所以用同一个界面，只不过设定一个类别的分辨值，来区分两个界面
        if ([catalog.title isEqualToString:@"账户交易查询"]) {
            ((TransListViewController *)theViewController).isAccountTrade = YES;
        }
        else if([catalog.title isEqualToString:@"卡交易查询"]){
            ((TransListViewController *)theViewController).isAccountTrade = NO;
        }
        [self.navigationController pushViewController:theViewController animated:YES];
        
    }
    else if ([[catalog actionType] caseInsensitiveCompare:@"checkupdate"] == NSOrderedSame)
    {
        
    }
    
}

@end
