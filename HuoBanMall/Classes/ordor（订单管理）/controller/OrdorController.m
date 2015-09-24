//
//  OrdorController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "OrdorController.h"
#import "HeadView.h"
#import "OrdorCell.h"
#import "NewFootView.h"
#import "OrderManagerDetailsController.h"
#import "HTCheckLogisticsController.h"
#import "MJRefresh.h"
#import "OrdorModel.h"
#import "GoodModel.h"

@interface OrdorController ()<UITableViewDelegate,UITableViewDataSource,NewFootViewDelegate, UISearchBarDelegate>

/**
 *  滑块视图
 */
@property (nonatomic, strong) UIView *screenView;

//订单数组
@property (nonatomic, strong) NSMutableArray *ordors;

//全部的x值
@property (nonatomic, assign) CGFloat ALLX;

//状态
@property (nonatomic, assign) NSInteger type;

/**
 *  搜索保存数据
 */
@property (nonatomic, strong) NSString *searchStr;

/**搜索栏*/
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation OrdorController

static NSString *ordorIdentifier = @"ordorCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ordors = [NSMutableArray array];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdorCell" bundle:nil] forCellReuseIdentifier:ordorIdentifier];
//    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupRefresh];
    
    [self _initScreenView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(8, 0, ScreenWidth - 10, 44)];
    [self.searchBar setBackgroundColor:NavBackgroundColor];
//    [self.searchBar setBarTintColor:[UIColor whiteColor]];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    self.searchBar.keyboardType = UIKeyboardTypeNumberPad;
    
    self.tableView.tableFooterView.userInteractionEnabled = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"ss"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        [self.navigationController.navigationBar addSubview:self.searchBar];
        
        [self.searchBar becomeFirstResponder];
        
        [self.tableView removeHeader];
        
        self.screenView.frame = CGRectMake(self.ALLX, self.screenView.frame.origin.y, self.screenView.frame.size.width, self.screenView.frame.size.height);
        
        self.type = 0;
        
    }];
    
    [self fristGetNewList];
    
}

///**
// *  集成刷新控件
// */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(getNewOrdorList)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(getMoreOrdorList)];
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载更多数据,请稍等";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  第一次进入页面的方法
 */
- (void)fristGetNewList {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    dic[@"status"] = @(self.type);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [UserLoginTool loginRequestGet:@"orderList" parame:dic success:^(id json) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@", json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            NSArray *temp = [OrdorModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.ordors addObjectsFromArray:temp];
            
            [self.tableView reloadData];
        }
        if ([json[@"resultCode"] intValue] == 56001) {
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"resultDescription"]]];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{
                [SVProgressHUD dismiss];
            }];
        }
        
    } failure:^(NSError *error) {

        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
        
    }];
    
}

- (void)getNewOrdorList {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    dic[@"status"] = @(self.type);
    

    [UserLoginTool loginRequestGet:@"orderList" parame:dic success:^(id json) {
        [self.tableView headerEndRefreshing];
        
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            [self.ordors removeAllObjects];
            
            NSArray *temp = [OrdorModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.ordors addObjectsFromArray:temp];
        
//            [self.tableView reloadData];
        }
        if ([json[@"resultCode"] intValue] == 56001) {
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"resultDescription"]]];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
        
    } failure:^(NSError *error) {
        
        [self.tableView headerEndRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
        
    }];
}

- (void)getMoreOrdorList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    OrdorModel *model = [self.ordors lastObject];

    dic[@"status"] = @(self.type);
    dic[@"lastDate"] = model.time;
    [UserLoginTool loginRequestGet:@"orderList" parame:dic success:^(id json) {
        NSLog(@"%@", json);
        [self.tableView footerEndRefreshing];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            
            NSArray *temp = [OrdorModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            
            [self.ordors addObjectsFromArray:temp];
            
        }
        if ([json[@"resultCode"] intValue] == 56001) {
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"resultDescription"]]];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
    }];
    
}


