//
//  HTXiaoShouModel.h
//  HuoBanMall
//
//  Created by lhb on 15/9/23.
//  Copyright (c) 2015年 HT. All rights reserved.
//  销售明显模型

#import <Foundation/Foundation.h>

@interface HTXiaoShouModel : NSObject

@property(nonatomic,assign) int Type;
@property(nonatomic,strong) NSNumber * money;
@property(nonatomic,strong) NSString * pictureUrl;

@property(nonatomic,strong) NSString * orderNo;


@property(nonatomic,assign)long long time;

@end
