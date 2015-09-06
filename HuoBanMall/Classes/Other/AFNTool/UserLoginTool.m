//
//  UserLoginTool.m
//  fanmore---
//
//  Created by lhb on 15/5/21.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "UserLoginTool.h"
#import <AFNetworking.h>
#import "NSDictionary+EXTERN.h"

@interface UserLoginTool()

@end



@implementation UserLoginTool

+ (void)loginRequestGet:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
   NSString *url = [MainUrl stringByAppendingString:urlStr];
    
   AFHTTPRequestOperationManager * manager  = [AFHTTPRequestOperationManager manager];
   NSMutableDictionary * paramsOption = [NSMutableDictionary dictionary];
   paramsOption[@"appKey"] = HuoBanMallAPPKEY;
   paramsOption[@"appSecret"] = HuoBanMallSecretKey;
   NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:HuoBanMallBaiDuCityCode];
   paramsOption[@"cityCode"] = (cityCode.length?cityCode:@"179");
   paramsOption[@"cpaCode"] = @"default";
   paramsOption[@"imei"] = DeviceNo;
   paramsOption[@"operation"] = OPERATION_parame;
   NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallAppToken];
   paramsOption[@"token"] = token?token:@"";
   paramsOption[@"version"] = HuoBanMallAppVersion;
   paramsOption[@"timestamp"] = apptimesSince1970;
   
   if (params != nil) {
      [paramsOption addEntriesFromDictionary:params];
   }
   
   paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];
   [paramsOption removeObjectForKey:@"appSecret"];
   
//    paramsOption[@"timestamp"] = apptimesSince1970;
//    paramsOption[@"operation"] = OPERATION_parame;
//    paramsOption[@"version"] =AppVersion;
//    NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:AppToken];
//    paramsOption[@"token"] = token?token:@"";
//    paramsOption[@"imei"] = DeviceNo;
//    paramsOption[@"cityCode"] = @"1372";
//    paramsOption[@"cpaCode"] = @"default";
//    if (params != nil) { //传入参数不为空
//       [paramsOption addEntriesFromDictionary:params];
//    }
//    paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];  //计算asign
//    [paramsOption removeObjectForKey:@"appSecret"];
    
//    NSArray * parameaaa = [paramsOption allKeys];
//    NSMutableString * aaa = [[NSMutableString alloc] init];
//    
//    for (NSString * a in parameaaa) {
//        [aaa appendString:[NSString stringWithFormat:@"%@=%@&",a,[paramsOption objectForKey:a]]];
//    }
//    aaa = [aaa substringToIndex:(int)(aaa.length-1)];
//    NSLog(@"--------------------%@",aaa);
//    
//    NSLog(@"dasdasdas-------parame--get%@",paramsOption);
//    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:paramsOption success:^(AFHTTPRequestOperation *operation, id responseObject){
//        NSLog(@"xxxxxxxx%@",operation);
    
        success(responseObject);
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",operation);
        failure(error);
    }];
}


+ (void)loginRequestPost:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
   NSString *url = [MainUrl stringByAppendingString:urlStr];
   
   AFHTTPRequestOperationManager * manager  = [AFHTTPRequestOperationManager manager];
   NSMutableDictionary * paramsOption = [NSMutableDictionary dictionary];
   paramsOption[@"appKey"] = HuoBanMallAPPKEY;
   paramsOption[@"appSecret"] = HuoBanMallSecretKey;
   NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:HuoBanMallBaiDuCityCode];
   paramsOption[@"cityCode"] = (cityCode.length?cityCode:@"179");
   paramsOption[@"cpaCode"] = @"default";
   paramsOption[@"imei"] = DeviceNo;
   paramsOption[@"operation"] = OPERATION_parame;
   NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallAppToken];
   paramsOption[@"token"] = token?token:@"";
   paramsOption[@"version"] = HuoBanMallAppVersion;
   paramsOption[@"timestamp"] = apptimesSince1970;
   
   if (params != nil) {
      [paramsOption addEntriesFromDictionary:params];
   }
   
   paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];
   [paramsOption removeObjectForKey:@"appSecret"];
//    NSArray * parameaaa = [paramsOption allKeys];
//    NSMutableString * aaa = [[NSMutableString alloc] init];
//    for (NSString * a in parameaaa) {
//        [aaa appendString:[NSString stringWithFormat:@"%@=%@&",a,[paramsOption objectForKey:a]]];
//    }
//    [aaa substringToIndex:aaa.length];
//    NSLog(@"--------------------%@",aaa);
//    NSLog(@"xxxxxx-----网络请求get参数parame%@",paramsOption);
//    NSLog(@"网络请求－－－－post参数%@",paramsOption);
    [manager POST:url parameters:paramsOption success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"-------%@",operation);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
    
}



+ (void)loginRequestPostWithFile:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure withFileKey:(NSString *)key{
    
   NSString *url = [MainUrl stringByAppendingString:urlStr];
   
   AFHTTPRequestOperationManager * manager  = [AFHTTPRequestOperationManager manager];
   NSMutableDictionary * paramsOption = [NSMutableDictionary dictionary];
   paramsOption[@"appKey"] = HuoBanMallAPPKEY;
   paramsOption[@"appSecret"] = HuoBanMallSecretKey;
   NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:HuoBanMallBaiDuCityCode];
   paramsOption[@"cityCode"] = (cityCode.length?cityCode:@"179");
   paramsOption[@"cpaCode"] = @"default";
   paramsOption[@"imei"] = DeviceNo;
   paramsOption[@"operation"] = OPERATION_parame;
   NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:HuoBanMallAppToken];
   paramsOption[@"token"] = token?token:@"";
   paramsOption[@"version"] = HuoBanMallAppVersion;
   paramsOption[@"timestamp"] = apptimesSince1970;
   
   if (params != nil) {
      [paramsOption addEntriesFromDictionary:params];
   }
   
   paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];
   [paramsOption removeObjectForKey:@"appSecret"];

    NSData * data = [[paramsOption objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding];
    [paramsOption removeObjectForKey:key];
//    //    NSArray * parameaaa = [paramsOption allKeys];
//    //    NSMutableString * aaa = [[NSMutableString alloc] init];
//    //    for (NSString * a in parameaaa) {
//    //        [aaa appendString:[NSString stringWithFormat:@"%@=%@&",a,[paramsOption objectForKey:a]]];
//    //    }
//    //    [aaa substringToIndex:aaa.length];
//    //    NSLog(@"--------------------%@",aaa);
//    //    NSLog(@"xxxxxx-----网络请求get参数parame%@",paramsOption);
//    //    NSLog(@"网络请求－－－－post参数%@",paramsOption);
    [manager POST:url parameters:paramsOption constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:data name:key];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
//    [manager POST:url parameters:paramsOption success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"-------%@",operation);
//        success(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        failure(error);
//    }];
    
}
@end
