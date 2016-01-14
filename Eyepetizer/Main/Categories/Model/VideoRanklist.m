//
//  VideoRanklist.m
//  Eyepetizer
//
//  Created by imac on 15/10/5.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VideoRanklist.h"

@implementation VideoRanklist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super init]) {
        
        NSArray *videos = [dictionary objectForKey:@"videoList"];
        [self setVideoListWithArray:videos];
    }
    return self;
}

//设置每组的视频列表
- (void)setVideoListWithArray:(NSArray *)array {
    _videos = [NSMutableArray array];
    for (NSDictionary *videoDic in array) {
        VideoModel *video = [[VideoModel alloc] initWithDataDic:videoDic];
        [_videos addObject:video];
    }
}

@end
