//
//  OrderManagerDetailsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//  订单管理详情

#import "OrderManagerDetailsController.h"
#import "HTOrderDetail.h"
#import "HTOrderDetailModel.h"
#import "OrdorCell.h"
#import "HeadView.h"
#import "FootView.h"
#import "HTXQFLCell.h"
#import "UserLoginTool.h"

@interface OrderManagerDetailsController ()


@property(nonatomic,strong) NSArray * logisticsDetail;
@end

@implementation OrderManagerDetailsController


- (NSArray *)logisticsDetail{
    
    if (_logisticsDetail == nil) {
        
        
        _logisticsDetail = [NSArray array];
        
        
    }
    return _logisticsDetail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单管理详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"OrdorCell" bundle:nil]   forCellReuseIdentifier:@"OrdorCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTXQFLCell" bundle:nil] forCellReuseIdentifier:@"HTXQFLCell"];
    
    
    //获取物流详细信息
    [self toGetMaterialDetailData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}



- (void)toGetMaterialDetailData{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"orderNo"] = @"665d1d4e-4f49-4586-acae-e7a49618af17";
    [UserLoginTool loginRequestGet:@"orderDetail" parame:dict success:^(NSDictionary * json) {
        NSLog(@"xx  orderDetail  %@",json);
    } failure:^(NSError *error) {
        NSLog(@"ss  orderDetail%@",error.description);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }else if (section == 2){
       return 1;
    }else if(section == 3){
        return 1;
    }else{
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 2) {
        OrdorCell * ord = [[[NSBundle mainBundle] loadNibNamed:@"OrdorCell" owner:nil options:nil] lastObject];
        ord.bgView.backgroundColor = [UIColor clearColor];
        ord.userInteractionEnabled = NO;
        return ord;
    }else if (indexPath.section == 0||indexPath.section == 1||indexPath.section == 3){
        HTOrderDetail * cell = [HTOrderDetail cellWithTableView:tableView WithIndex:indexPath];
        HTOrderDetailModel * model = [[HTOrderDetailModel alloc] init];
        cell.model = model;
        return cell;
        
    }else{
        
        HTXQFLCell * fanli = [[[NSBundle mainBundle] loadNibNamed:@"HTXQFLCell" owner:nil options:nil] lastObject];
        fanli.userInteractionEnabled = NO;
        return fanli;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        HeadView * headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil] lastObject];
        return headView;
    }else if(section == 0 ||section == 1||section == 3){
        
        return nil;
    }else{
        
        UIView * head = [[UIView alloc] init];
        head.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
        head.backgroundColor = [UIColor whiteColor];
        UILabel * nameLable = [[UILabel alloc] init];
        if (section == 4) {
            nameLable.text = @"购买人返利积分";
        }else if (section == 5){
            nameLable.text = @"上线返利积分";
        }else if (section == 6){
            nameLable.text = @"上上线返利积分";
        }else if (section == 7){
            nameLable.text = @"上上上线返利积分";
        }
        nameLable.textColor = [UIColor colorWithRed:1.000 green:0.294 blue:0.145 alpha:1.000];
        nameLable.frame = head.frame;
        [head addSubview:nameLable];
        return head;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        FootView * footView = [[[NSBundle mainBundle] loadNibNamed:@"FootView" owner:nil options:nil] lastObject];
//        footView.backgroundColor = [UIColor redColor];
        return footView;
        
    }
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 35;
    }else if (indexPath.section == 1) {
        return 40;
    }else if (indexPath.section == 2) {
        return 83;
    }else if (indexPath.section == 3) {
        return 44;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else if (section == 2) {
        return 30;
    }else if(section == 3){
        return 5;
    }
    return 30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        return 40;
    }
    return 0;
}


@end
