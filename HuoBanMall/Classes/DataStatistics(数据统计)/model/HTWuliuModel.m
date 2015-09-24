//
//  HTWuliuModel.m
//  HuoBanMall
//
//  Created by lhb on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTWuliuModel.h"
#import "HTWuLiuStatus.h"
#import "GoodModel.h"
#import "HTWuLiuStatus.h"

@implementation HTWuliuModel


- (NSDictionary *)objectClassInArray
{
    return @{@"track":[HTWuLiuStatus class],@"list":[GoodModel class]};
}


@end
