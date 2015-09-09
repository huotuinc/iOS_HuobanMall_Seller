//
//  MoreDataViewController.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/7.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreDataViewController : UIViewController
/**
 *  订单统计
 */
@property (weak, nonatomic) IBOutlet UIView *ordorView;

/**
 *  订单数量
 */
@property (weak, nonatomic) IBOutlet UILabel *ordorLabel;

/**
 *  分销商图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *distributorImage;

/**
 *  分销商数字
 */
@property (weak, nonatomic) IBOutlet UILabel *distributorLabel;

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;

/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *goodLabel;

/**
 *  会员图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *memberImage;

/**
 *  会员数量
 */
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;

/**
 *  销售额统计
 */
@property (weak, nonatomic) IBOutlet UIImageView *saleImage;

/**
 *  销售明细
 */
@property (weak, nonatomic) IBOutlet UIImageView *marketImage;

/**
 *  返利积分图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *rebateImage;

/**
 *  消费统计
 */
@property (weak, nonatomic) IBOutlet UIImageView *expenseImage;


@end
