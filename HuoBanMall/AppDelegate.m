//
//  AppDelegate.m
//  HuoBanMall
//
//  Created by lhb on 15/8/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h> 
#import "LoginViewController.h"
#import "HTResultData.h"
#import "HTHuoBanNavgationViewController.h"
#import "HTToJudgeLoginFlag.h"

@interface AppDelegate ()<CLLocationManagerDelegate>
/**定位管理者*/
@property(nonatomic,strong) CLLocationManager *mgr;

@end

@implementation AppDelegate

- (CLLocationManager *)mgr{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //开启定位服务
    [self AppLaunchTolocation];
    
    //程序初始化借口
    [self callInitFunction];
    
    if ([HTToJudgeLoginFlag ToJudgeLoginFlag]) {
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HTHuoBanNavgationViewController * homeNav = [story instantiateViewControllerWithIdentifier:@"HTHuoBanNavgationViewController"];
        self.window.rootViewController = homeNav;
    }else{
        LoginViewController *login = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark 初始化接口

/**
 *  程序初始化借口
 */
- (void)callInitFunction{
    __block HTResultData * resultData = [[HTResultData  alloc] init];
    [UserLoginTool loginRequestGet:@"init" parame:nil success:^(id json) {
        NSLog(@"xxxx------init%@",json);
        if ([json[@"systemResultCode"] intValue] == 1 && [json[@"resultCode"] intValue] == 1) {
            resultData = [HTResultData objectWithKeyValues:json[@"resultData"]];
            NSString *localToken = [[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallAppToken];
            if ([localToken isEqualToString:resultData.user.token]) {
                //初始化
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                //1、保存个人信息
                NSString *fileName = [path stringByAppendingPathComponent:LocalUserDate];
                [NSKeyedArchiver archiveRootObject:resultData.user toFile:fileName]; //保存用户信息
                //2、保存全局信息
                fileName = [path stringByAppendingPathComponent:InitGlobalDate];//保存全局信息
                [NSKeyedArchiver archiveRootObject:resultData.global toFile:fileName]; //保存用户信息
                
            }else{
                
                NSLog(@"----init -new --token%@",resultData.user.token);
                //保存新的token
                [[NSUserDefaults standardUserDefaults] setObject:resultData.user.token forKey:HuoBanMallAPPKEY];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                //1、保存全局信息
                NSString *fileName = [path stringByAppendingPathComponent:InitGlobalDate];
                [NSKeyedArchiver archiveRootObject:resultData.global toFile:fileName]; //保存用户信息
                //2、保存个人信息
                fileName = [path stringByAppendingPathComponent:LocalUserDate];
                [NSKeyedArchiver archiveRootObject:resultData.user toFile:fileName]; //保存用户信息
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}
#pragma mark  定位
/**
 *  定位
 */
- (void)AppLaunchTolocation{
    self.mgr.delegate = self;
    self.mgr.desiredAccuracy = kCLLocationAccuracyKilometer;
    if (IsIos8) {
        
        [self.mgr requestAlwaysAuthorization];
    }else{
        [self.mgr startUpdatingLocation];
    }
}
/**
 *  定位定位代理方法
 *
 *  @param manager   <#manager description#>
 *  @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager didUpdataLocations:(NSArray *)locations{
    
    CLLocation * loc = [locations lastObject];
    NSString * lat = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    NSString * lg = [NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:HuoBanMallDWLatitude]; //保存纬度
    [[NSUserDefaults standardUserDefaults] setObject:lg forKey:HuoBanMallDWLongitude];//保存精度
    [self.mgr stopUpdatingLocation];
}
/**
 *  定位定位代理方法
 *
 *  @param manager   <#manager description#>
 *  @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusNotDetermined) {
        
    }else if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.mgr startUpdatingLocation];
    }else{
        
    }
    
}
/**
 *  反地理编码
 *
 *  @param loc ;
 */
- (void)reverseGeocode{
    
    
    __block NSString * cityCode = nil;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityCode" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    CGFloat longs =  [[[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallDWLongitude] floatValue];
    CGFloat weis = [[[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallDWLatitude] floatValue];
    CLLocation * locs = [[CLLocation alloc] initWithLatitude:weis longitude:longs];
    
    
    CLGeocoder * clg = [[CLGeocoder alloc] init];
    //    NSLog(@"%f ---sssss-- %f" ,loc.coordinate.longitude ,loc.coordinate.latitude);
    [clg reverseGeocodeLocation:locs completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *pm = [placemarks firstObject];
        NSLog(@"%@",pm.locality);
        for (NSDictionary * dict in array) {
            if ([dict[@"Value"] isEqualToString:pm.locality]) {
                cityCode = dict[@"Key"];
                [[NSUserDefaults standardUserDefaults] setObject:cityCode forKey:HuoBanMallBaiDuCityCode];
            }
        }
        
    }];
}

@end
