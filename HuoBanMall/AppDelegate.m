//
//  AppDelegate.m
//  HuoBanMall
//
//  Created by lhb on 15/8/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h> 

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
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
