//
//  DBManager.h
//  Eyepetizer
//
//  Created by apple on 15/10/5.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"
#import "EGODatabase.h"
#define DataBaseFilePath [NSHomeDirectory() stringByAppendingString:@"/Documents/videosDB.rdb"]

@interface DBManager : NSObject

+ (void)createTable;

+ (void)addVideo:(VideoModel *)video;
+ (void)deleteVideoWithTitle:(NSString *)title;

+ (void)findVideo:(void (^)(NSArray *))completionBlock;

@end
