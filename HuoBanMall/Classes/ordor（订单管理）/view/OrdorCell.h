//
//  OrdorCell.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodModel.h"

@interface OrdorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) GoodModel *model;

@end
