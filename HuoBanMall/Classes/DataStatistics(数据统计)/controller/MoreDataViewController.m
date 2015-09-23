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
#import "HTStatisticsController.h"

@interface MoreDataViewController ()

@property (nonatomic, strong) MoreDataModel *more;

@end

@implementation MoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    [self _initImageView];
    
    [self getNewData];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"更多统计";
}

#pragma 网络请求

- (void)getNewData {
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [UserLoginTool loginRequestGet:@"otherStatistics" parame:nil success:^(id json) {
        
        [SVProgressHUD dismiss];
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1){
            self.more = [MoreDataModel objectWithKeyValues:(json[@"resultData"][@"otherInfoList"])];
            
            [self _initAllLabels];
        }
        
        if ([json[@"resultCode"] intValue] == 56001) {
            
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"resultDescription"]]];
            
            LoginViewController *login = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{
                [SVProgressHUD dismiss];
            }];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
        
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
        self.title = nil;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.distributorImage bk_whenTapped:^{
        dataStatis.selectIndex = 2;
        self.title = nil;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.memberImage bk_whenTapped:^{
        dataStatis.selectIndex = 2;
        self.title = nil;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.saleImage bk_whenTapped:^{
        dataStatis.selectIndex = 1;
        self.title = nil;
        [self.navigationController pushViewController:dataStatis animated:YES];
    }];
    
    [self.marketImage bk_whenTapped:^{
        
        HTStatisticsController * ctl = [[HTStatisticsController alloc] init];
        ctl.type = 3;
        [self.navigationController pushViewController:ctl animated:YES];
    }];
    
    [self.rebateImage bk_whenTapped:^{
        HTStatisticsController * ctl = [[HTStatisticsController alloc] init];
        ctl.type = 1;
        [self.navigationController pushViewController:ctl animated:YES];
    }];
    
    [self.expenseImage bk_whenTapped:^{
        HTStatisticsController * ctl = [[HTStatisticsController alloc] init];
        ctl.type = 2;
        [self.navigationController pushViewController:ctl animated:YES];
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
