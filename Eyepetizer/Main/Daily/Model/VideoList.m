//
//  VideoList.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VideoList.h"

@implementation VideoList

- (instancetype)initWithVideoArray:(NSMutableArray *)videos {
    if (self = [super init]) {
        _videos = videos;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (self = [super initWithDataDic:dictionary]) {
        
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
