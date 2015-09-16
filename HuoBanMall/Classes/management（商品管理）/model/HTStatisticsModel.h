//
//  HTStatisticsModel.h
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//  统计的模型数据

#import <Foundation/Foundation.h>

@interface HTStatisticsModel : NSObject

/**
 *  1、返利统计
 *  2、消费统计
 *  3、销售明细
 */
@property(nonatomic,assign) int Type;


@property(nonatomic,strong) NSNumber * num;


@property(nonatomic,strong) NSString * iconUrl;

@property(nonatomic,strong) NSString * name;


@property(nonatomic,strong) NSString * subName;

@end
