//
//  ManagementModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagementModel : NSObject

/**
 *  图片url
 */
@property (nonatomic, strong) NSString *pictureUrl;

/**
 *  价格
 */
@property (nonatomic, strong) NSNumber *price;

/**
 *  库存
 */
@property (nonatomic, strong) NSNumber *stock;

/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;

/**
 *  商品id
 */
@property (nonatomic, strong) NSNumber *goodsId;

@end
