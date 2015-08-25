//
//  ViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ViewController.h"
#import "HTDataStatisViewController.h"
#import "SettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)buttonClick:(id)sender {
    HTDataStatisViewController * aa = [[HTDataStatisViewController alloc] init];
    UINavigationController * ac = [[UINavigationController alloc] initWithRootViewController:aa];
    [self presentViewController:ac animated:YES completion:nil];
}
- (IBAction)setAction:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SettingViewController *aa = [story instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UINavigationController * ac = [[UINavigationController alloc] initWithRootViewController:aa];
    [self presentViewController:ac animated:YES completion:nil];
    
}

@end
