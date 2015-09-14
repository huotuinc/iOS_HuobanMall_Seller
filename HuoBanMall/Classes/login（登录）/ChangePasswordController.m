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
    parames[@"oldPassword"] = self.oldPassWordTextField.text;
    parames[@"newPassword"] = self.firstPassWord.text;

    [UserLoginTool loginRequestGet:@"modifyPassword" parame:parames success:^(id json) {
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];

}
@end
