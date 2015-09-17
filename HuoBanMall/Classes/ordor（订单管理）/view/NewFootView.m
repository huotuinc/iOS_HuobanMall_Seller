//
//  NewFootView.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "NewFootView.h"
#import "HTCheckLogisticsController.h"
@implementation NewFootView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.logisticsButton.layer.cornerRadius = 5;
    self.logisticsButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.logisticsButton.layer.borderWidth = 1;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)getLogistics:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(NewFootViewCheckMaterialWith:)]) {
        
        [self.delegate NewFootViewCheckMaterialWith:self];
    }
    
}
@end
