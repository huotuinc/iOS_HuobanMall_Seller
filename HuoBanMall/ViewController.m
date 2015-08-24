//
//  ViewController.m
//  HuoBanMall
//
//  Created by lhb on 15/8/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "ViewController.h"
#import "HTDataStatisViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)adasd:(id)sender {
    HTDataStatisViewController * aa = [[HTDataStatisViewController alloc] init];
    UINavigationController * cc = [[UINavigationController alloc] initWithRootViewController:aa];
    [self presentViewController:cc animated:YES completion:nil];
}

@end
