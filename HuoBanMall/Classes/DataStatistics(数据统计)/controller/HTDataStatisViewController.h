//
//  HTDataStatisViewController.h
//  HuoBanMall
//
//  Created by lhb on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDataStatisViewController : UIViewController

//标题
@property(nonatomic,strong) NSArray *titlesArray;

/**
 *  title视图选择器
 */
@property(nonatomic,strong) UISegmentedControl *segment;

@end
