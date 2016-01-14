//
//  DataService.m
//  微博-01
//
//  Created by imac on 15/9/26.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import "DataService.h"
#import "JSONKit.h"
@implementation DataService


+ (void)requestUrl:(NSString *)urlString
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
             block:(Completion)block {
    
    
    //1. 构建URL
    NSString *completeUrlString = [kBaseUrl stringByAppendingString:urlString];
    NSURL *completeUrl = [NSURL URLWithString:completeUrlString];
    
    
    //2. 构造request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:completeUrl];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:method];
    
    
    //3. 拼接参数
    NSMutableString *paramsString = [NSMutableString string];
    NSArray *keysArray = [params allKeys];
    
    for (int index = 0; index < keysArray.count; index++) {
        
        NSString *key = keysArray[index];
        NSString *value = [params objectForKey:key];
        [paramsString appendFormat:@"%@=%@",key, value];
        
        if (index < keysArray.count - 1) {
            [paramsString appendString:@"&"];
        }
        
    }
    
    
    //GET请求，把参数放到URL里面
    if ([method isEqualToString:kGET]) {
        NSString *seperation = completeUrl.query ? @"&" : @"?";
        NSString *appendedUrlString = [NSString stringWithFormat:@"%@%@%@", completeUrlString, seperation, paramsString];
        
        request.URL = [NSURL URLWithString:appendedUrlString];
    }
    //POST请求，把参数放到请求体中
    else {
        NSData *data = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    
    //4. 建立connection连接
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"连接失败");
        }
        id result = [data objectFromJSONData];
        block(result);
    }];
    
}



+ (AFHTTPRequestOperation *)requestAFUrl:(NSString *)urlString
                              httpMethod:(NSString *)method
                                  params:(NSMutableDictionary *)params
                                    data:(NSMutableDictionary *)datasDic
                                   block:(Completion)block {
    
    //1. 构建URL
    NSString *completeUrlString = [kBaseUrl stringByAppendingString:urlString];
    
    
    //2. 构建请求进程manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置responseSerializer
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    
    //3. 发送请求
    AFHTTPRequestOperation *operation = nil;
    //GET请求
    if ([method isEqualToString:kGET]) {
        
        operation = [manager GET:completeUrlString parameters:params success:^(AFHTTPRequestOperation *operation, id result) {
            block(result);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (error) {
                NSLog(@"请求失败 error:%@", error);
            }
        }];
        
    }
    //POST请求
    else if ([method isEqualToString:kPOST]) {
        //带有图片数据
        if (datasDic != nil) {
            operation  = [manager POST:completeUrlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                //拼接请求体
                for (NSString *key in datasDic) {
                    NSData *data = [datasDic objectForKey:key];
                    [formData appendPartWithFileData:data name:key fileName:@"1.png" mimeType:@"image/jpeg"];
                }
                
                
            } success:^(AFHTTPRequestOperation *operation, id result) {
                
                NSLog(@"上传成功");
                block(result);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"上传失败 error: %@", error);
            }];
        }
        //不带图片数据
        else {
            
            operation = [manager POST:completeUrlString parameters:params success:^(AFHTTPRequestOperation *operation, id result) {
                NSLog(@"上传成功");
                block(result);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"上传失败 error: %@", error);
            }];
        }
        
    }
    
    return operation;
}


//#pragma mark - 微博请求
////本地获取accessToken
//+ (NSString *)getAccessTokenKey {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *sinaWeiboAuthData = [defaults objectForKey:@"SinaWeiboAuthData"];
//    NSString *accessTokenKey = [sinaWeiboAuthData objectForKey:@"AccessTokenKey"];
//    return accessTokenKey;
//}
////获取微博列表
//+ (void)getHomeList:(NSMutableDictionary *)params
//              block:(Completion)block {
//    
//    NSString *accessTokenKey = [DataService getAccessTokenKey];
//    [params setObject:accessTokenKey forKey:@"access_token"];
//    
//    [DataService requestAFUrl:kHomeTimeline httpMethod:@"GET" params:params data:nil block:block];
//    
//}
//
////发送微博
//+ (void)sendWeibo:(NSMutableDictionary *)params
//            block:(Completion)block {
//    
//    NSString *accessTokenKey = [DataService getAccessTokenKey];
//    [params setObject:accessTokenKey forKey:@"access_token"];
//    
//    [DataService requestAFUrl:kSendWeibo httpMethod:@"POST" params:params data:nil block:block];
//}
//
//+ (AFHTTPRequestOperation *)sendWeibo:(NSString *)text
//                                image:(UIImage *)image
//                                block:(Completion)block {
//    
//    if (text == nil && image == nil) {
//        return nil;
//    }
//    if (text.length > 140) {
//        NSLog(@"微博字数超过140");
//    }
//    NSString *accessTokenKey = [DataService getAccessTokenKey];
//    AFHTTPRequestOperation *operation = nil;
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:text forKey:@"status"];
//    [params setObject:accessTokenKey forKey:@"access_token"];
//
//    
//    if (image) {
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//        [dataDic setObject:imageData forKey:@"pic"];
//        
//        operation = [DataService requestAFUrl:kSendWeiboWithImage httpMethod:kPOST params:params data:dataDic block:block];
//    }
//    else {
//        operation = [DataService requestAFUrl:kSendWeibo httpMethod:kPOST params:params data:nil block:block];
//    }
//    
//    return operation;
//}


@end
