//
//  HeadView.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.ordorLabel.text = [NSString stringWithFormat:@"订单:%@", self.model.orderNo];
    
    switch ([self.model.status intValue]) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
