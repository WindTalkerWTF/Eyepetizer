//
//  EventsBrowsViewController.m
//  Eyepetizer
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import "VideosRankViewController.h"

@interface VideosRankViewController () {
    
    UIView *_rankTypeView;  // 分类视图
    
    VideoListTable *_tableView; // 展示视图
    
    NSMutableArray *_dailyList;
    NSString *_nextPageUrlStr;
}
@end

@implementation VideosRankViewController

#pragma mark - 视图方法

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setTitle:_category];
    
    [self createRightButtonItem];
    
    [self _createViews];
    
    [self _loadDateData];

}

#pragma mark - 创建视图
- (void)_createViews {
    [self _createTable];
    [self _createTypeView];
    
}
- (void)_createTypeView {

    NSArray *titles = @[@"按时间排序", @"按分享排序"];
    BaseTabBar *typeBar = [[BaseTabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titles:titles];
    typeBar.backgroundColor = [UIColor whiteColor];
    typeBar.buttonAction = ^(NSInteger buttonIndex){
        // 按时间分类
        if (buttonIndex == 0) {
            [self _loadDateData];
        }
        // 按分享分类
        else if(buttonIndex == 1) {
            [self _loadShareData:_category];
        }
    };
    [self.view addSubview:typeBar];
    
}

- (void)_createTable {
    
    _tableView = [[VideoListTable alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadDateData)];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];

    [self.view addSubview:_tableView];
    
}

#pragma mark - 加载数据
// 点击某个分类选项，该分类中的数据并push
- (void)_loadDateData {
    
    // 默认进入是加载按时间排序的页面
    //http://baobab.wandoujia.com/api/v1/videos?num=10&categoryName=%E5%89%A7%E6%83%85&strategy=date&vc=125&t=&u=213367ae25cb8116060ddbd038303c56853d00ea&net=wifi&v=1.8.1&f=iphone
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v1/videos";
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"10" forKey:@"num"];
    [params setObject:_category forKey:@"categoryName"];
    [params setObject:@"date" forKey:@"strategy"];
    [params setObject:@"125" forKey:@"vc"];
    [params setObject:@"" forKey:@"t"];
    [params setObject:@"213367ae25cb8116060ddbd038303c56853d00ea" forKey:@"u"];
    [params setObject:@"wifi" forKey:@"net"];
    [params setObject:@"1.8.1" forKey:@"v"];
    [params setObject:@"iphone" forKey:@"f"];

    [DataService requestAFUrl:urlStr httpMethod:kGET params:params data:nil block:^(id result) {
        
        _dailyList = [NSMutableArray array];
        
        [self _loadDataWithResult:result];
        
    }];
}
//加载分享排行数据
- (void)_loadShareData:(NSString *)categoryStr {
    
    //http://baobab.wandoujia.com/api/v1/videos?num=10&categoryName=%E5%89%A7%E6%83%85&strategy=shareCount&vc=125&t=&u=213367ae25cb8116060ddbd038303c56853d00ea&net=wifi&v=1.8.1&f=iphone
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v1/videos";
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"10" forKey:@"num"];
    [params setObject:categoryStr forKey:@"categoryName"];
    [params setObject:@"shareCount" forKey:@"strategy"];
    [params setObject:@"125" forKey:@"vc"];
    [params setObject:@"" forKey:@"t"];
    [params setObject:@"213367ae25cb8116060ddbd038303c56853d00ea" forKey:@"u"];
    [params setObject:@"wifi" forKey:@"net"];
    [params setObject:@"1.8.1" forKey:@"v"];
    [params setObject:@"iphone" forKey:@"f"];
    
    [DataService requestAFUrl:urlStr httpMethod:kGET params:params data:nil block:^(id result) {
        
        _dailyList = [NSMutableArray array];
        
        [self _loadDataWithResult:result];
        
    }];
}
//下拉加载更多数据
- (void)_loadMoreData {
    
    // 后面没有数据了
    if ([_nextPageUrlStr isKindOfClass:[NSNull class]]) {
        [_tableView.footer endRefreshing];
        return;
        
    }
    [DataService requestAFUrl:_nextPageUrlStr httpMethod:@"GET" params:nil data:nil block:^(id result) {
        
        [self _loadDataWithResult:result];
        
    }];
    
    [_tableView.footer endRefreshing];
}
//数据填充方法
- (void)_loadDataWithResult:(id)result {
    
    _nextPageUrlStr = [result objectForKey:@"nextPageUrl"];
    
    VideoList *list = [[VideoList alloc] initWithDictionary:result];
    [_dailyList addObject:list];
    
    _tableView.dailyList = _dailyList;
    [_tableView reloadData];

}

@end
