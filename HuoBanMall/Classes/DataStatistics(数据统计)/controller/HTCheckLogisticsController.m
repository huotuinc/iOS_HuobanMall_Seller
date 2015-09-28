//
//  HTCheckLogisticsController.m
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//  查看物流

#import "HTCheckLogisticsController.h"
#import "ExpressCompany.h"
#import "NewOrdorCell.h"
#import "HTWuliuModel.h"
#import "GoodModel.h"
#import "HTWuLiuStatus.h"
#import "MJRefresh.h"
@interface HTCheckLogisticsController ()

@property(nonatomic,strong) HTWuliuModel * dateModel;

@end

@implementation HTCheckLogisticsController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流查看";
    
     [self.tableView registerNib:[UINib nibWithNibName:@"ExpressCompany" bundle:nil]   forCellReuseIdentifier:@"aa"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewOrdorCell" bundle:nil]   forCellReuseIdentifier:@"bb"];
    
     //获取物流详情
     [self toGetMaterialDetailData];
     
     [self setupRefresh];
//    self.tableView.userInteractionEnabled = NO;
//    self.tableView.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (void)toGetMaterialDetailData{
     
     __weak HTCheckLogisticsController *wself = self;
     NSMutableDictionary * dict = [NSMutableDictionary dictionary];
     dict[@"orderNo"] = self.ordorNumber;
     [SVProgressHUD showWithStatus:@"数据加载中"];
     [UserLoginTool loginRequestGet:@"logisticsDetail" parame:dict success:^(NSDictionary * json){
          [SVProgressHUD dismiss];
          if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
               
               wself.dateModel = [HTWuliuModel objectWithKeyValues:json[@"resultData"][@"data"]];
               [wself.tableView reloadData];

          }
         
     } failure:^(NSError *error) {
          [SVProgressHUD dismiss];
          NSLog(@"ss  orderDetail%@",error.description);
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     if (self.dateModel.list>0) {
          return 3;
     }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if(section ==1){
         
         return self.dateModel.list.count;
    }
    else{
       return 4;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ExpressCompany * aa = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (aa == nil) {
            
            aa = [[ExpressCompany alloc] init];
            aa.userInteractionEnabled = NO;
            
        }
        [aa setDateWithStatus:self.dateModel.status withCompany:self.dateModel.source withOderNumber:self.dateModel.no withIconUrl:self.dateModel.pictureURL];
        aa.userInteractionEnabled = NO;
        return aa;
    }else if (indexPath.section == 1){
        
        NewOrdorCell * bb = [tableView dequeueReusableCellWithIdentifier:@"bb"];
        if (bb== nil) {
            
            bb = [[NewOrdorCell alloc] init];
                     }
         
         GoodModel * aamodel = self.dateModel.list[indexPath.row];
        [bb setDate:aamodel.title withPrice:[aamodel.money stringValue] WithBuyNum:[aamodel.amount stringValue] withDesc:aamodel.spec withIconUrl:aamodel.pictureUrl];
        bb.userInteractionEnabled = NO;

        return bb;
    }else{
        
        static NSString * Id = @"xxxxxxx";
        UITableViewCell * cc = [tableView dequeueReusableCellWithIdentifier:Id];
        if (cc == nil) {
            
            cc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
            cc.textLabel.numberOfLines = 0;
             cc.textLabel.font = [UIFont systemFontOfSize:13];
            
           
        }
        if(indexPath.row == 0){
            
            cc.imageView.image = [UIImage imageNamed:@"green"];
//            cc.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }else if(indexPath.row == 3){
            
            cc.imageView.image = [UIImage imageNamed:@"gray-2"];
        }else{
            cc.imageView.image = [UIImage imageNamed:@"gray"];
        }
         
         HTWuLiuStatus * status = self.dateModel.track[indexPath.row];
     
        cc.textLabel.text = status.context;
        cc.detailTextLabel.text = status.times;
        cc.userInteractionEnabled = NO;

        return cc;
    }
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return [self myselfSectionHeadViewWithTitle:@"物品信息"];
    }else if(section == 2) {
        
        return [self myselfSectionHeadViewWithTitle:@"查看物流"];
    }
    return nil;
}
- (UIView *)myselfSectionHeadViewWithTitle:(NSString *)title{
    
    UIView * vi = [[UIView alloc] init];
    vi.backgroundColor = [UIColor blackColor];
    vi.bounds = CGRectMake(10, 0,self.tableView.frame.size.width, 60);
    vi.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, self.tableView.frame.size.width, 20)];
    label.font = [UIFont systemFontOfSize:16.0f];  //UILabel的字体大小
    label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
    label.textColor = [UIColor colorWithRed:70/255.0 green:72/255.0 blue:76/255.0 alpha:1.000];
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = title;
    [vi addSubview:label];
    return vi;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (section == 1) {
        return 30;
    }else if (section == 2){
        return 30;
    }
    return 2 ;
    
}


#pragma mark - Navigation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
     if (indexPath.section == 0) {
          return 80;
     }else if (indexPath.section == 2){
          return 60;
     }
    return 80;
 
 }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return @"物品信息";
    }
    return nil;
}
@end
