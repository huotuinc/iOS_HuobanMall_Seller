//
//  HTOrderDetailModel.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTOrderDetailModel.h"
#import "GoodModel.h"
#import "HTJiFenModel.h"
@implementation HTOrderDetailModel : NSObject 

- (NSDictionary *)objectClassInArray
{
    return @{@"scoreList":[HTJiFenModel class],@"list":[GoodModel class]};
}

@end
