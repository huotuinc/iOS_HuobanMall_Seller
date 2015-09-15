//
//  HTOrderDetailModel.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTOrderDetailModel.h"

@implementation HTOrderDetailModel


- (instancetype)init{
    
    if (self = [super init]) {
        self.buyName = @"小明";
        self.place = @"杭州市滨江区";
        self.phoneNumber  = @"13857560740";
    }
    return self;
}
@end
