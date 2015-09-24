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
//    self.tableView.userInteractionEnabled = NO;
//    self.tableView.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)toGetMaterialDetailData{
     
     __weak HTCheckLogisticsController *wself = self;
     NSMutableDictionary * dict = [NSMutableDictionary dictionary];
     dict[@"orderNo"] = @"665d1d4e-4f49-4586-acae-e7a49618af17";
     [UserLoginTool loginRequestGet:@"logisticsDetail" parame:dict success:^(NSDictionary * json){
         if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
               
               wself.dateModel = [HTWuliuModel objectWithKeyValues:json[@"resultData"][@"data"]];
               [wself.tableView reloadData];

          }
         
     } failure:^(NSError *error) {
          NSLog(@"ss  orderDetail%@",error.description);
     }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, self.tableView.frame.size.width, 20)];
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
