//
//  DailyViewController.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DailyViewController.h"

@interface DailyViewController (){
    
    NSMutableArray *_dailyList;//视频列表数组
    
    NSString *_nextPageUrlStr;         //下一页的URL
    
    VideoListTable *_tableView;
}


@end

@implementation DailyViewController

- (void)viewWillAppear:(BOOL)animated {
    
    //显示标签栏
    [UIView animateWithDuration:0.3 animations:^{
        self.tabBarController.tabBar.bottom = kScreenHeight;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Eyepetizer"];
    self.isListVC = YES;
    [self createButtonItem];
    
    [self _loadData];
    
    [self _createTable];
}
- (void)_createTable {
    
    _tableView = [[VideoListTable alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.dailyList = _dailyList;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadData)];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];

    __weak DailyViewController *weakSelf = self;
    _tableView.scrollNextSection = ^(NSString *dateString) {
        
        if (weakSelf.dateLabel.text != dateString) {
            weakSelf.dateLabel.text = dateString;
        }
    };
    
    [self.view addSubview:_tableView];
}

- (void)_loadData {
    
//    http://baobab.wandoujia.com/api/v1/feed?num=10&date=20150929&vc=125&u=213367ae25cb8116060ddbd038303c56853d00ea&v=1.8.1&f=iphone
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"10" forKey:@"num"];
    [params setObject:@"20190931" forKey:@"date"];
    [params setObject:@"125" forKey:@"vc"];
    [params setObject:@"213367ae25cb8116060ddbd038303c56853d00ea" forKey:@"u"];
    [params setObject:@"1.8.1" forKey:@"v"];
    [params setObject:@"iphone" forKey:@"f"];
    
    //请求网络
    [DataService requestAFUrl:@"http://baobab.wandoujia.com/api/v1/feed" httpMethod:kGET params:params data:nil block:^(id result) {
        
        _dailyList = [NSMutableArray array];

        [self _loadDataWithResult:result];
        
        [_tableView.header endRefreshing];
    }];
    
}
//下拉加载更多数据
- (void)_loadMoreData {
    
    // 后面没有数据了
    if ([_nextPageUrlStr isKindOfClass:[NSNull class]]) {
        [_tableView.footer endRefreshing];
        return;
        
    }
    [DataService requestAFUrl:_nextPageUrlStr httpMethod:kGET params:nil data:nil block:^(id result) {
        
        [self _loadDataWithResult:result];
        [_tableView ScrollToNext];
        
        [_tableView.footer endRefreshing];
    }];
    
}
- (void)_loadDataWithResult:(id)result {
    
    _nextPageUrlStr = [result objectForKey:@"nextPageUrl"];
    NSArray *array = [result objectForKey:@"dailyList"];
    
    for (NSDictionary *listDic in array) {
        VideoList *list = [[VideoList alloc] initWithDictionary:listDic];
        [_dailyList addObject:list];
    }
    
    _tableView.dailyList = _dailyList;
    [_tableView reloadData];
    
}

//push默认高度下的视图
- (void)pushViewController {
    CGPoint point = CGPointMake(0, 150);
    point = [_tableView convertPoint:point fromView:self.view.window];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:point];
    [_tableView tableView:_tableView didSelectRowAtIndexPath:indexPath];
}


@end
