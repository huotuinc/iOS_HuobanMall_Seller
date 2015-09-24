//
//  HTUser.h
//  HuoBanMall
//
//  Created by lhb on 15/8/31.
//  Copyright (c) 2015年 HT. All rights reserved.
//  用户信息

#import <Foundation/Foundation.h>

@interface HTUser : NSObject

/**登入权限*/
@property(nonatomic,strong) NSString * authority;
/**店铺描述*/
@property(nonatomic,strong) NSString * discription;
/**订单支付通知*/
@property(nonatomic,strong) NSNumber * enableBillNotice;
/**新增小伙伴通知*/
@property(nonatomic,strong) NSNumber * enablePartnerNotice;
/**店铺logo*/
@property(nonatomic,strong) NSString * logo;
/**手机号*/
@property(nonatomic,strong) NSString * mobile;
/**登录名*/
@property(nonatomic,strong) NSString * name;
/**用户昵称*/
@property(nonatomic,strong) NSString * nickName;
/**夜间免打老*/
@property(nonatomic,strong) NSNumber * noDisturbed;
/**是否是操作员**/
@property(nonatomic,strong) NSNumber *operatored;
/**登入验证token*/
@property(nonatomic,strong) NSString * token;
/**店铺名称**/
@property(nonatomic,strong) NSString * title;
/**欢迎语*/
@property(nonatomic,strong) NSString * welcomeTip;
/**首页url*/
@property(nonatomic,strong) NSString *indexUrl;

@end
