//
//  LoginViewController.m
//  fanmore---
//
//  Created by lhb on 15/5/22.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
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


/**显示导行栏*/
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1、设置控件属性
    [self setweigtAttribute];
    //2、设置键盘弹出的监听
    [self registerForKeyboardNotifications];
    //3、设置键盘弹出
    [self.userNameTextFiled becomeFirstResponder];
    
    //4.导航栏返回
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"返回" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

/**
 *  设置键盘弹出的监听
 */
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:self.passwdTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:self.passwdTextField];
 }
/**
 *  键盘弹出
 *
 *  @param noto <#noto description#>
 */
-(void)keyboardWasShown:(NSNotification *) note{
    
    NSDictionary* info = [note userInfo];
//    NSLog(@"%@",info);
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    NSLog(@"kbsize == %f ----- y == %f",kbSize.height,CGRectGetMaxY(self.loginBtn.frame));
    CGFloat sizesss = CGRectGetMaxY(self.loginBtn.frame) - (ScreenHeight - kbSize.height);
//    NSLog(@"--------------size%f",sizesss);
    if (sizesss > 0) {
        
        [UIView animateWithDuration:0.15 animations:^{
            
            self.backView.transform = CGAffineTransformMakeTranslation(0,-(sizesss));
        }];
        
    }
}
/**
 *  键盘退下
 *
 *  @param noto <#noto description#>
 */
-(void)keyboardWillBeHidden:(NSNotification *) note{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.backView.transform = CGAffineTransformIdentity;
    }];
}
/**
 *设置控件属性
 */
- (void) setweigtAttribute
{
    self.title = @"粉猫登陆";
//    self.loginBtn.backgroundColor = LWColor(18, 18, 127);
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
 *  验证手机号的正则表达式
 */
-(BOOL) checkTel:(NSString *) phoneNumber{
    NSString *regex = @"^(1)\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}






@end
