/**
*  HTOrderDetailModel.h
*  HuoBanMall
*
*  Created by lhb on 15/9/15.
*  Copyright (c) 2015年 HT. All rights reserved.
*/

#import <Foundation/Foundation.h>

@interface HTOrderDetailModel : NSObject

/**地址*/
@property(nonatomic,strong) NSString * 	address;
/**商品数量*/
@property(nonatomic,strong) NSNumber * amount;
/**购买人*/
@property(nonatomic,strong) NSString * 	buyer;
/**联系方式*/
@property(nonatomic,strong) NSString * 	contact;
/**规格数据*/
@property(nonatomic,strong)NSArray * list;
/**订单号*/
@property(nonatomic,strong) NSString * 	orderNo;
/**实付金额*/
@property(nonatomic,strong) NSNumber * paid;
/**收货人*/
@property(nonatomic,strong) NSString * 	receiver;
/**返利积分*/
@property(nonatomic,strong)NSArray *scoreList;

@end
