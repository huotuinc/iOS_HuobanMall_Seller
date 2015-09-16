//
//  HTTStatisticCell.m
//  HuoBanMall
//
//  Created by lhb on 15/9/16.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTTStatisticCell.h"
#import "HTStatisticsModel.h"
#import <UIImageView+WebCache.h>

@interface HTTStatisticCell()

@property(nonatomic,strong) UILabel * datelable;
@property(nonatomic,strong) UILabel * dateType;
@property(nonatomic,strong) UIView * rightView;
@end

@implementation HTTStatisticCell

+ (HTTStatisticCell *)cellWithTableView:(UITableView *)tablew{
    
    static NSString * Id = @"HTTStatisticCell";
    HTTStatisticCell * cell = [tablew dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        
        cell = [[HTTStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView * rightView = [[UIView alloc] init];
        self.accessoryView =rightView;
        _rightView = rightView;
        
        UILabel * datelable = [[UILabel alloc] init];
        _datelable = datelable;
        datelable.textAlignment = NSTextAlignmentCenter;
        [rightView addSubview:datelable];
        
        UILabel * dateType = [[UILabel alloc] init];
        _dateType = dateType;
        dateType.textAlignment = NSTextAlignmentCenter;
        [rightView addSubview:dateType];
    }
    return self;
}


- (void)setModel:(HTStatisticsModel *)model{
    UIImage * placeIcon = nil;
    if(model.Type == 1){
        _dateType.text = @"总返利";
        placeIcon = [UIImage imageNamed:@"ddzs"];
    }else if(model.Type == 2){
        _dateType.text = @"总消费(元)";
        placeIcon = [UIImage imageNamed:@"ddzs"];
    }else{
        _dateType.text = @"消费额(元)";
        placeIcon = [UIImage imageNamed:@"hytj"];
    }
    _datelable.text = [model.num stringValue];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:placeIcon options:SDWebImageRetryFailed];
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.subName;
    
    _datelable.text = @"1000";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _rightView.frame = CGRectMake(self.frame.size.width-100, 0, 100,self.frame.size.height);
//    _rightView.backgroundColor = [UIColor greenColor];
    _datelable.frame = CGRectMake(0, 0, _rightView.frame.size.width, _rightView.frame.size.height*0.5);
//    _datelable.backgroundColor = [UIColor redColor];
    _dateType.frame = CGRectMake(0, _rightView.frame.size.height*0.5,  _rightView.frame.size.width, _rightView.frame.size.height*0.5);
}

@end
