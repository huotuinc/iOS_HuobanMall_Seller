//
//  PushViewController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/25.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *order;
@property (weak, nonatomic) IBOutlet UISwitch *friend;
@property (weak, nonatomic) IBOutlet UISwitch *message;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    
    NSLog(@"ordro%@", self.user.enableBillNotice);
    self.order.on = [self.user.enableBillNotice intValue];
    [self.order addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
    self.order.tag = 4;
    
    NSLog(@"friend%@", self.user.enablePartnerNotice);
    self.friend.on = [self.user.enablePartnerNotice intValue];
    [self.friend addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
    self.friend.tag = 5;
    
    NSLog(@"message%@", self.user.noDisturbed);
    self.message.on = [self.user.noDisturbed intValue];
    [self.message addTarget:self action:@selector(swichChanged:) forControlEvents:UIControlEventValueChanged];
    self.message.tag = 6;
}

- (void)swichChanged:(UISwitch *) swich {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"profileType"] = @(swich.tag);
    dic[@"profileData"] = @(swich.on);
    
    [SVProgressHUD showWithStatus:@"数据上传中"];
    
    [UserLoginTool loginRequestPost:@"updateMerchantProfile" parame:dic success:^(id json) {
        
        [SVProgressHUD dismiss];
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            
            self.user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
            [NSKeyedArchiver archiveRootObject:self.user toFile:fileName];
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
        
        swich.on = !swich.on;
        
        [SVProgressHUD showErrorWithStatus:@"网络异常，请检查网络"];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
