//
//  FMButton.m
//  fanmore---
//
//  Created by HuoTu-Mac on 15/6/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "FMButton.h"

@implementation FMButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = NavBackgroundColor;
    self.layer.cornerRadius = 6;
    self.layer.borderColor = NavBackgroundColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
