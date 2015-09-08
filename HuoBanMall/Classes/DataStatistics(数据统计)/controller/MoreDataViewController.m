//
//  MoreDataViewController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/7.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "MoreDataViewController.h"
#import "HTDataStatisViewController.h"

@interface MoreDataViewController ()

@end

@implementation MoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma 设置点击事件
- (void)_initImageView {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HTDataStatisViewController *dataStatis = [story instantiateViewControllerWithIdentifier:@"HTDataStatisViewController"];
    
    [self.ordorView bk_whenTapped:^{
        dataStatis.segment.selectedSegmentIndex = 0;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.distributorImage bk_whenTapped:^{
        dataStatis.segment.selectedSegmentIndex = 2;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.memberImage bk_whenTapped:^{
        dataStatis.segment.selectedSegmentIndex = 2;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
