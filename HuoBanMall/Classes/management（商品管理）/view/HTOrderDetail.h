//
//  HTOrderDetail.h
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTOrderDetailModel;
@interface HTOrderDetail : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView*)tableview WithIndex:(NSIndexPath *)index;

@property(nonatomic,strong)HTOrderDetailModel * model;

@end
