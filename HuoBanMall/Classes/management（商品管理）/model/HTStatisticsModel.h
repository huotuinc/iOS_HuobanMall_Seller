//
//  HTStatisticsModel.h
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//  用户返利统计统计的模型数据

#import <Foundation/Foundation.h>

@interface HTStatisticsModel : NSObject

/**
 *  1、返利统计
 *  2、消费统计
 *  3、销售明细
 */

@property(nonatomic,assign) int Type;
@property(nonatomic,strong) NSNumber * score;
@property(nonatomic,strong) NSNumber * money;
@property(nonatomic,strong) NSString * pictureUrl;
@property(nonatomic,strong) NSString * orderNo;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,assign)long long time;
@property(nonatomic,assign) int pid;

/**统计单数*/
@property(nonatomic,strong)NSNumber * amount;

/**统计单数  1--单  2--件*/
@property(nonatomic,assign)int amountDW;

@end
