//
//  HeadView.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView

/**
 *  订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *ordorLabel;

/**
 *  订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *ordorType;

@end
