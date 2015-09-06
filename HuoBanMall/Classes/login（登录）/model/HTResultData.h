//
//  HTResultData.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/6.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTUser.h"
#import "HTGlobal.h"
#import "HTupData.h"

@interface HTResultData : NSObject

/**
 *  公共信息
 */
@property (nonatomic, strong) HTGlobal *global;

@property (nonatomic, strong) HTUser *user;

@property (nonatomic, strong) HTupData *updata;

@end
