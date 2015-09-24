//
//  GoodModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject

/**商品数量*/
@property (nonatomic, strong) NSNumber *amount;
/**付款金额*/
@property (nonatomic, strong) NSNumber *money;
/**图片地址*/
@property (nonatomic, strong) NSString *pictureUrl;
/**规格说明*/
@property (nonatomic, strong) NSString *spec;
/**名称*/
@property (nonatomic, strong) NSString *title;


@end
