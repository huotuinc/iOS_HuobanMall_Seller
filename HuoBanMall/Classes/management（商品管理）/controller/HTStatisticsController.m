//
//  HTStatisticsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//  3个统计页面

#import "HTStatisticsController.h"
#import "HTTStatisticCell.h"
#import "HTStatisticsModel.h"
#import "MJRefresh.h"

@interface HTStatisticsController ()<UISearchBarDelegate>


/**明细分析*/
@property(nonatomic,strong) NSMutableArray * dateStat;


@property(nonatomic,strong) NSMutableArray * liushui;

@property(nonatomic,strong) NSMutableArray * Topliushui;


@property(nonatomic,strong) UISearchBar * mysearch;

@property (nonatomic, strong) UIView *searchView;

@property(nonatomic,strong) UISegmentedControl * mySegmented;
@end

@implementation HTStatisticsController

/**
 *  模型数据
 *
 *  @return
 */
- (NSMutableArray *)dateStat{
    if (_dateStat == nil) {
        _dateStat = [NSMutableArray array];
    }
    return _dateStat;
}

- (NSMutableArray *)liushui{
    
    if (_liushui == nil) {
        
        _liushui = [NSMutableArray array];
    }
    
    return _liushui;
}


- (NSMutableArray *)Topliushui{
    if (_Topliushui == nil) {

        _Topliushui = [NSMutableArray array];
    }
    
    return _Topliushui;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化一些
    [self setup];
    
    [self toGetInitializeDataWithSearchKey:nil];
    
    //获取前十数据
    [self toGetTop];
    
    /**集成刷新控件*/
    [self setupRefresh];
 }

/**
 *  获取前十数据
 */
- (void)toGetTop{
    
    NSString * StatisticsControllerJieKous = nil;
    if(self.type == 1){
        StatisticsControllerJieKous = @"topScore";
    }else if(self.type ==  2){
        StatisticsControllerJieKous = @"topConsume";
    }else{
        StatisticsControllerJieKous = @"topSales";
    }
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [UserLoginTool loginRequestGet:StatisticsControllerJieKous parame:nil success:^(id json) {
        [SVProgressHUD dismiss];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            NSArray * models = [HTStatisticsModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            if (models.count) {
                [self.Topliushui removeAllObjects];
                [self.Topliushui addObjectsFromArray:models];
            }
            
        }

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error.description);
    }];
}

- (void)setup{
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIButton * searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"ss"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBarItems:) forControlEvents:UIControlEventTouchUpInside];
    
    UISegmentedControl * aa = [[UISegmentedControl alloc] initWithItems:@[@"明细",@"统计"]];
    aa.frame =  CGRectMake(0, 0, 120, 30);
    self.mySegmented = aa;
    aa.selectedSegmentIndex = 0;
    self.navigationItem.titleView = aa;
    [aa addTarget:self action:@selector(SegmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    
    if(self.type == 1){
        self.title = @"返利统计";
    }else if(self.type ==  2){
        self.title = @"消费统计";
    }else{
        self.title = @"销售明细";
    }
    
    UISearchBar *mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.showsCancelButton = YES;
    mySearchBar.placeholder = @"搜索条件";
    mySearchBar.frame = CGRectMake(8, 0, self.navigationController.navigationBar.frame.size.width-16, 44);
    
    [mySearchBar setDelegate:self];
//    mySearchBar.hidden = YES;
    _mysearch = mySearchBar;
    [[[[_mysearch.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.searchView.backgroundColor = NavBackgroundColor;
    [self.searchView addSubview:mySearchBar];
    self.searchView.hidden = YES;
    
    [self.navigationController.navigationBar addSubview:self.searchView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mysearch resignFirstResponder];
    self.searchView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dateStat.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTTStatisticCell * cell = [HTTStatisticCell cellWithTableView:tableView];
    HTStatisticsModel * model = self.dateStat[indexPath.row];
    model.Type = self.type;
    cell.model = model;
    cell.userInteractionEnabled = NO;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}



#pragma mark 集成刷新空间
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载更多数据,请稍等";
    
}
//
//
//
//头部刷新
- (void)headerRereshing  //加载最新数据
{
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"pagingTag"] = @"";
//    params[@"pagingSize"] = @(pageSize);
    if (self.mySegmented.selectedSegmentIndex == 0) {
        [self toGetInitializeDataWithSearchKey:nil];
    }else{
        [self Topliushui];
    }
    // 2.(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

//
//尾部刷新
- (void)footerRereshing{  //加载更多数据数据
    
    HTStatisticsModel * bbbs = [self.dateStat lastObject];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    if (self.type == 1) {
        params[@"lastId"] = @(bbbs.pid);
    }else{
        params[@"lastDate"] = @(bbbs.time);
    }
    [self getMoreData:params];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}

/**
 *   上拉加载更多
 *
 *
 */
- (void)getMoreData:(NSMutableDictionary *) params{
    NSString * StatisticsControllerJieKou = nil;
    if(self.type == 1){
        StatisticsControllerJieKou = @"userScoreList";
    }else if(self.type ==  2){
        StatisticsControllerJieKou = @"userConsumeList";
    }else{
        StatisticsControllerJieKou = @"salesList";
    }
    __weak HTStatisticsController *wself = self;
    [UserLoginTool loginRequestGet:StatisticsControllerJieKou parame:params success:^(id json) {
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            NSArray * models = [HTStatisticsModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            if (models.count) {
                //纪录数据
                [wself.liushui addObjectsFromArray:models];
                [wself.dateStat addObjectsFromArray:models];
                [wself.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
 
    }];
    
}

- (void)toGetInitializeDataWithSearchKey:(NSString * )key{
    
    NSString * StatisticsControllerJieKou = nil;
    if(self.type == 1){
        StatisticsControllerJieKou = @"userScoreList";
    }else if(self.type ==  2){
        StatisticsControllerJieKou = @"userConsumeList";
    }else{
        StatisticsControllerJieKou = @"salesList";
    }
    NSMutableDictionary * paramess= [NSMutableDictionary dictionary];
    if ([key length]) {
        paramess[@"key"] = key;
    }
    __weak HTStatisticsController *wself = self;
    [UserLoginTool loginRequestGet:StatisticsControllerJieKou parame:paramess success:^(id json) {
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            NSArray * models = [HTStatisticsModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            if (models.count) {
                [wself.liushui removeAllObjects];
                [wself.liushui addObjectsFromArray:models];
                [self.dateStat removeAllObjects];
                [self.dateStat addObjectsFromArray:models];
                [self.tableView reloadData];
            }
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}


#pragma mark 监听搜索按钮点击

- (void)searchBarItems:(UIButton *)btn{
    
    [self.mysearch becomeFirstResponder];
    self.searchView.hidden = !self.searchView.hidden;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    self.searchView.hidden = YES;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    [self toGetInitializeDataWithSearchKey:searchBar.text];
     self.searchView.hidden = YES;
}

#pragma mark segmentChange
- (void)SegmentedControlValueChange:(UISegmentedControl *) seg{
  
    if(seg.selectedSegmentIndex == 0) {

        [self.dateStat removeAllObjects];
        [self.dateStat addObjectsFromArray:self.liushui];
        [self.tableView reloadData];
    }else if(seg.selectedSegmentIndex == 1){

        [self.dateStat removeAllObjects];
        [self.dateStat addObjectsFromArray:self.Topliushui];
        [self.tableView reloadData];
    }
    
}
@end
