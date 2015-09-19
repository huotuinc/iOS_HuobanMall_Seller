//
//  HTTopTenGoodCell.h
//  HuoBanMall
//
//  Created by lhb on 15/9/18.
//  Copyright (c) 2015年 HT. All rights reserved.
//  商品前十展示cell

#import <UIKit/UIKit.h>
@class HTStatisticsModel;
@interface HTTopTenGoodCell : UITableViewCell

+ (HTTopTenGoodCell *)cellWithTableView:(UITableView *)tablew cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic,strong)UIImageView * topImageView;
@property(nonatomic,strong) HTStatisticsModel * model;

@end
