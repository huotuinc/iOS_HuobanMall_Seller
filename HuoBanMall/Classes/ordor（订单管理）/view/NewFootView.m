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
    
    self.goodCount.text = [NSString stringWithFormat:@"共%@件商品", self.model.amount];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", [self.model.paid doubleValue]];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[self.model.time doubleValue] / 1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    self.mainOrdor.text = self.model.mainOrderNo;
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
