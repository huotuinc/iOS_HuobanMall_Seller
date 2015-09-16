//
//  ExpressCompany.m
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ExpressCompany.h"
#import <UIImageView+WebCache.h>

@interface ExpressCompany()

/**物流状态*/
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
/**物流公司*/

@property (weak, nonatomic) IBOutlet UILabel *wuliuCompany;
/**运单编号*/

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end


@implementation ExpressCompany

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDateWithStatus:(int)type withCompany:(NSString *)company withOderNumber:(NSString *) number withIconUrl:(NSString *)url{
    
    if (type == 0) {
        self.statusLable.text = @"未签收";
    }
    self.wuliuCompany.text = company;
    self.orderNumber.text = number;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed];
}
@end
