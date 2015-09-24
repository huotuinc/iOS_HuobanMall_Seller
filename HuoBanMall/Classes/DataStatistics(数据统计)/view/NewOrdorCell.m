//
//  NewOrdorCell.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "NewOrdorCell.h"
#import <UIImageView+WebCache.h>


@interface NewOrdorCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *priceNumber;

@property (weak, nonatomic) IBOutlet UILabel *buyNumber;

@property (weak, nonatomic) IBOutlet UILabel *goodStytle;

@end


@implementation NewOrdorCell


- (void)setDate:(NSString *)title withPrice:(NSString *)price WithBuyNum:(NSString *)num withDesc:(NSString *)desc withIconUrl:(NSString *)url{
    
    [self.iconVIew sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"wl-1"] options:SDWebImageRetryFailed];
    self.titleLable.text = title;
    self.priceNumber.text = [NSString stringWithFormat:@"￥%@",price];
    self.buyNumber.text = [NSString stringWithFormat:@"x%@",num];
    self.goodStytle.text = desc;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
