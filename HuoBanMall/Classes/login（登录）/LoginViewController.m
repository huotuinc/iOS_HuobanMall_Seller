//
//  LoginViewController.m
//  fanmore---
//
//  Created by lhb on 15/5/22.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "LoginViewController.h"
#import "findBackPwViewController.h"
#import "HTHuoBanNavgationViewController.h"
#import "HTUser.h"
#import "MD5Encryption.h"
#import <SVProgressHUD.h>

@interface LoginViewController ()<UITextFieldDelegate>



/**用户名*/
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
/**密码*/
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
/**登录按钮*/
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;

/**整个背景*/
@property (weak, nonatomic) IBOutlet UIView *backView;



/**登录按钮*/
- (IBAction)loginBtn:(id)sender;
/**忘记密码点击*/
- (IBAction)forgetPWBtn:(id)sender;
/**注册*/
- (IBAction)loginBtnClick:(id)sender;
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    //1、设置控件属性
    [self setweigtAttribute];
        //3、设置键盘弹出
//    [self.userNameTextFiled becomeFirstResponder];
    
    
    
    self.userNameTextFiled.text = [[NSUserDefaults standardUserDefaults] objectForKey:loginUserName];
    self.passwdTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:loginPassword];
   
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    //2、设置键盘弹出的监听
    
    
//    [self.userNameTextFiled addTarget:self
//                       action:@selector(textFieldDidChange:)
//             forControlEvents:UIControlEventEditingChanged];

}

/**
 *  键盘弹出
 *
 *  @param noto <#noto description#>
 */
-(void)keyboardWasShown:(NSNotification *) note{
    NSDictionary* keyboardInfo = note.userInfo;
    NSLog(@"%@",keyboardInfo);
    CGPoint kbSize = [[keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    CGPoint center = self.backView.center;
    center.y = self.view.center.y - (self.view.frame.size.height - kbSize.y)*0.2;
    [UIView animateWithDuration:0.2 animations:^{
       self.backView.center = center;
    }];
}

/**
 *设置控件属性
 */
- (void) setweigtAttribute
{
    self.title = @"伙伴商城登陆";
    [self _initNavBackgroundColor];
}

/**退下下键盘*/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


/**
 * 登录
 */
- (IBAction)loginBtn:(id)sender {
    
    
    NSLog(@"xxxx");
//    self.userNameTextFiled.text = @"lc";
//    self.passwdTextField.text = @"123456";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"username"] = self.userNameTextFiled.text;
    dic[@"password"] = [MD5Encryption md5by32:self.passwdTextField.text];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:HuoBanMallAppToken];
    
    __weak LoginViewController * wself = self;
    
    [SVProgressHUD showWithStatus:@"登录ing"];
    [UserLoginTool loginRequestGet:@"login" parame:dic success:^(id json) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 54003) {

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
            return ;
        }
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 57001) {

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
            return ;
        }
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 57002) {

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
            return ;
        }
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 53011) {

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", json[@"resultDescription"]]];
            return ;
        }
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            HTUser *user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
            
            //1、登入成功用户数据本地化
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
            
            //2、保存手机号和密码
            [[NSUserDefaults standardUserDefaults] setObject:wself.userNameTextFiled.text forKey:loginUserName];
            [[NSUserDefaults standardUserDefaults] setObject:wself.passwdTextField.text forKey:loginPassword];
            
            NSLog(@"用户登录后返回的token%@",user.token);
            //保存新的token
            [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:HuoBanMallAppToken];
            if (![user.welcomeTip isEqualToString:@""]) {//登入成功提示
                [SVProgressHUD showInfoWithStatus:user.welcomeTip];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            }
            
            UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HTHuoBanNavgationViewController * home = [story instantiateViewControllerWithIdentifier:@"HTHuoBanNavgationViewController"];
            UIWindow * mainview = [UIApplication sharedApplication].keyWindow;
            mainview.rootViewController = home;
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
}

/**
 * 忘记密码
 */
- (IBAction)forgetPWBtn:(id)sender {
    findBackPwViewController * findvc = [[findBackPwViewController alloc] init];
    UINavigationController * navCt = [[UINavigationController alloc] initWithRootViewController:findvc];
    [self presentViewController:navCt animated:YES completion:nil];
    
}
/**
 * 注册
 */
- (IBAction)loginBtnClick:(id)sender {
    
}


/**
 *  有动画
 */
- (void) loginSuccess{
    if ([self.delegate respondsToSelector:@selector(LoginViewDelegate:)]) {
        
        [self.delegate LoginViewDelegate:self.loginType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  没动画
 */
- (void) loginSuccess1{
    
    if ([self.delegate respondsToSelector:@selector(LoginViewDelegate:)]) {
        
        [self.delegate LoginViewDelegate:self.loginType];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc{
    NSLog(@"------");
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark textField代理方法
//- (void)textFieldDidChange:(UITextField *)sender{
//}



@end
