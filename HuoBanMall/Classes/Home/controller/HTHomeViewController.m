//
//  HTHomeViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/28.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTHomeViewController.h"
#import "SettingViewController.h"
#import "HTDataStatisViewController.h"
@interface HTHomeViewController ()

/**产品管理*/
@property (weak, nonatomic) IBOutlet UIImageView *productManager;
/**订单管理*/
@property (weak, nonatomic) IBOutlet UIImageView *orderManager;
/**周月统计*/
@property (weak, nonatomic) IBOutlet UIImageView *dataStatics;
/**设置管理*/
@property (weak, nonatomic) IBOutlet UIImageView *settingManager;
/**更多数据*/
@property (weak, nonatomic) IBOutlet UIImageView *moreData;
/**店铺首页*/
@property (weak, nonatomic) IBOutlet UIImageView *mallHome;

@end

@implementation HTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HTHomeViewController * wself = self;
    [self.settingManager bk_whenTapped:^{
       
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SettingViewController * setvc = [story instantiateViewControllerWithIdentifier:@"SettingViewController"];
        [wself.navigationController pushViewController:setvc animated:YES];
        
    }];
    
    [self.dataStatics bk_whenTapped:^{
        HTDataStatisViewController * dataStatics = [[HTDataStatisViewController alloc] init];
        [wself.navigationController pushViewController:dataStatics animated:YES];
        
    }];
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
