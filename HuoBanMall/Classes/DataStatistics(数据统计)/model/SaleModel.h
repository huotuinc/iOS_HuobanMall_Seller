//
//  SaleModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/17.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleModel : NSObject


/**
 *  定点总量
 */
@property (nonatomic, strong) NSNumber *totalAmount;

/**
 *  今日总量
 */
@property (nonatomic, strong) NSNumber *todayAmount;

/**
 *  本周总量
 */
@property (nonatomic, strong) NSNumber *weekAmount;

/**
 *  本月总量
 */
@property (nonatomic, strong) NSNumber *monthAmount;

/**
 *  今日时间数据
 */
@property (nonatomic, strong) NSArray *todayTimes;

/**
 *  今日数量数据
 */
@property (nonatomic, strong) NSArray *todayAmounts;

/**
 *  本周时间数据
 */
@property (nonatomic, strong) NSArray *weekTimes;

/**
 *  本周数量数据
 */
@property (nonatomic, strong) NSArray *weekAmounts;

/**
 *  本月时间数据
 */
@property (nonatomic, strong) NSArray *monthTimes;

/**
 *  本月数量数据
 */
@property (nonatomic, strong) NSArray *monthAmounts;

@end
