//
//  HTTopTenGoodCell.m
//  HuoBanMall
//
//  Created by lhb on 15/9/18.
//  Copyright (c) 2015年 HT. All rights reserved.
//  商品前十展示cell

#import "HTTopTenGoodCell.h"
#import "HTStatisticsModel.h"


@interface HTTopTenGoodCell()

@end

@implementation HTTopTenGoodCell

+ (HTTopTenGoodCell *)cellWithTableView:(UITableView *)tablew{
    
    static NSString * Id = @"HTTopTenGoodCell";
    HTTopTenGoodCell * cell = [tablew dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        
        cell = [[HTTopTenGoodCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.numberOfLines = 0;
        UIImageView * top = [[UIImageView alloc] init];
        top.contentMode = UIViewContentModeScaleAspectFit;
        _topImageView = top;
    }
    return self;
}


- (void)setModel:(HTStatisticsModel *)model{
 
    self.textLabel.text = model.name;
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"aaaaa dasdas"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.941 green:0.227 blue:0.098 alpha:1.000] range:NSMakeRange(0,5)];
    self.detailTextLabel.attributedText = str;
  
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellW = self.frame.size.width;
    CGFloat cellH = self.frame.size.height;
    _topImageView.frame = CGRectMake(cellW - cellH, 0, cellH, cellH);
}

@end