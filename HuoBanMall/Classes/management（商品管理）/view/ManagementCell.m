//
//  ManagementCell.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/8.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ManagementCell.h"

@implementation ManagementCell

- (void)awakeFromNib {
    
    [self.introduceLabel setContentMode:UIViewContentModeTopLeft];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
