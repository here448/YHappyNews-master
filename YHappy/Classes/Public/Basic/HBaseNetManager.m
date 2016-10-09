//
//  HBaseNetManager.m
//  YHappy
//
//  Created by hare27 on 16/6/19.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import "HBaseNetManager.h"
#import <AFNetworking.h>

static AFHTTPSessionManager *manager = nil;

@implementation HBaseNetManager

+ (AFHTTPSessionManager *)sharedNetManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    });
    return manager;
}

+ (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    HLog(@"%@",[self absoluteForPath:path andParams:params]);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [[self sharedNetManager] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        complete(nil,error);
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    HLog(@"%@",[self absoluteForPath:path andParams:params]);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    return [[self sharedNetManager] POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complete(responseObject,nil);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        complete(nil,error);
    }];
}

/** 转换字符串*/
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params{
    
    return [[self absoluteForPath:path andParams:params] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

/** 拼接全路径*/
+ (NSString *)absoluteForPath:(NSString *)path andParams:(NSDictionary *)params{
    NSMutableString *absolutePath =[NSMutableString stringWithString:path];
    NSArray *keys = params.allKeys;
    NSInteger count = keys.count;
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            [absolutePath appendFormat:@"?%@=%@", keys[i], params[keys[i]]];
        }else{
            [absolutePath appendFormat:@"&%@=%@", keys[i], params[keys[i]]];
        }
    }
    return absolutePath;
}

@end
