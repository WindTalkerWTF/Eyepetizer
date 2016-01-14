//
//  FavorViewController.m
//  Eyepetizer
//
//  Created by imac on 15/10/22.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "FavorViewController.h"

@interface FavorViewController () {
    BOOL _shouldHideTabBarWhenPoped;
    VideoListTable *_table;
}

@end

@implementation FavorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"我的收藏"];
    
//    if (self.tabBarController.tabBar.top == kScreenHeight) {
//        _shouldHideTabBarWhenPoped = YES;
//    }
//    else {
//        _shouldHideTabBarWhenPoped = NO;
//    }
    [self hideTabBar:YES animated:YES];
    
    [self _creteTable];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    if (self.tabBarController.tabBar.top == kScreenHeight) {
        _shouldHideTabBarWhenPoped = YES;
    }
    else {
        _shouldHideTabBarWhenPoped = NO;
    }

    [_table reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [self hideTabBar:_shouldHideTabBarWhenPoped animated:YES];

}
- (void)_creteTable {
    
    _table = [[VideoListTable alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    VideoList *videoList = [[VideoList alloc] initWithVideoArray:(NSMutableArray *)[self loadVideoList]];
    
    _table.dailyList = @[videoList];
    
    [self.view addSubview:_table];
    
}
//读取归档对象
- (NSArray *)loadVideoList {
    
    CoreDataManager *manager = [CoreDataManager defaultManager];
    //通过谓词设置查找条件
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELE MATCHES *"];
    
    NSMutableArray *videos = (NSMutableArray *)[manager queryObject:@"Video" predicate:nil];
    
//    NSUInteger count = videos.count;
    NSLog(@"count : %li", videos.count);
    
    //倒序
//    for (int index = 0; index < count / 2; index++) {
//        [videos exchangeObjectAtIndex:index withObjectAtIndex:count-1-index];
//    }
    //输出
    for (int index = 0; index < videos.count; index++) {
        VideoModel *video = videos[index];
        NSLog(@"%@", video.title);
    }
    
    return videos;
}

- (void)createRightButtonItem {
    
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"whiteeye"] forState:UIControlStateNormal];
//    [backButton setBackgroundColor:[UIColor whiteColor]];
    
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteButton];
    
    self.navigationItem.rightBarButtonItem = deleteButtonItem;
    
}
- (void)deleteAction:(UIButton *)button {
    
    CoreDataManager *manager = [CoreDataManager defaultManager];

}
@end
