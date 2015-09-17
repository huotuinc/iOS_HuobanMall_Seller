//
//  NewFootView.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFootView : UIView

/**
 *  返回积分
 */
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

/**
 *  查看物流
 */
@property (weak, nonatomic) IBOutlet UIButton *logisticsButton;

/**
 *  商品个数
 */
@property (weak, nonatomic) IBOutlet UILabel *goodCount;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)getLogistics:(UIButton *)sender;

@end
