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
    
    [self setup];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setup{
    
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

@end
