//
//  HTWuliuModel.h
//  HuoBanMall
//
//  Created by lhb on 15/9/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTWuliuModel : NSObject

/**规格数据*/
@property(nonatomic,strong) NSArray * list;
/**运单编号*/
@property(nonatomic,strong) NSString * no;
/**物流(快递)图片*/
@property(nonatomic,strong) NSString * pictureURL;
/**信息*/
@property(nonatomic,strong) NSString * source;
/**物流状态*/
@property(nonatomic,strong) NSString * status;
/**物流跟踪*/
@property(nonatomic,strong) NSArray * track;

@end
