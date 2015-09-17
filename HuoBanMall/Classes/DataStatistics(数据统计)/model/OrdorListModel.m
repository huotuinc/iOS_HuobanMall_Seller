//
//  OrdorListModel.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "OrdorListModel.h"

@implementation OrdorListModel

- (NSDictionary *)objectClassInArray
{
    return @{@"todayTimes":[NSNumber class],@"todayAmounts":[NSNumber class],@"weekTimes":[NSNumber class],@"weekAmounts":[NSNumber class],@"monthTimes":[NSNumber class],@"monthAmounts":[NSNumber class]};
}


@end
