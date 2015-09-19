//
//  HTTopTenGoodsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/18.
//  Copyright (c) 2015年 HT. All rights reserved.
//  销售排名前十

#import "HTTopTenGoodsController.h"
#import "HTTopTenGoodCell.h"
@interface HTTopTenGoodsController ()

@end

@implementation HTTopTenGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品销量前十";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTTopTenGoodCell * cell = [HTTopTenGoodCell cellWithTableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = nil;
    return cell;
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}


@end
