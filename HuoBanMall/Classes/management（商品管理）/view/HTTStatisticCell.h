//
//  HTTStatisticCell.h
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HTStatisticsModel;
@interface HTTStatisticCell : UITableViewCell

+ (HTTStatisticCell *)cellWithTableView:(UITableView *)tablew;
@property(nonatomic,strong) HTStatisticsModel * model;
@end
