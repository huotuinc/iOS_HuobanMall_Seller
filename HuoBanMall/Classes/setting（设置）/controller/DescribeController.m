//
//  DescribeController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/26.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "DescribeController.h"
#import "HTUser.h"

@interface DescribeController ()

@end

@implementation DescribeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.textAlignment = NSTextAlignmentLeft;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textView.text = self.string;
    
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.textView.text.length != 0) {
        dic[@"profileData"] = self.textView.text;
        dic[@"profileType"] = @1;
        
        [SVProgressHUD showWithStatus:nil];
        
        [UserLoginTool loginRequestPost:@"updateMerchantProfile" parame:dic success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                
                HTUser *user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                
                if ([self.delegate respondsToSelector:@selector(DescribeControllerpickDescribe:)]) {
                    [self.delegate DescribeControllerpickDescribe:self.textView.text];
                }
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
