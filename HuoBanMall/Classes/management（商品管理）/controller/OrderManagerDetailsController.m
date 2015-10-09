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
#import "HTCheckLogisticsController.h"
#import "MJRefresh.h"
#import "HTJiFenModel.h"

@interface OrderManagerDetailsController ()


@property(nonatomic,strong) NSArray * logisticsDetail;

@property(nonatomic,strong) HTOrderDetailModel * orderDetailModel;
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
    
    [self setupRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}



- (void)toGetMaterialDetailData{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"orderNo"] = self.ordorNumber;
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [UserLoginTool loginRequestGet:@"orderDetail" parame:dict success:^(NSDictionary * json) {
        NSLog(@"xx  orderDetail  %@",json);
        [SVProgressHUD dismiss];
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            
            self.orderDetailModel = [HTOrderDetailModel objectWithKeyValues:json[@"resultData"][@"data"]];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"ss  orderDetail%@",error.description);
    }];
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
    [self toGetMaterialDetailData];
    // 2.(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    NSLog(@"xxxxx%lu",(unsigned long)self.orderDetailModel.scoreList.count);
    if (self.orderDetailModel.list.count>0) {
        return 4 + self.orderDetailModel.scoreList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }else if (section == 2){
       return self.orderDetailModel.list.count;
    }else if(section == 3){
        return 1;
    }else{
        return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 2) {
        OrdorCell * ord = [[[NSBundle mainBundle] loadNibNamed:@"OrdorCell" owner:nil options:nil] lastObject];
        GoodModel * model = self.orderDetailModel.list[indexPath.row];
        ord.model = model;
        ord.bgView.backgroundColor = [UIColor clearColor];
        ord.userInteractionEnabled = NO;
        ord.backgroundColor = [UIColor whiteColor];
        return ord;
    }else if (indexPath.section == 0||indexPath.section == 1||indexPath.section == 3){
        HTOrderDetail * cell = [HTOrderDetail cellWithTableView:tableView WithIndex:indexPath];
        HTOrderDetailModel * model = self.orderDetailModel;
        cell.model = model;
        if (indexPath.section == 0) {
            cell.userInteractionEnabled = NO;
        }else{
            cell.userInteractionEnabled = YES;
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
        
    }else{
      
        if (self.orderDetailModel.scoreList.count) {
            HTXQFLCell * fanli = [[[NSBundle mainBundle] loadNibNamed:@"HTXQFLCell" owner:nil options:nil] lastObject];
            fanli.userInteractionEnabled = NO;
            HTJiFenModel * model =  self.orderDetailModel.scoreList[indexPath.section - 4];
            fanli.model = model;
            return fanli;
        }
        
    }
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        HeadView * headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:nil options:nil] lastObject];
        
        headView.ordorLabel.text = [NSString stringWithFormat:@"订单号:%@",self.orderDetailModel.orderNo];
        headView.ordorType.hidden = YES;
        NSLog(@"%@",headView.ordorLabel.text);
        return headView;
    }else if(section == 0 ||section == 1||section == 3){
        
        return nil;
    }else{
        
        if (self.orderDetailModel.scoreList.count) {
            UIView * head = [[UIView alloc] init];
            head.frame = CGRectMake(10, 0, tableView.frame.size.width, 30);
            head.backgroundColor = [UIColor whiteColor];
            UILabel * nameLable = [[UILabel alloc] init];
            if (section == 4) {
                HTJiFenModel * model =  self.orderDetailModel.scoreList[0];
                nameLable.text = model.userType;

            }else if (section == 5){
                HTJiFenModel * model =  self.orderDetailModel.scoreList[1];
                nameLable.text = model.userType;
            }else if (section == 6){
                HTJiFenModel * model =  self.orderDetailModel.scoreList[2];
                nameLable.text = model.userType;
            }else if (section == 7){
                HTJiFenModel * model =  self.orderDetailModel.scoreList[3];
                nameLable.text = model.userType;
            }
            nameLable.textColor = [UIColor colorWithRed:1.000 green:0.294 blue:0.145 alpha:1.000];
            nameLable.frame = head.frame;
            nameLable.font = [UIFont systemFontOfSize:14];
            [head addSubview:nameLable];
            return head;
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        
        FootView * footView = [[[NSBundle mainBundle] loadNibNamed:@"FootView" owner:nil options:nil] lastObject];
        footView.goodCount.text = [NSString stringWithFormat:@"共%@件商品",[self.orderDetailModel.amount stringValue]];
        footView.priceLabel.text = [self.orderDetailModel.paid stringValue];
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
        return 62;
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
    }else if (section == 3){
        return 5;
    }else if (section == 1) {
        return 20;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        
        HTOrderDetail * cell = (HTOrderDetail *)[tableView cellForRowAtIndexPath:indexPath];
        cell.contactPhoneNumberLable.text = self.orderDetailModel.contact;
        UIAlertView * aaa= [[UIAlertView alloc] initWithTitle:@"联系方式" message:[NSString stringWithFormat:@"确定要拨打%@吗?",self.orderDetailModel.contact] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aaa show];
        
    }else if(indexPath.section == 3){

        HTCheckLogisticsController * av = [[HTCheckLogisticsController alloc] initWithStyle:UITableViewStyleGrouped];
        av.ordorNumber = self.ordorNumber;;
        [self.navigationController pushViewController:av animated:YES];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //        NSLog(@"0");
    }else{ //确定
        NSString *number=self.orderDetailModel.contact;
        NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    }
}
@end
