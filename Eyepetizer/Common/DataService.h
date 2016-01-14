//
//  DataService.h
//  微博-01
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

#define kBaseUrl    @""
#define kGET        @"GET"
#define kPOST       @"POST"

typedef void(^Completion)(id result);

@interface DataService : NSObject

+ (void)requestUrl:(NSString *)urlString    //url
        httpMethod:(NSString *)method       //GET  POST
            params:(NSMutableDictionary *)params //参数
             block:(Completion)block;       //接收到的数据的处理



+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
                              httpMethod:(NSString *)method
                                  params:(NSMutableDictionary *)params //token  文本
                                    data:(NSMutableDictionary *)datas //文件
                                   block:(Completion)block;

////获取微博AccessToken
//+ (NSString *)getAccessTokenKey;
//
////获取微博列表
//+ (void)getHomeList:(NSMutableDictionary *)params
//              block:(Completion)block;
//
////发送微博
//+ (void)sendWeibo:(NSMutableDictionary *)params
//            block:(Completion)block;
//
//
//+ (AFHTTPRequestOperation *)sendWeibo:(NSString *)text
//                                image:(UIImage *)image
//                                block:(Completion)block;

@end
