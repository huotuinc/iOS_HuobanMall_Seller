//
//  ManagementController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ManagementController.h"

@interface ManagementController ()

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView



@end
