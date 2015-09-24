//
//  OrdorModel.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodModel.h"

@interface OrdorModel : NSObject

/**订单商品总数量*/
@property (nonatomic, strong) NSNumber *amount;
/**规格数据*/
@property (nonatomic, strong) NSArray *list;
/**订单号*/
@property (nonatomic, strong) NSString *orderNo;
/**实付金额*/
@property (nonatomic, strong) NSNumber *paid;
/**订单状态*/
@property (nonatomic, strong) NSNumber *status;
/**下单时间*/
@property (nonatomic, strong) NSNumber *time;


@end
