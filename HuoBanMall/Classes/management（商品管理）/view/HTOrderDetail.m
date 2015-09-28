//
//  HTOrderDetail.m
//  HuoBanMall
//
//  Created by lhb on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//  first    second  订单管理详情cell

#import "HTOrderDetail.h"
#import "HTOrderDetailModel.h"


@interface HTOrderDetail ()

/**购买人*/
@property(nonatomic,strong) UILabel * buyPersonLable;

@property(nonatomic,strong) UILabel * shoujianLable;
/**购买姓名*/
@property(nonatomic,strong) UILabel * buyPersonName;
/**联系人方式*/
@property(nonatomic,strong) UILabel * contactLable;
/**联系人号码*/
//@property(nonatomic,strong) UILabel * contactPhoneNumberLable;

/**联系人号码*/
@property(nonatomic,strong) UILabel * placeLable;

@end


@implementation HTOrderDetail


+ (instancetype)cellWithTableView:(UITableView*)tableview WithIndex:(NSIndexPath *)index{
    
    
    static NSString * Identifier = @"cell";
    if(index.section == 0 && index.row==0){
        
        Identifier = @"first";
        HTOrderDetail * cell = [tableview dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            
            cell = [[HTOrderDetail alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:Identifier];
             cell.textLabel.font = [UIFont systemFontOfSize:13];
        }
        return cell;
    }else if (index.section == 1){
        
        Identifier = @"second";
        HTOrderDetail * cell = [tableview dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            
            cell = [[HTOrderDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        return cell;
    }else if(index.section == 3){
        Identifier = @"last";
        HTOrderDetail * cell = [tableview dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            
            cell = [[HTOrderDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        return cell;
    }else{
        Identifier = @"cell";
        HTOrderDetail * cell = [tableview dequeueReusableCellWithIdentifier:Identifier];
        if (cell == nil) {
            
            cell = [[HTOrderDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        }
        return cell;
    }
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"%@",reuseIdentifier);
        SEL funreuseIdentifier = NSSelectorFromString(reuseIdentifier);
        [self performSelector:funreuseIdentifier withObject:nil];
    }
    return self;
}

- (void)last{
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = @"查看物流信息";
}
- (void)cell{
    
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    _placeLable =  self.textLabel;
}

- (void)first{
    
    
    UILabel * buyperson = [[UILabel alloc] init];
    buyperson.text = @"购买人:小明名";
     buyperson.font = [UIFont systemFontOfSize:13];
    _buyPersonLable = buyperson;
    [self addSubview:buyperson];
    
    
    UILabel * shoujian = [[UILabel alloc] init];
    shoujian.font = [UIFont systemFontOfSize:13];
    shoujian.text = @"收件人:小李";
    _shoujianLable = shoujian;
    [self addSubview:shoujian];
//    self.textLabel.text = @"购买人:小明";
//    self.textLabel.font = [UIFont systemFontOfSize:18];
//    self.textLabel.textAlignment = NSTextAlignmentLeft;
//    _buyPersonName = self.detailTextLabel;
////    self.detailTextLabel.font = [UIFont systemFontOfSize:18];
}


- (void)second{
    
    UILabel *contactLable = [[UILabel alloc] init];
    contactLable.text = @"联系方式：";
    _contactLable = contactLable;
    _contactLable.textColor = [UIColor colorWithRed:0.220 green:0.580 blue:0.992 alpha:1.000];
    _contactLable.font = [UIFont systemFontOfSize:13];
    contactLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:contactLable];
    
    UILabel *number = [[UILabel alloc] init];
    _contactPhoneNumberLable = number;
    _contactPhoneNumberLable.textColor = [UIColor blueColor];
    _contactPhoneNumberLable.font = [UIFont systemFontOfSize:14];
    number.textAlignment = NSTextAlignmentLeft;
    [self addSubview:number];
}


- (void)setModel:(HTOrderDetailModel *)model{
    _model = model;
    
    _buyPersonLable.text =[NSString stringWithFormat:@"购买人: %@",model.buyer];
    _shoujianLable.text = [NSString stringWithFormat:@"收件人: %@",model.receiver];
//    _buyPersonName.text = model.buyName;
//    _contactPhoneNumberLable.text = model.phoneNumber;
    _placeLable.text = model.address;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat cellW = self.frame.size.width;
    CGFloat cellH = self.frame.size.height;
    
    CGFloat contactX = 0;
    CGFloat contactY = 0;
    CGFloat contactW = cellW * 0.5;
    CGFloat contactH = cellH;
    _contactLable.frame = CGRectMake(contactX, contactY, contactW, contactH);
    
    CGFloat contactNumberX = contactW;
    CGFloat contactNumberY = 0;
    CGFloat contactNumberW = contactW;
    CGFloat contactNumberH = contactH;
    _contactPhoneNumberLable.frame = CGRectMake(contactNumberX, contactNumberY, contactNumberW, contactNumberH);
    
    
    _buyPersonLable.frame = CGRectMake(15, 0, self.frame.size.width*0.5-15, self.frame.size.height);
    _shoujianLable.frame = CGRectMake(_buyPersonLable.frame.size.width-30, 0, self.frame.size.width-_buyPersonLable.frame.size.width, self.frame.size.height);
}
@end
