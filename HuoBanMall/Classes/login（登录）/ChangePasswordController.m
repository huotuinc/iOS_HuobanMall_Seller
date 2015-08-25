//
//  ChangePasswordController.m
//  fanmore---
//
//  Created by HuoTu-Mac on 15/5/29.
//  Copyright (c) 2015年 HT. All rights reserved.
//  修改密码

#import "ChangePasswordController.h"


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
    
    
    
   
}


- (IBAction)changePasswordButton:(id)sender {
   

}
@end
