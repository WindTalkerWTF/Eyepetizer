//
//  VideoModel.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

- (void)setAttributes:(NSDictionary *)dataDic {
    
    [super setAttributes:dataDic];
    
    //videoID，videoDescription与接收属性名不同，手动获取数据
    
    NSString *videoID = [dataDic objectForKey:@"id"];
    if (videoID) {
        _videoID = [videoID copy];
    }
    
    NSString *videoDescription = [dataDic objectForKey:@"description"];
    if (videoDescription) {
        _videoDescription = [videoDescription copy];
    }
    
}

@end
