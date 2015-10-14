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
#import "HTXiaoShouModel.h"

@interface HTTStatisticCell()

@property(nonatomic,strong) UILabel * datelable;
@property(nonatomic,strong) UILabel * dateType;
@property(nonatomic,strong) UIView * rightView;


@property(nonatomic,strong) UIImageView * iconView;
@property(nonatomic,strong) UILabel * firstLable;
@property(nonatomic,strong) UILabel * secondLable;
//@property(nonatomic,strong) UIView * rightViews;

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
        
//        UIImageView * iconView = [[UIImageView alloc] init];
//        _iconView = iconView;
//        iconView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.contentView addSubview:iconView];
//        
//        
//        UILabel * first = [[UILabel alloc] init];
//        first.numberOfLines = 0;
//        first.textAlignment = NSTextAlignmentLeft;
//        first.font = [UIFont systemFontOfSize:13];
//        _firstLable = first;
//        first.lineBreakMode = NSLineBreakByCharWrapping;
//        [self.contentView addSubview:first];
//        
//        UILabel * second = [[UILabel alloc] init];
//        second.numberOfLines = 0;
//        second.textAlignment = NSTextAlignmentLeft;
//        _secondLable = second;
//        second.font = [UIFont systemFontOfSize:12];
//        [self.contentView addSubview:second];
//        
//        UIView * rightView = [[UIView alloc] init];
//        _rightView = rightView;
////        rightView.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:rightView];
//        
//        UILabel * firstss = [[UILabel alloc] init];
//        firstss.numberOfLines = 0;
//        _datelable = firstss;
//        firstss.textColor = [UIColor colorWithRed:0.992 green:0.000 blue:0.000 alpha:1.000];
//        firstss.adjustsFontSizeToFitWidth = YES;
//        firstss.textAlignment = NSTextAlignmentCenter;
//        [rightView addSubview:firstss];
//        
//        UILabel * secondss = [[UILabel alloc] init];
//        secondss.numberOfLines = 0;
//        _dateType = secondss;
//        secondss.textAlignment = NSTextAlignmentCenter;
//        secondss.adjustsFontSizeToFitWidth = YES;
//        [rightView addSubview:secondss];
        
        UIView * rightView = [[UIView alloc] init];
        self.accessoryView = rightView;
        _rightView = rightView;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.textLabel.font = [UIFont systemFontOfSize:13];
        UILabel * datelable = [[UILabel alloc] init];
        _datelable = datelable;
        datelable.textColor = [UIColor colorWithRed:0.996 green:0.129 blue:0.129 alpha:1.000];
        datelable.textAlignment = NSTextAlignmentCenter;
        datelable.font = [UIFont systemFontOfSize:20];
//        datelable.backgroundColor = [UIColor redColor];
        [rightView addSubview:datelable];
        
        UILabel * dateType = [[UILabel alloc] init];
        _dateType = dateType;
        _dateType.font = [UIFont systemFontOfSize:13];
        dateType.textAlignment = NSTextAlignmentCenter;
//        dateType.backgroundColor = [UIColor grayColor];
        [rightView addSubview:dateType];
    }
    return self;
}


- (void)setModel:(HTStatisticsModel *)model{
    
    _model = model;
    UIImage * placeIcon = nil;
    if(model.Type == 1){
        _dateType.text = @"总返利";
        placeIcon = [UIImage imageNamed:@"zchyzrs"];
        self.textLabel.text = model.name;
        _datelable.text = [model.score stringValue];
    }else if(model.Type == 2){
        _dateType.text = @"总消费(元)";
        placeIcon = [UIImage imageNamed:@"zchyzrs"];
        self.textLabel.text = [NSString stringWithFormat:@"%@\n购买%d单",model.name,[model.amount integerValue]];
        _datelable.text = [model.money stringValue];
    }else{
        placeIcon = [UIImage imageNamed:@"ddzs"];
        _dateType.text = @"消费额(元)";
        self.textLabel.text = model.orderNo;
        _datelable.text = [model.money stringValue];
    }
//    _datelable.text = [model.num stringValue];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:placeIcon options:SDWebImageRetryFailed];
    
    if (model.time>0) {
        self.detailTextLabel.text = [self dateFormate:model.time];
    }else{
        self.detailTextLabel.text = nil;
        
    }
    
   
}


- (NSString *)dateFormate:(long long) time{
   
    
    NSDate * ptime = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000.0];;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString * publishtime = [formatter stringFromDate:ptime];
    
    NSLog(@"time -----time === %@",publishtime);
    return publishtime;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    
//    CGFloat cellwith = self.frame.size.width;
//    CGFloat margin = 10;
//    
//    CGFloat iconX = margin;
//    CGFloat iconY = margin;
//    CGFloat iconW = 40;
//    CGFloat iconZ = 40;
//    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconZ);
//    
//    CGFloat firstX = iconW+margin+7;
//    CGFloat firstY = 0;
//    CGFloat firstW = cellwith - 120;
//    CGFloat firstH = 40;
//    self.firstLable.frame = CGRectMake(firstX, firstY, firstW, firstH);
//    
//    CGFloat secondX = firstX+1;
//    CGFloat secondY = firstH;
//    CGFloat secondW = firstW;
//    CGFloat secondH = 15;
//    self.secondLable.frame = CGRectMake(secondX, secondY, secondW, secondH);
//    
//    
//    CGFloat rightX = cellwith - 60;
//    CGFloat rightY = 0;
//    CGFloat rightW = 60;
//    CGFloat rightH = 60;
//    self.rightView.frame = CGRectMake(rightX, rightY, rightW, rightH);
//    
//    
//    CGFloat dateX = 0;
//    CGFloat dateY = 0;
//    CGFloat dateW = rightW;
//    CGFloat dateH = rightH * 0.5;
//    self.datelable.frame = CGRectMake(dateX, dateY, dateW, dateH);
//    
//    CGFloat TypeX = 0;
//    CGFloat TypeY = rightH * 0.5;
//    CGFloat TypeW = dateW;
//    CGFloat TypeH = dateH;
//    self.dateType.frame = CGRectMake(TypeX, TypeY, TypeW, TypeH);
    
    
    self.accessoryView.frame = CGRectMake(self.frame.size.width-60-5 - 10,10, 60,self.frame.size.height);
//    _rightView.frame = CGRectMake(self.frame.size.width-60, 0, 60,self.frame.size.height);
//    _rightView.backgroundColor = [UIColor greenColor];
    _datelable.frame = CGRectMake(0, 0, _rightView.frame.size.width , _rightView.frame.size.height*0.5);
//    _datelable.backgroundColor = [UIColor redColor];
    _dateType.frame = CGRectMake(0, _rightView.frame.size.height*0.5-10,  _rightView.frame.size.width, _rightView.frame.size.height*0.5);
}

@end
