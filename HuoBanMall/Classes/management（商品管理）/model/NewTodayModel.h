//
//  NewTodayModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/14.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTodayModel : NSObject

/**会员时间段值数组**/
@property (nonatomic, strong) NSArray *memberAmount;
/**会员时间段数组**/
@property (nonatomic, strong) NSArray *memberHour;

/**订单时间段值数组**/
@property (nonatomic, strong) NSArray *orderAmount;
/**订单时间段数组**/
@property (nonatomic, strong) NSArray *orderHour;

/**小伙伴时间段值数组**/
@property (nonatomic, strong) NSArray *partnerAmount;
/**小伙伴时间段数组**/
@property (nonatomic, strong) NSArray *partnerHour;

/**今日会员**/
@property (nonatomic, strong) NSNumber *todayMemberAmount;
/**今日订单**/
@property (nonatomic, strong) NSNumber *todayOrderAmount;
/**今日小伙伴**/
@property (nonatomic, strong) NSNumber *todayPartnerAmount;

/**今日销售额**/
@property (nonatomic, strong) NSNumber *todaySales;
/**总销售额**/
@property (nonatomic, strong) NSNumber *totalSales;


@end
