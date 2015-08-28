//
//  LoginViewController.m
//  fanmore---
//
//  Created by lhb on 15/5/22.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "LoginViewController.h"

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
    //1、设置控件属性
    [self setweigtAttribute];
        //3、设置键盘弹出
//    [self.userNameTextFiled becomeFirstResponder];
    
    //4.导航栏返回
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //2、设置键盘弹出的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
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
    self.title = @"粉猫登陆";
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
    
    
}

/**
 * 忘记密码
 */
- (IBAction)forgetPWBtn:(id)sender {
    
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
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark textField代理方法
//- (void)textFieldDidChange:(UITextField *)sender{
//}



@end
