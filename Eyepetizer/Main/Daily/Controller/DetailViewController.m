//
//  DetailViewController.m
//  Eyepetizer
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()<UIScrollViewDelegate>

@end

@implementation DetailViewController

- (instancetype)init {
    
    if (self = [super init]) {
        [self _createMainScrollView];
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"每日精选"];
        
    [self createButtonItem];
        
}

- (void)_createMainScrollView {
    
    _mainScrollView = [[MainScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) videosArray:_videosArray];
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    if (page == 0) {
        _scrollToFront(_section);
    }
    else if (page == 2) {
        _scrollToNext(_section);
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat ratio = scrollView.contentOffset.x / scrollView.width;
    if (ratio < 1) {
        [_mainScrollView.leftScrollView setContentOffset:CGPointMake(0 - ratio * (_mainScrollView.width / 2), 0)];
    }
    else if (ratio > 1) {
        [_mainScrollView.rightScrollView setContentOffset:CGPointMake(_mainScrollView.width / 2 - (ratio - 1) * (_mainScrollView.width / 2), 0)];
    }

}

- (void)backAction:(UIButton *)button {
    
    [super backAction:button];
    
    NSInteger row = _mainScrollView.midView.currentPage;
    NSInteger section = _section;
    
    _backBlock(section, row);
    
}

@end
