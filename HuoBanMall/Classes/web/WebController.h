//
//  WebController.h
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/26.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
 *  网页加载类型
 */
@property (nonatomic, assign) int type;

@end
