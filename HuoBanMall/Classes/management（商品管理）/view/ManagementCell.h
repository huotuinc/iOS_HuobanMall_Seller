//
//  ManagementCell.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/8.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementCell : UITableViewCell

//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *commodityImage;

//商品介绍
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

//商品分类
@property (weak, nonatomic) IBOutlet UILabel *classifyLabel;

//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

//库存
@property (weak, nonatomic) IBOutlet UILabel *repertoryLabel;

@end
