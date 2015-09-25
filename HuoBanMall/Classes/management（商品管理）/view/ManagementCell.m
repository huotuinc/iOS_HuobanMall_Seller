//
//  ManagementCell.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/8.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ManagementCell.h"
#import <UIImageView+WebCache.h>

@implementation ManagementCell

- (void)awakeFromNib {
    
    [self.introduceLabel setContentMode:UIViewContentModeTopLeft];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.pictureUrl] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    self.introduceLabel.text = self.model.title;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥：%@",self.model.price];
    
    self.repertoryLabel.text = [NSString stringWithFormat:@"库存：%@", self.model.stock];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
