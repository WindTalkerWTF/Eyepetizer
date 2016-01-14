//
//  CategoriesViewController.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController () {
    
    CategoriesCollectionView *_collectionView;  // 表格视图
    
    NSMutableArray *_dataArray; // 数据
    
    UIView *_menuView;
}
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Eyepetizer"];

    [self _createCollectionView];
    
    [self createButtonItem];
    
    [self _loadData];
}
#pragma mark - 创建视图
- (void)_createCollectionView {
    
    _collectionView = [[CategoriesCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
    [self.view addSubview:_collectionView];

}

#pragma mark - 加载数据
// 加载分类列表的数据
- (void)_loadData {
    
    //     往期分类接口：http://baobab.wandoujia.com/api/v1/categories?vc=125&u=213367ae25cb8116060ddbd038303c56853d00ea&v=1.8.1&f=iphone
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"125" forKey:@"vc"];
    [params setObject:@"213367ae25cb8116060ddbd038303c56853d00ea" forKey:@"u"];
    [params setObject:@"1.8.1" forKey:@"v"];
    [params setObject:@"iphone" forKey:@"f"];
    NSString *urlString = @"http://baobab.wandoujia.com/api/v1/categories";
    
    [DataService requestAFUrl:urlString httpMethod:kGET params:params data:nil block:^(id result) {
        
        _dataArray = [NSMutableArray array];
        
        for (NSDictionary *dictionary in result) {
            
            CategoriesListModel *categories = [[CategoriesListModel alloc] initWithDataDic:dictionary];
           
            [_dataArray addObject:categories];
            
            
        }
        
        _collectionView.categoriesArray = _dataArray;
        // 数据加载完成刷新视图
        [_collectionView reloadData];
    }];
    
}



@end
