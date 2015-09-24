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


- (void)setDateWithStatus:(NSString *)type withCompany:(NSString *)company withOderNumber:(NSString *) number withIconUrl:(NSString *)url{
    
    if ([type isEqualToString:@"succ"]) {
        self.statusLable.text  =  @"成功到达";
    }else if([type isEqualToString:@"failed"]){
        self.statusLable.text =  @"发货失败";
    }else if([type isEqualToString:@"cancel"]){
        self.statusLable.text =  @"已取消";
    }else if([type isEqualToString:@"lost"]){
        self.statusLable.text = @"货物丢失";
    }else if([type isEqualToString:@"progress"]){
        self.statusLable.text = @"运送中";
    }else if([type isEqualToString:@"timeout"]){
        self.statusLable.text =  @"超时";
    }else if([type isEqualToString:@"ready"]){
        self.statusLable.text =  @"准备发货";
    }else{
        self.statusLable.text = type;
    }
    
    self.wuliuCompany.text = company;
    self.orderNumber.text = number;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"wl-2"] options:SDWebImageRetryFailed];
}
@end
