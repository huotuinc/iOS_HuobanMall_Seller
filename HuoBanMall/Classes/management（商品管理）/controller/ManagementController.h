//
//  ManagementController.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/24.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagementController : UIViewController

//底部视图高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

/**
 *  头部选项卡
 */
@property (strong, nonatomic) UISegmentedControl *segment;
/**
 *  底部背景图片
 */


@property (weak, nonatomic) IBOutlet UIView *buttomView;
/**
 *  全选按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *allSelect;
/**
 *  全选图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
/**
 *  上下架按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *putaway;
/**
 *  删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
/**
 *  上架下架动作
 *
 *  @param sender
 */
- (IBAction)putawayAction:(id)sender;
/**
 *  删除动作
 *
 *  @param sender
 */
- (IBAction)deleteGood:(id)sender;
/**
 *  全选动作
 *
 *  @param sender
 */
- (IBAction)allSelected:(id)sender;


@end
