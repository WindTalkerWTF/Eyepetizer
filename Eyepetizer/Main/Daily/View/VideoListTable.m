//
//  VideoListTable.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VideoListTable.h"
#import "DailyViewController.h"

#define kCellIdentifier @"VideoListCell"

@implementation VideoListTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        _dailyList = [NSArray array];
        [self _initTable];
    }
    return self;
}

- (void)_initTable {
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"VideoListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dailyList.count;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    VideoList *videoList = _dailyList[section];
    return videoList.videos.count;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    VideoList *videoList = _dailyList[indexPath.section];
    
    VideoModel *video = videoList.videos[indexPath.row];
    
    cell.video = video;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //进入详情试图
    UIViewController *DailyVC = self.controller;
    
    _detailVC = [[DetailViewController alloc] init];
    
    //填充数据
    VideoList *videoList = _dailyList[indexPath.section];
    _detailVC.section = indexPath.section;
    [_detailVC.mainScrollView setVideos:videoList.videos withCurrentPage:indexPath.row];
    [DailyVC.navigationController pushViewController:_detailVC animated:YES];

    __weak VideoListTable *weakSelf = self;
    //向左加载前一组
    _detailVC.scrollToFront = ^(NSInteger section) {
        [weakSelf ScrollToFront];
    };
    //向右加载后一组
    _detailVC.scrollToNext = ^(NSInteger section) {
        [weakSelf ScrollToNext];
    };
    //返回操作
    _detailVC.backBlock = ^(NSInteger section, NSInteger row) {
        NSIndexPath *backIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
        [weakSelf scrollToRowAtIndexPath:backIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    };
    
    //向下隐藏标签栏
    [(BaseViewController *)self.controller hideTabBar:YES animated:YES];
}
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    
    [super scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    
    
    NSLog(@" row : %li , section : %li", indexPath.row, indexPath.section);
}
- (void)ScrollToFront {
    
    NSInteger section = _detailVC.section;
    [_detailVC.mainScrollView.leftScrollView showLoadingWithText:@"正在加载"];
    if (section > 0) {
        VideoList *videoList = _dailyList[section - 1];
        [_detailVC.mainScrollView setVideos:videoList.videos withCurrentPage:0];
        _detailVC.section--;
        [_detailVC.mainScrollView.leftScrollView stopLoadingWithText:@"加载完毕"];

    }
    else {
        [_detailVC.mainScrollView.leftScrollView stopLoadingWithText:@"已无更多视频"];
        [self performSelector:@selector(ShowNoMoreNewDate) withObject:nil afterDelay:0.6];
    }
    
}
- (void)ShowNoMoreNewDate {
    
    [_detailVC.mainScrollView setContentPage:1 animated:YES];
    
}
- (void)ScrollToNext {
    
    NSInteger section = _detailVC.section;
    [_detailVC.mainScrollView.leftScrollView showLoadingWithText:@"正在加载"];

    if (section >= _dailyList.count - 1) {
        NSLog(@"加载更多-详情");
        [_detailVC.mainScrollView.leftScrollView stopLoadingWithText:@"加载完毕"];
        DailyViewController *dailyVC = (DailyViewController *)self.controller;
        [dailyVC _loadMoreData];
    }
    else {
        [_detailVC.mainScrollView.leftScrollView stopLoadingWithText:@"已无更多视频"];
        VideoList *videoList = _dailyList[section + 1];
        [_detailVC.mainScrollView setVideos:videoList.videos withCurrentPage:0];
        _detailVC.section++;
        
    }
}



//组头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.style == UITableViewStylePlain) {
        return 0;
    }
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.style == UITableViewStylePlain) {
        return nil;
    }
    //计算日期
    VideoList *videos = _dailyList[section];
    NSTimeInterval timeInterval = [videos.date doubleValue] / 1000;
    NSString *dateString = section == 0 ? @"Today" : [Utils dateByTimeIntervl:timeInterval withFormatterStr:@"-MMM.d-"];
    //创建label
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 21)];
    header.text = [NSString stringWithFormat:@"%@", dateString];
    header.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:16.0f];
    header.textAlignment = NSTextAlignmentCenter;
    
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_scrollNextSection) {
        //计算日期
        VideoList *videos = _dailyList[indexPath.section];
        NSTimeInterval timeInterval = [videos.date doubleValue] / 1000;
        NSString *dateString = [Utils dateByTimeIntervl:timeInterval withFormatterStr:@"-MMM.d-"];
        _scrollNextSection(dateString);
    }
    
}

@end
