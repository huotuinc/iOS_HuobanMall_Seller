//
//  ManagementController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ManagementController.h"

@interface ManagementController ()<UITableViewDelegate, UITableViewDataSource>

/**
 *  商品列表
 */
@property NSMutableArray *goods;

/**
 *  商品列表
 */
@property NSMutableArray *selectGoods;

/**
 *  表数据
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView




@end
