//
//  HTToJudgeLoginFlag.m
//  HuoBanMall
//
//  Created by lhb on 15/9/7.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTToJudgeLoginFlag.h"
#import "HTUser.h"

@implementation HTToJudgeLoginFlag


+ (BOOL)ToJudgeLoginFlag{
    //1、登入成功用户数据本地化
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
    HTUser * localUser = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:HuoBanMallAppToken];
    return [token isEqualToString:localUser.token];
}

@end
