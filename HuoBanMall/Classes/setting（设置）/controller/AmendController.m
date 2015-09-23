//
//  AmendController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/26.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "AmendController.h"
#import "HTUser.h"

@interface AmendController ()

@end

@implementation AmendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textField.placeholder = self.string;
    
    [self.textField becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.textField.text.length != 0) {
        dic[@"profileData"] = self.textField.text;
        
        if ([self.title isEqualToString:@"店铺名称"]) {
            dic[@"profileType"] = @0;
        }else {
            dic[@"profileType"] = @3;
        }
        
        [SVProgressHUD showWithStatus:nil];
        
        [UserLoginTool loginRequestPost:@"updateMerchantProfile" parame:dic success:^(id json) {
            
            NSLog(@"%@",json);
            
            [SVProgressHUD dismiss];
            
            if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
                
                HTUser *user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                
                if ([self.title isEqualToString:@"店铺名称"]) {
                    if ([self.delegate respondsToSelector:@selector(NameControllerpickName:)]) {
                        [self.delegate NameControllerpickName:self.textField.text];
                    }
                }else {
                    if ([self.delegate respondsToSelector:@selector(NicknameControllerpickName:)]) {
                        [self.delegate NicknameControllerpickName:self.textField.text];
                    }
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
