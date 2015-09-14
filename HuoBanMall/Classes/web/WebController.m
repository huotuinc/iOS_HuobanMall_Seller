//
//  WebController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/26.
//  Copyright (c) 2015年 HT. All rights reserved.
//  App网页

#import "WebController.h"
#import "HTGlobal.h"

@interface WebController ()<UIWebViewDelegate>

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //1、保存全局信息
    NSString *fileName = [path stringByAppendingPathComponent:InitGlobalDate];
    HTGlobal* glob = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    switch (self.type) {
            /**
             *  关于我们
             */
        case 1:
        {
            NSURL *url = [NSURL URLWithString:glob.aboutURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
            break;
        }
            /**
             *  帮助
             */
        case 2:
        {
            NSURL *url = [NSURL URLWithString:glob.helpURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
            break;
        }
            /**
             *  问题反馈
             */
        case 3:
        {
            NSURL *url = [NSURL URLWithString:glob.serverUrl];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
