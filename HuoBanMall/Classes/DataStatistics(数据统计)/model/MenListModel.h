//
//  MenListModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/19.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenListModel : NSObject

@property (nonatomic, strong) NSNumber *monthMemberAmount;

@property (nonatomic, strong) NSArray *monthMemberAmounts;

@property (nonatomic, strong) NSNumber *monthPartnerAmount;

@property (nonatomic, strong) NSArray *monthPartnerAmounts;

@property (nonatomic, strong) NSArray *monthTimes;

@property (nonatomic, strong) NSNumber *todayMemberAmount;

@property (nonatomic, strong) NSArray *todayMemberAmounts;

@property (nonatomic, strong) NSNumber *todayPartnerAmount;

@property (nonatomic, strong) NSArray *todayPartnerAmounts;

@property (nonatomic, strong) NSArray *todayTimes;

@property (nonatomic, strong) NSNumber *totalMember;

@property (nonatomic, strong) NSNumber *totalPartner;

@property (nonatomic, strong) NSNumber *weekMemberAmount;

@property (nonatomic, strong) NSArray *weekMemberAmounts;

@property (nonatomic, strong) NSNumber *weekPartnerAmount;

@property (nonatomic ,strong) NSArray *weekPartnerAmounts;

@property (nonatomic, strong) NSArray *weekTimes;

@end
