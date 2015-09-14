//
//  MoreDataViewController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/9/7.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "MoreDataViewController.h"
#import "HTDataStatisViewController.h"
#import "MoreDataModel.h"

@interface MoreDataViewController ()

@property (nonatomic, strong) MoreDataModel *more;

@end

@implementation MoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initImageView];
    
    [self getNewData];
}

#pragma 网络请求

- (void)getNewData {
    
    [UserLoginTool loginRequestGet:@"otherStatistics" parame:nil success:^(id json) {
        NSLog(@"%@", json);
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            self.more = [MoreDataModel objectWithKeyValues:(json[@"resultData"][@"otherInfoList"])];
            
            [self _initAllLabels];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


- (void)_initAllLabels {
    self.ordorLabel.text = [NSString stringWithFormat:@"%@", self.more.billAmount];
    self.distributorLabel.text = [NSString stringWithFormat:@"%@", self.more.discributorAmount];
    self.goodLabel.text = [NSString stringWithFormat:@"%@", self.more.goodsAmount];
    self.memberLabel.text = [NSString stringWithFormat:@"%@", self.more.memberAmount];
}

#pragma 设置点击事件
- (void)_initImageView {
    HTDataStatisViewController *dataStatis = [[HTDataStatisViewController alloc] init];;
    
    [self.ordorView bk_whenTapped:^{
        dataStatis.selectIndex = 0;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.distributorImage bk_whenTapped:^{
        dataStatis.selectIndex = 2;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.memberImage bk_whenTapped:^{
        dataStatis.selectIndex = 2;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.saleImage bk_whenTapped:^{
        dataStatis.selectIndex = 1;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
#warning 转跳网页
    [self.marketImage bk_whenTapped:^{
        
    }];
    
    [self.rebateImage bk_whenTapped:^{
        
    }];
    
    [self.expenseImage bk_whenTapped:^{
        
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
