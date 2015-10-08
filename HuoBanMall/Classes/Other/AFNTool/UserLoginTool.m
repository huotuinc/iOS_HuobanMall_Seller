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
#import <MKNetworkKit.h>

@interface UserLoginTool()

@end



@implementation UserLoginTool

+ (void)loginRequestGet:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
   NSString *url = [MainUrl stringByAppendingPathComponent:urlStr];
    
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
//   paramsOption[@"token"] = @"";
   paramsOption[@"version"] = HuoBanMallAppVersion;
   paramsOption[@"timestamp"] = apptimesSince1970;
   
   if (params != nil) {
      [paramsOption addEntriesFromDictionary:params];
   }
   
   paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];
   [paramsOption removeObjectForKey:@"appSecret"];

    [manager GET:url parameters:paramsOption success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",operation);
        success(responseObject);
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",operation);
        failure(error);
    }];
}


+ (void)loginRequestPost:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
   NSString *url = [MainUrl stringByAppendingPathComponent:urlStr];
   
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
        NSLog(@"-------%@",operation);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
    
}



+ (void)loginRequestPostWithFile:(NSString *)urlStr parame:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure withFileKey:(NSString *)key{
    
   NSString *url = [MainUrl stringByAppendingPathComponent:urlStr];
   
//   AFHTTPRequestOperationManager * manager  = [AFHTTPRequestOperationManager manager];
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
//
   
   NSData *data = [[paramsOption objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding];
   NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   [paramsOption removeObjectForKey:key];
//
   paramsOption[@"profileData"] = str;
   
   paramsOption[@"sign"] = [NSDictionary asignWithMutableDictionary:paramsOption];
   [paramsOption removeObjectForKey:@"appSecret"];
   
   MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:MainUrlMK customHeaderFields:nil];
   
   MKNetworkOperation *op = [engine operationWithPath:urlStr params:paramsOption httpMethod:@"POST"];
   
   [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
      success(completedOperation.responseJSON);
   } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
      failure(error);
   }];
   
   [engine enqueueOperation:op];
//   NSData * data = [[paramsOption objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding];
   

//   NSLog(@"%@",paramsOption);
//   [paramsOption removeObjectForKey:@"profileData"];
 
//   [manager POST:url parameters:paramsOption constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//      [formData appendPartWithFormData:data name:@"profileData"];
//   } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//      NSLog(@"%@",operation);
//      success(responseObject);
//        
//   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//      NSLog(@"%@",error.description);
//      failure(error);
//   }];

    
}
@end