- (void)_initScreenView {
    
    [self.bgView layoutIfNeeded];
    [self.allView layoutIfNeeded];
    [self.obligationView layoutIfNeeded];
    [self.waitView layoutIfNeeded];
    [self.finishView layoutIfNeeded];
    
    self.type = 0;
    
    CGFloat SVW = ScreenWidth * 0.1;
    CGFloat SIY = (ScreenHeight - 64) * 0.08 - 2;
    
    self.ALLX = (self.allView.frame.size.width - SVW) / 2 + self.allView.frame.origin.x;
    CGFloat OBX = (self.obligationView.frame.size.width - SVW) / 2 + self.obligationView.frame.origin.x;
    CGFloat WTX = (self.waitView.frame.size.width - SVW) / 2 + self.waitView.frame.origin.x;
    CGFloat FIX = (self.finishView.frame.size.width - SVW) / 2 + self.finishView.frame.origin.x;
    
    
    self.screenView = [[UIView alloc] initWithFrame:CGRectMake(self.ALLX, SIY, SVW, 2)];
    self.screenView.backgroundColor = NavBackgroundColor;
    
    [self.bgView addSubview:self.screenView];
    
    
    [self.allView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != self.ALLX) {
            
            self.type = 0;
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.allLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(self.ALLX, SIY, SVW, 2);
            }];
            [self getNewOrdorList];
        }
    }];
    
    [self.obligationView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != OBX) {
            
            self.type = 1;
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.obligationLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(OBX, SIY, SVW, 2);
            }];
            [self getNewOrdorList];
        }
    }];
    
    [self.waitView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != WTX) {
            
            self.type = 2;
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.waitLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(WTX, SIY, SVW, 2);
            }];
            [self getNewOrdorList];
        }
    }];
    
    [self.finishView bk_whenTapped:^{
        if (self.screenView.frame.origin.x != FIX) {
            
            self.type = 3;
            [UIView animateWithDuration:0.35 animations:^{
                [self setLabelsColorBlack];
                self.finishLabel.textColor = NavBackgroundColor;
                self.screenView.frame = CGRectMake(FIX, SIY, SVW, 2);
            }];
            [self getNewOrdorList];
        }
    }];
    
    
    
}


- (void)setLabelsColorBlack {
    self.allLabel.textColor = [UIColor blackColor];
    self.obligationLabel.textColor = [UIColor blackColor];
    self.waitLabel.textColor = [UIColor blackColor];
    self.finishLabel.textColor = [UIColor blackColor];
}



#pragma mark －tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ordors.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrdorModel *model = self.ordors[section];
    
    return model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *head = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil] lastObject];
    
    head.model = self.ordors[section];
    
    return head;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NewFootView *foot = [[[NSBundle mainBundle] loadNibNamed:@"NewFootView" owner:nil options:nil] lastObject];
    foot.delegate = self;
    
    foot.model = self.ordors[section];
    
    return foot;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrdorCell *cell = [tableView dequeueReusableCellWithIdentifier:ordorIdentifier forIndexPath:indexPath];
    
    OrdorModel *ordorModel = self.ordors[indexPath.section];
    
    cell.model = ordorModel.list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderManagerDetailsController *man = [[OrderManagerDetailsController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:man animated:YES];
}


- (void)NewFootViewCheckMaterialWith:(NewFootView *)newfootView{
    
    HTCheckLogisticsController * vc = [[HTCheckLogisticsController alloc] initWithStyle:UITableViewStyleGrouped];
    
    vc.ordorNumber = newfootView.model.orderNo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark searchbar

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    
    [self.searchBar removeFromSuperview];
    
    [self.tableView addHeaderWithTarget:self action:@selector(getNewOrdorList)];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length < 6) {
        [SVProgressHUD showWithStatus:@"请输入至少6位订单号"];
    }else {
#warning 搜索网络请求
    }
}


@end
