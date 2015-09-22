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
@end
