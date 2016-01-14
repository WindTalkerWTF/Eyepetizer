//
//  VideoRanklist.h
//  Eyepetizer
//
//  Created by imac on 15/10/5.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"
#import "VideoModel.h"
@interface VideoRanklist : BaseModel

@property (nonatomic, copy)NSString *count;
@property (nonatomic, copy)NSString *nextPageUrl;

@property (nonatomic, strong)NSMutableArray *videos;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
