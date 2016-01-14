//
//  VideoList.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"
@interface VideoList : BaseModel

//每日精选模型数据
@property (nonatomic, copy)NSString *date;
@property (nonatomic, copy)NSString *total;

//视频排行模型数据
@property (nonatomic, copy)NSString *count;
@property (nonatomic, copy)NSString *nextPageUrl;

@property (nonatomic, strong)NSMutableArray *videos;

//将视频VideoModel数组包装成VideoList模型
- (instancetype)initWithVideoArray:(NSMutableArray *)videos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
