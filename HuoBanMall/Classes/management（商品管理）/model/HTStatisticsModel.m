//
//  HTStatisticsModel.m
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//  统计的模型数据

#import "HTStatisticsModel.h"

@implementation HTStatisticsModel

- (void)setOrderNo:(NSString *)orderNo{
    
    _orderNo = [NSString stringWithFormat:@"订单号:%@",orderNo];
    
}

@end
