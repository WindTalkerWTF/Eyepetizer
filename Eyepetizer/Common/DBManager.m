//
//  DBManager.m
//  Eyepetizer
//
//  Created by apple on 15/10/5.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

// 创建表
+ (void)createTable {
    
    
    EGODatabase *dataBase = [EGODatabase databaseWithPath:DataBaseFilePath];
    NSLog(@"DataBaseFilePath : %@", DataBaseFilePath);
    //打开数据库
    [dataBase open];
    //SQLite 创建表
    NSString *CreateSql = @"create table if not exists t_videos(category text, videoID text, date text, idx text, coverBlurred text, coverBlurred text, coverForDetail text, coverForFeed text, coverForSharing text, title text, videoDescription text, consumption text, duration text, playUrl text, playInfo text, provider text, rawWebUrl text, webUrl text)";
//    NSString *CreateSql = @"create table if not exists t_videos(coverForDetail text, title text, category text, duration integer, coverBlurred text, videoDescription text, playUrl text)";
    

    BOOL ret = [dataBase executeUpdate:CreateSql];
    if (ret == NO) {
        NSLog(@"创建失败");
        [dataBase close];
        return;
    }
    
    [dataBase close];
}
//添加视频
+ (void)addVideo:(VideoModel *)video {
    
    EGODatabase *dataBase = [EGODatabase databaseWithPath:DataBaseFilePath];
    NSLog(@"%@", DataBaseFilePath);
    
    [dataBase open];
    
    NSString *addSql = @"insert into t_videos(coverForDetail, title, category, duration, coverBlurred, videoDescription, playUrl) values(?, ?, ?, ?, ?, ?, ?)";
    
    NSInteger duration = [video.duration integerValue];
    NSArray *parameters = @[video.coverForDetail, video.title, video.category, @(duration), video.coverBlurred, video.videoDescription, video.playUrl];
    BOOL ret = [dataBase executeUpdate:addSql parameters:parameters];
    if (ret == NO) {
        NSLog(@"添加失败");
        [dataBase close];
        return;
    }
    else {
        NSLog(@"添加成功");
    }
}
+ (void)deleteVideoWithTitle:(NSString *)title {
    
    EGODatabase *dataBase = [EGODatabase databaseWithPath:DataBaseFilePath];
    NSLog(@"%@", DataBaseFilePath);
    
    [dataBase open];
    
    NSString *deleteSql = @"delete from t_videos where title = ?";
    NSArray *parameters = @[title];
    BOOL ret = [dataBase executeUpdate:deleteSql parameters:parameters];
    if (ret == NO) {
        NSLog(@"删除失败");
        [dataBase close];
        return;
    }
    else {
        NSLog(@"删除成功");
    }

    
}
//+ (void)findVideo:(void (^)(NSArray *))completionBlock {
//    
//    EGODatabase *dataBase = [[EGODatabase alloc] initWithPath:DataBaseFilePath];
//    
//    [dataBase open];
//    
//    NSString *sql = @"SELECT * from t_videos";
//    
//    //异步查询
//    EGODatabaseRequest *request = [dataBase requestWithQuery:sql];
//    
//    [request setCompletion:^(EGODatabaseRequest *request, EGODatabaseResult *result, NSError *error) {
//        
//        if (error) {
//            NSLog(@"查询失败：%@", error);
//        }
//        else {
//            
//            //查询成功后回调的block
//            NSMutableArray *videosArray = [NSMutableArray array];
//            
//            for (int i = 0; i<result.count; i++) {
//                
//                //获取当前这一条数据
//                EGODatabaseRow *row = result.rows[i];
//                
//                //创建Model
//                DBVideoModel *video = [[DBVideoModel alloc] init];
//                
//                //获取到当前数据的每个字段的值
//                video.coverForDetail = [row stringForColumnAtIndex:0];
//                video.title = [row stringForColumnAtIndex:1];
//                video.category = [row stringForColumnAtIndex:2];
//                video.duration = [row intForColumnAtIndex:3];
//                video.coverBlurred = [row stringForColumnAtIndex:4];
//                video.videoDescription = [row stringForColumnAtIndex:5];
//                video.playUrl = [row stringForColumnAtIndex:6];
//
//                
//                [videosArray addObject:video];
//                
//            }
//            
//            //回调传入的block
//            completionBlock(videosArray);
//        }
//        
//    }];
//    
//    //创建线程队列，将线程对象加入到队列中执行
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:request];
//    
//    //关闭数据库
//    [dataBase close];
//    
//    
//}
@end
