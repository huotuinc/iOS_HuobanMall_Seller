//
//  HTWuLiuStatus.h
//  HuoBanMall
//
//  Created by lhb on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTWuLiuStatus : NSObject


/**对应行政区域的编码*/
@property(nonatomic,strong) NSString * 	areacode;

/**对应行政区域的名称*/
@property(nonatomic,strong) NSString * 	areaname;

/**快递公司编码*/
@property(nonatomic,strong) NSString * 	code;

/**快递公司*/
@property(nonatomic,strong) NSString * 	company;

/**动态内容*/
@property(nonatomic,strong) NSString * 	context;

/**快递单号*/
@property(nonatomic,strong) NSString * 	number;

/**快递状态*/
@property(nonatomic,strong) NSString * 	status;

/**动态更新时间*/
@property(nonatomic,strong) NSString * 	times;

@end
