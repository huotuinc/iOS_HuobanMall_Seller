//
//  HTStatisticsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//  3个统计页面

#import "HTStatisticsController.h"
#import "HTTStatisticCell.h"

@interface HTStatisticsController ()

@end

@implementation HTStatisticsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化一些
    [self setup];
    
    [self xx];
    self.tableView.tableFooterView = [[UIView alloc] init];
 }


- (void)SegmentedControlValueChange:(UISegmentedControl *) seg{
    
    NSLog(@"%ld",(long)seg.selectedSegmentIndex);
    
    
}
- (void)setup{
    
    UISegmentedControl * aa = [[UISegmentedControl alloc] initWithItems:@[@"明细",@"top"]];
    aa.frame =  CGRectMake(0, 0, 120, 30);
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTTStatisticCell * cell = [HTTStatisticCell cellWithTableView:tableView];
    cell.model = nil;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


///**
// *  集成刷新控件
// */
//- (void)setupRefresh
//{
//    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    //#warning 自动刷新(一进入程序就下拉刷新)
//    [self.tableView headerBeginRefreshing];
//    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
//    
//    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    
//    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.tableView.footerRefreshingText = @"正在加载更多数据,请稍等";
//    
//}
//
//
//
////头部刷新
//- (void)headerRereshing  //加载最新数据
//{
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"pagingTag"] = @"";
//    params[@"pagingSize"] = @(pageSize);
//    [self getNewMoreData:params];
//    // 2.(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//    [self.tableView headerEndRefreshing];
//}
//
////尾部刷新
//- (void)footerRereshing{  //加载更多数据数据
//    
//    TaskGrouoModel * bbbs = [self.taskGroup lastObject];
//    taskData * task = [bbbs.tasks lastObject];
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    params[@"pagingTag"] =[NSString stringWithFormat:@"%lld",task.taskOrder];
//    //    NSLog(@"尾部刷新%ld",task.taskOrder);
//    params[@"pagingSize"] = @(pageSize);
//    [self getMoreData:params];
//    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//    [self.tableView footerEndRefreshing];
//}
//
///**
// *   上拉加载更多
// *
// *
// */
//- (void)getMoreData:(NSMutableDictionary *) params{
//    NSString * usrStr = [MainURL stringByAppendingPathComponent:@"taskList"];
//    
//    //    [MBProgressHUD showMessage:nil];
//    __weak HomeViewController *wself = self;
//    [UserLoginTool loginRequestGet:usrStr parame:params success:^(id json) {
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==56001){
//            [[NSUserDefaults standardUserDefaults] setObject:@"wrong" forKey:loginFlag];
//            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:AppToken];
//            
//            UIAlertView * aaa = [[UIAlertView alloc] initWithTitle:@"账号提示" message:@"当前账号被登录，是否重新登录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            aaa.tag = 1;
//            [aaa show];
//            return ;
//        }
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {//访问成果
//            NSArray * taskArray = [taskData objectArrayWithKeyValuesArray:json[@"resultData"][@"task"]];
//            if (taskArray.count > 0) {
//                [wself toGroupsByTime:taskArray];  //分组
//                [wself.tableView reloadData];    //刷新数据
//            }
//            
//        }
//        
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"粉猫服务器连接异常"];
//    }];
//    
//}
///**
// *  下拉加载更新数据
// */
//-(void)getNewMoreData:(NSMutableDictionary *)params{
//    
//    NSString * usrStr = [MainURL stringByAppendingPathComponent:@"taskList"];
//    __weak HomeViewController *wself = self;
//    if (IsIos8) {
//        [MBProgressHUD showMessage:nil];
//    }
//    [UserLoginTool loginRequestGet:usrStr parame:params success:^(id json) {
//        [MBProgressHUD hideHUD];
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==56001){
//            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:AppToken];
//            [[NSUserDefaults standardUserDefaults] setObject:@"wrong" forKey:loginFlag];
//            UIAlertView * aaa = [[UIAlertView alloc] initWithTitle:@"账号提示" message:@"当前账号被登录，是否重新登录?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//            [aaa show];
//            return ;
//        }
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==56000){
//            [MBProgressHUD showSuccess:json[@"resultDescription"]];
//            [self.taskDatas removeAllObjects];
//            
//            return ;
//        }
//        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue]==1) {//访问成果
//            [MBProgressHUD hideHUD];
//            NSArray * taskArray = [taskData objectArrayWithKeyValuesArray:json[@"resultData"][@"task"]];
//            [wself.taskGroup removeAllObjects];
//            
//            [wself toGroupWithTopTask:taskArray];
//            refreshCount = (int)[taskArray count];
//            //            [wself showHomeRefershCount];
//            if (taskArray.count > 0) {
//                [self setWiteBackground];
//            }else {
//                [self setWiteBackground];
//            }
//            [MBProgressHUD hideHUD];
//            [wself.tableView reloadData];    //刷新数据
//        }
//        
//        [MBProgressHUD hideHUD];
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showError:@"粉猫服务器连接异常"];
//        
//    }];
//    
//}

- (void)xx{
    
    NSDate * ptime = [[NSDate alloc] init];;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    NSString * publishtime = [formatter stringFromDate:ptime];
    NSLog(@"%@",publishtime);
}

@end
