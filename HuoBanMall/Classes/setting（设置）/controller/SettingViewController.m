//
//  SettingViewController.m
//  HuoBanMall
//
//  Created by HuoTu-Mac on 15/8/25.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "SettingViewController.h"
#import <SDWebImageManager.h>
#import <CoreLocation/CoreLocation.h>
#import "UserLoginTool.h"
#import "GTMBase64.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AmendController.h"
#import "DescribeController.h"
#import "HTUser.h"
#import <UIImageView+WebCache.h>
#import "WebController.h"
#import "HTGlobal.h"
#import "LoginViewController.h"

@interface SettingViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate, AmendControllerdelegate ,DescribeControllerdelegate>

//店铺logo
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/**
 *  店铺简介
 */
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  当前账号
 */
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickname;


/**
 *  用户数据
 */
@property (strong, nonatomic) HTUser *user;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self getUserInformation];
    
    [self _initUserInfo];
}

#pragma mark 代理协议

- (void)NameControllerpickName:(NSString *)name {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
        self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        self.nameLabel.text = name;
    });
}

- (void)NicknameControllerpickName:(NSString *)name {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
        self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        self.nickname.text = name;
    });
}

- (void)DescribeControllerpickDescribe:(NSString *)describe
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
        self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
        self.introLabel.text = describe;
    });
}

#pragma mark 设置初始的用户信息

- (void)_initUserInfo {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.logo] placeholderImage:nil options:SDWebImageRetryFailed];
    
    self.introLabel.text = self.user.discription;
    
    self.nameLabel.text = self.user.title;
    
    self.accountLabel.text = self.user.mobile;
    
    self.nickname.text = self.user.nickName;
    
    
}

#pragma mark 网络请求

- (void)getUserInformation {
    
    [UserLoginTool loginRequestGet:@"getMerchantProfile" parame:nil success:^(id json) {
        
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            //            HTUser *user = [HTUser objectWithKeyValues:(json[@"resultData"][@"user"])];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (IsIos8) {
                
                UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
                UIAlertAction * photo = [UIAlertAction actionWithTitle:@"从本地相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    UIImagePickerController * pc = [[UIImagePickerController alloc] init];
                    pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                    pc.delegate = self;
                    pc.allowsEditing = YES;
                    [self presentViewController:pc animated:YES completion:nil];
                }];
                UIAlertAction * ceme  = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    UIImagePickerController * pc = [[UIImagePickerController alloc] init];
                    pc.allowsEditing = YES;
                    pc.sourceType=UIImagePickerControllerSourceTypeCamera;
                    pc.delegate = self;
                    [self presentViewController:pc animated:YES completion:nil];
                }];
                [alertVc addAction:photo];
                [alertVc addAction:ceme];
                [alertVc addAction:action];
                [self presentViewController:alertVc animated:YES completion:nil];
            }else{
                
                UIActionSheet * aa = [[UIActionSheet alloc] initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
                [aa showInView:self.view];
                
            }
        }else if (indexPath.row == 1) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            DescribeController *describe = [story instantiateViewControllerWithIdentifier:@"DescribeController"];
            describe.title = @"店铺描述";
            describe.string = self.user.discription;
            describe.delegate = self;
            [self.navigationController pushViewController:describe animated:YES];
        }else if (indexPath.row == 2) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AmendController *describe = [story instantiateViewControllerWithIdentifier:@"AmendController"];
            describe.title = @"店铺名称";
            describe.delegate = self;
            //            describe.textField.text = ;
#pragma  设置店铺名称
            describe.string = self.user.title;
            [self.navigationController pushViewController:describe animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AmendController *describe = [story instantiateViewControllerWithIdentifier:@"AmendController"];
            describe.title = @"昵称修改";
            describe.delegate = self;
#pragma  设置昵称
            describe.string = self.user.nickName;
            [self.navigationController pushViewController:describe animated:YES];
        }
    }else if (indexPath.section == 3) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebController *web = [story instantiateViewControllerWithIdentifier:@"WebController"];
        
        
        if (indexPath.row == 0) {
            
            web.title = @"关于我们";
            web.type = 1;
            
        }else if (indexPath.row == 1){
            
            web.title = @"实用帮助";
            web.type = 2;
        }else if (indexPath.row == 2){
            
            web.title = @"问题反馈";
            web.type = 3;
        }
        
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.section == 4) {
        UIAlertView * ac = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [ac show];
    }
    
}

/**
 *  退出账号提示按钮
 *
 *  @param alertView   <#alertView description#>
 *  @param buttonIndex <#buttonIndex description#>
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:HuoBanMallAppToken];
        [[NSUserDefaults standardUserDefaults] setObject:@"wrong" forKey:loginFlag];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:loginUserName];
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        //1、保存个人信息
        NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
        [NSKeyedArchiver archiveRootObject:nil toFile:fileName];
        
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma 拍照
/**
 *  拍照
 *
 *  @param picker
 *  @param info
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *photoImage = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            photoImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }
    self.iconView.image = photoImage;
    NSData *data;
    if (UIImagePNGRepresentation(photoImage) == nil) {
        
        data = UIImageJPEGRepresentation(photoImage, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(photoImage);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  取消拍照
 *
 *  @param picker <#picker description#>
 */
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *    相机掉出
 *
 *  @param actionSheet <#actionSheet description#>
 *  @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerController * pc = [[UIImagePickerController alloc] init];
        pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pc.delegate = self;
        pc.allowsEditing = YES;
        [self presentViewController:pc animated:YES completion:nil];
        
    }else if(buttonIndex == 1) {
        
        UIImagePickerController * pc = [[UIImagePickerController alloc] init];
        pc.allowsEditing = YES;
        pc.sourceType=UIImagePickerControllerSourceTypeCamera;
        pc.delegate = self;
        [self presentViewController:pc animated:YES completion:nil];
    }
}



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
