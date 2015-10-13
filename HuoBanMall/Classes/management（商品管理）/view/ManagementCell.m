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
    

    
    [self.commodityImage sd_setImageWithURL:[NSURL URLWithString:self.model.pictureUrl] placeholderImage:nil options:SDWebImageDelayPlaceholder];
    
    self.introduceLabel.text = self.model.title;
    self.introduceLabel.textAlignment = NSTextAlignmentLeft;
    self.classifyLabel.text = self.model.category;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@",self.model.price];
    
    if ([self.model.stock integerValue] < 0) {
        self.repertoryLabel.text = @"库存:充足";
    }else if ([self.model.stock integerValue] < 5){
        self.repertoryLabel.text = @"库存:不充足";
    }else {
        self.repertoryLabel.text = @"库存:充足";
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
