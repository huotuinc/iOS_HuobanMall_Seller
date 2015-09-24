//
//  ChangePasswordController.m
//  fanmore---
//
//  Created by HuoTu-Mac on 15/5/29.
//  Copyright (c) 2015年 HT. All rights reserved.
//  修改密码

#import "ChangePasswordController.h"
#import <SVProgressHUD.h>
#import "UserLoginTool.h"
#import "MD5Encryption.h"
#import "HTUser.h"
@interface ChangePasswordController ()

/**手机号*/
@property (weak, nonatomic) IBOutlet UILabel *phoneTextLable;

/**输入密码*/
@property (weak, nonatomic) IBOutlet UITextField *oldPassWordTextField;


@property (weak, nonatomic) IBOutlet UITextField *firstPassWord;

@property (weak, nonatomic) IBOutlet UITextField *secondPassword;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

/**保存修改密码*/
- (IBAction)changePasswordButton:(id)sender;

@end

@implementation ChangePasswordController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
   
}


- (IBAction)changePasswordButton:(id)sender {
    NSLog(@"xxxxxxx");
    if (!self.oldPassWordTextField.text.length) {
        NSLog(@"旧密码为空");
        return;
    }
    
    if (![self.firstPassWord.text isEqualToString:self.secondPassword.text]) {
        NSLog(@"两次密码不同");
        [SVProgressHUD showErrorWithStatus:@"两次密码不同"];
        return;
    }
    NSMutableDictionary * parames = [NSMutableDictionary dictionary];
    parames[@"oldPassword"] = [MD5Encryption md5by32:self.oldPassWordTextField.text];
    parames[@"newPassword"] = [MD5Encryption md5by32:self.firstPassWord.text];
    
    __weak ChangePasswordController *wself = self;
    
    [UserLoginTool loginRequestGet:@"modifyPassword" parame:parames success:^(id json) {
        NSLog(@"%@",json);
        
        
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            HTUser *user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
            
            //1、登入成功用户数据本地化
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
            
            //2、保存手机号和密码
            
            [[NSUserDefaults standardUserDefaults] setObject:wself.firstPassWord.text forKey:loginPassword];
            
            NSLog(@"用户登录后返回的token%@",user.token);
            //保存新的token
            [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:HuoBanMallAppToken];
            
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];

}
@end
