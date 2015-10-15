//
//  HTTopTenGoodsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/18.
//  Copyright (c) 2015年 HT. All rights reserved.
//  销售排名前十

#import "HTTopTenGoodsController.h"
#import "HTTopTenGoodCell.h"
#import "HTTopTenModel.h"
#import "MJRefresh.h"
@interface HTTopTenGoodsController ()


@property(nonatomic,strong)NSMutableArray *datasArray;
@end

@implementation HTTopTenGoodsController



- (NSMutableArray *)datasArray{
    if (_datasArray == nil) {
        
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品销量前十";
    [self toGetTopTenSaller];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTTopTenGoodCell" bundle:nil] forCellReuseIdentifier:@"HTTopTenGoodCellId"];
    //集成涮新空间
    [self setupRefresh];
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
    
}

//头部刷新
- (void)headerRereshing  //加载最新数据
{
    [self toGetTopTenSaller];
    // 2.(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

- (void)toGetTopTenSaller{
    
    [UserLoginTool loginRequestGet:@"topGoods" parame:nil success:^(id json) {
        NSLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            
            NSArray * models = [HTTopTenModel objectArrayWithKeyValuesArray:json[@"resultData"][@"list"]];
            if (models.count>0) {
                [self.datasArray removeAllObjects];
                [self.datasArray addObjectsFromArray:models];
                [self.tableView reloadData];
            }
        }
        if (self.datasArray.count == 0) {
            [self.tableView setTabelViewListIsZero];
        }else {
            [self.tableView setTableViewNormal];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.datasArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTTopTenGoodCell * cell = [HTTopTenGoodCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
    //排名
    cell.numLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    HTTopTenModel * model = self.datasArray[indexPath.row];
    cell.model = model;
    return cell;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}


@end
