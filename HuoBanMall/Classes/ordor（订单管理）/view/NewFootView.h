//
//  NewFootView.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdorModel.h"

@class NewFootView;

@protocol NewFootViewDelegate <NSObject>

@optional
- (void)NewFootViewCheckMaterialWith:(NewFootView *)newfootView;


@end



@interface NewFootView : UIView

@property (nonatomic, strong) OrdorModel *model;

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


@property(nonatomic,weak) id<NewFootViewDelegate>delegate;
@end
