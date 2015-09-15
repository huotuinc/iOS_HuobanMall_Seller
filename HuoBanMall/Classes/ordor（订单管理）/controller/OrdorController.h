//
//  OrdorController.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/15.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ViewController.h"

@interface OrdorController : ViewController

/**
 *  背景视图用于添加滑动块
 */
@property (weak, nonatomic) IBOutlet UIView *bgView;

/**
 *  全部的点击和View
 */
@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UILabel *allLabel;

/**
 *  待付款
 */
@property (weak, nonatomic) IBOutlet UILabel *obligationLabel;
@property (weak, nonatomic) IBOutlet UIView *obligationView;

/**
 *  待收货
 */
@property (weak, nonatomic) IBOutlet UILabel *waitLabel;
@property (weak, nonatomic) IBOutlet UIView *waitView;

/**
 *  已完成
 */
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;
@property (weak, nonatomic) IBOutlet UIView *finishView;

/**
 *  表视图
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
