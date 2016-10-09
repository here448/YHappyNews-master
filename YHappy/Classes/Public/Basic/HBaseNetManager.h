//
//  HBaseNetManager.h
//  YHappy
//
//  Created by hare27 on 16/6/19.
//  Copyright © 2016年 hare27. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBaseNetManager : NSObject

+ (NSURLSessionDataTask *)GET:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;

+ (NSURLSessionDataTask *)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;

/** 转换字符串*/
+ (NSString *)percentPathWithPath:(NSString *)path params:(NSDictionary *)params;

@end
