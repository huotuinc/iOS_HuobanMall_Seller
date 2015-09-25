//
//  HTOrderDetail.h
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//   订单管理详情cell

#import <UIKit/UIKit.h>
@class HTOrderDetailModel;
@interface HTOrderDetail : UITableViewCell
/**联系人号码*/
@property(nonatomic,strong) UILabel * contactPhoneNumberLable;


+ (instancetype)cellWithTableView:(UITableView*)tableview WithIndex:(NSIndexPath *)index;

@property(nonatomic,strong)HTOrderDetailModel * model;

@end
