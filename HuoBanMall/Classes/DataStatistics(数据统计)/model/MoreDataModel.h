//
//  MoreDataModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/14.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreDataModel : NSObject

/**订单总数**/
@property (nonatomic, strong) NSNumber *billAmount;
/**分销商总数**/
@property (nonatomic, strong) NSNumber *discributorAmount;
/**商品总数**/
@property (nonatomic, strong) NSNumber *goodsAmount;
/**订单总数**/
@property (nonatomic, strong) NSNumber *memberAmount;

@end
