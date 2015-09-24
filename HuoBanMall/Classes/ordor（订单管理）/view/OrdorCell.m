//
//  OrdorCell.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "OrdorCell.h"
#import <UIImageView+WebCache.h>

@implementation OrdorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    NSURL *url = [NSURL URLWithString:self.model.pictureUrl];
    
    [self.goodImage sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];
    
    self.goodPrice.text = [NSString stringWithFormat:@"%@", self.model.money];
    
    self.goodAmount.text = [NSString stringWithFormat:@"x%@", self.model.amount];
    
    self.goosTitle.text = self.model.title;
    
    self.goodOther.text = self.model.spec;
}


@end
