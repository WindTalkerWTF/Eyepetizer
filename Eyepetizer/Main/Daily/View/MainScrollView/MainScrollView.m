//
//  MainScrollView.m
//  Eyepetizer
//
//  Created by imac on 15/10/3.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MainScrollView.h"
#define kSelf_Width self.frame.size.width
#define kSelf_Height self.frame.size.height

@interface MainScrollView ()<UIScrollViewDelegate> 

@end

@implementation MainScrollView

- (instancetype)initWithFrame:(CGRect)frame videosArray:(NSArray *)videos{
    
    if (self = [super initWithFrame:frame]) {
        
        _videosArray = videos;
        
        [self _initScrollView];
        
        [self _createSubviews];
        
    }
    
    return self;
}
//初始化
- (void)_initScrollView {
    [self setUserInteractionEnabled:YES];
    [self setPagingEnabled:YES];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setContentSize:CGSizeMake(self.width * 3, 0)];
    [self setContentOffset:CGPointMake(self.width, 0) animated:NO];
    
}
//创建左中右三个子视图
- (void)_createSubviews {
    //中建视图
    _midView = [[MidView alloc] initWithFrame:CGRectMake(self.width * 1, 0, self.width, self.height) withVideos:_videosArray];
    _midView.videosArray = _videosArray;
    [self addSubview:_midView];

    
    
    _leftScrollView = [[LoadingScrollView alloc] initWithFrame:CGRectMake(self.width * 0, 0, self.width, self.height)];
    _rightScrollView = [[LoadingScrollView alloc] initWithFrame:CGRectMake(self.width * 2, 0, self.width, self.height)];
    [self addSubview:_leftScrollView];
    [self addSubview:_rightScrollView];
    
}

- (void)setVideos:(NSArray *)videos withCurrentPage:(NSInteger)page {
    
    [self setVideosArray:videos];
    
    [_midView setVideosArray:videos withPage:page];
    
    [self setContentOffset:CGPointMake(self.width, 0) animated:YES];
}

- (void)setContentPage:(NSInteger)page animated:(BOOL)animated {
    
    [self setContentOffset:CGPointMake(page * self.width, 0) animated:animated];
    
}

#pragma mark - UIScrollViewDelegate

@end
