//
//  HTJiFenModel.h
//  HuoBanMall
//
//  Created by lhb on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTJiFenModel : NSObject

@property(nonatomic,assign)long long getTime;
//获得积分时间
@property(nonatomic,strong) NSString *	present;
//目前的状态
@property(nonatomic,assign)long long regularization;
//积分转正时间
@property(nonatomic,strong) NSNumber *	score;
//获得的积分
@property(nonatomic,strong) NSString *	userName;
//显示的用户名
@property(nonatomic,strong) NSString *	userType;
//显示的用户名
@end
