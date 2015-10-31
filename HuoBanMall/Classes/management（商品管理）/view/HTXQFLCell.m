//
//  HTXQFLCell.m
//  HuoBanMall
//
//  Created by lhb on 15/9/19.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTXQFLCell.h"
#import "HTJiFenModel.h"

@interface HTXQFLCell ()
@property (weak, nonatomic) IBOutlet UILabel *accountLable;
@property (weak, nonatomic) IBOutlet UILabel *jifenLable;
@property (weak, nonatomic) IBOutlet UILabel *timeOneLable;
@property (weak, nonatomic) IBOutlet UILabel *timeTwoLable;
@property (weak, nonatomic) IBOutlet UILabel *jifenOrderStatus;

@end
@implementation HTXQFLCell


- (void)setModel:(HTJiFenModel *)model{
    _model = model;
    _accountLable.text = model.userName;
    
    NSString * aa = @"共获得";
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:aa];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",[model.score stringValue]]];
    [str appendAttributedString:str1];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.941 green:0.227 blue:0.098 alpha:1.000] range:NSMakeRange(3,[model.score stringValue].length)];
    
    _jifenLable.attributedText = str;
    _timeOneLable.text = [self dateFormate:model.getTime];
    _timeTwoLable.text = [NSString stringWithFormat:@"获得时间:%@",[self dateFormate:model.regularization]];
    _jifenOrderStatus.text = model.present;
    
}

- (NSString *)dateFormate:(long long) time{
    
    
    NSDate * ptime = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * publishtime = [formatter stringFromDate:ptime];
    
//    NSLog(@"time -----time === %@",publishtime);
    return publishtime;
}

@end
