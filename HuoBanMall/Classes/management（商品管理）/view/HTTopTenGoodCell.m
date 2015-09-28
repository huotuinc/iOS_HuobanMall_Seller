//
//  HTTopTenGoodCell.m
//  HuoBanMall
//
//  Created by lhb on 15/9/18.
//  Copyright (c) 2015年 HT. All rights reserved.
//  商品前十展示cell

#import "HTTopTenGoodCell.h"
#import "HTTopTenModel.h"
#import <UIImageView+WebCache.h>

@interface HTTopTenGoodCell()

@property(nonatomic,strong) UILabel * numLable;
@end

@implementation HTTopTenGoodCell

+ (HTTopTenGoodCell *)cellWithTableView:(UITableView *)tablew cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Id = @"HTTopTenGoodCell";
    HTTopTenGoodCell * cell = [tablew dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        
        cell = [[HTTopTenGoodCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    if (indexPath.row == 0) {
        cell.topImageView.image = [UIImage imageNamed:@"yellow-1"];
    }else if(indexPath.row == 1){
        cell.topImageView.image = [UIImage imageNamed:@"orange-2"];
    }else if (indexPath.row == 2){
        cell.topImageView.image = [UIImage imageNamed:@"orange-3"];
    }else{
        cell.topImageView.image = [UIImage imageNamed:@"red-4"];
    }
    //排名
    cell.numLable.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.userInteractionEnabled = NO;
        self.textLabel.numberOfLines = 0;
        UIImageView * top = [[UIImageView alloc] init];
        top.contentMode = UIViewContentModeScaleAspectFit;
        _topImageView = top;
//        _topImageView.backgroundColor = [UIColor redColor];
        self.accessoryView = top;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel * num = [[UILabel alloc] init];
        _numLable = num;
//        num.alpha = 0;
        num.text = @"1";
        num.textAlignment = NSTextAlignmentCenter;
        num.textColor = [UIColor whiteColor];
        [_topImageView addSubview:num];
        
    }
    return self;
}


- (void)setModel:(HTTopTenModel *)model{
 
    _model = model;
    self.textLabel.text = [NSString stringWithFormat:@" %@",model.title];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"tpzwx"] options:SDWebImageRetryFailed];
    
    NSString * redStrs = [NSString stringWithFormat:@"￥%@",[model.price stringValue]];
//    NSString * buyStr = [NSString stringWithFormat:@"%@人已购买",[model.amount stringValue]];
    
    NSMutableString * redStr = [NSMutableString stringWithFormat:@"￥%@ 已售出%@件",[model.price stringValue],[model.amount stringValue]];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:redStr];
   
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.941 green:0.227 blue:0.098 alpha:1.000] range:NSMakeRange(0,redStrs.length)];
    self.detailTextLabel.attributedText = str;
  
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellW = self.frame.size.width;
    CGFloat cellH = self.frame.size.height;
    _topImageView.frame = CGRectMake(cellW - 52+12, 0, 32, cellH);
    
    _numLable.frame = CGRectMake(0, 0, 32, cellH);
}



@end