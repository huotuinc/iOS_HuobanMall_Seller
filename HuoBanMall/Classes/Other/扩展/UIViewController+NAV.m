//
//  UIViewController+NAV.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/31.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "UIViewController+NAV.h"

@implementation UIViewController (NAV)

- (void)_initNavBackgroundColor
{
    self.navigationController.navigationBar.barTintColor = NavBackgroundColor;
    
    
}

- (void)_removeNavBackgroundColor
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


@end
