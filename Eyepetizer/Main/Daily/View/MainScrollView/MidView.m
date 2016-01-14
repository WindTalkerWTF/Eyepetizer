//
//  MidView.m
//  Eyepetizer
//
//  Created by imac on 15/10/4.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MidView.h"

@implementation MidView

- (instancetype)initWithFrame:(CGRect)frame withVideos:(NSArray *)videos{
    if (self = [super initWithFrame:frame]) {
        _videosArray = videos;

        [self _createSubviews];
        [self createPageIndicator];
        self.backgroundColor = [UIColor blackColor];

    }
    return self;
}

- (void)_createSubviews {
    //创建三层背景视图
    _midBGView = [[UIImageView alloc] initWithFrame:self.bounds];
    _leftBGView = [[UIImageView alloc] initWithFrame:self.bounds];
    _rightBGView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    _midBGView.alpha = kAlpha;
    _leftBGView.alpha = 0.0;
    _rightBGView.alpha = 0.0;
    
    [self addSubview:_midBGView];
    [self addSubview:_leftBGView];
    [self addSubview:_rightBGView];

    //创建文本区域
    _textAreaView = [[TextArea alloc] initWithFrame:CGRectMake(0, kScreenHeight / 2, self.width, self.height - 64 - kScreenHeight / 2)];
    _textAreaView.backgroundColor = [UIColor clearColor];
    [self addSubview:_textAreaView];
    
    //创建顶部滑动视图，要置于文本区域上方
    _midScrollView = [[ScrollAnimationView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 100) videosArray:_videosArray];
    _midScrollView.delegate = self;
    _midScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_midScrollView];
    

}
- (void)createPageIndicator {
    
    _pageIndicator = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_pageIndicator];
    
    //创建指示条上面的页码
    _pageIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _pageIndicatorLabel.textAlignment = NSTextAlignmentCenter;
    _pageIndicatorLabel.textColor = [UIColor whiteColor];
    _pageIndicatorLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:10];
    [_pageIndicator addSubview:_pageIndicatorLabel];
    
    //创建指示条
    _pageTrack = [[UIView alloc] initWithFrame:CGRectZero];
    _pageTrack.backgroundColor = [UIColor whiteColor];
    [_pageIndicator addSubview:_pageTrack];
    
}

//复写setter方法，数据改变时重置布局
- (void)setVideosArray:(NSArray *)videosArray withPage:(NSInteger)page {
    
    if (_videosArray != videosArray) {
        _videosArray = videosArray;
        _currentPage = page;
        
        //改变文本区域的数据
        [_textAreaView setVideo:_videosArray[_currentPage]];
        //改变滑动视图的数据，并滑动到指定页
        [_midScrollView setVideos:videosArray];
        [_midScrollView setContentOffset:CGPointMake(_midScrollView.width * _currentPage, 0) animated:NO];
        //设置底部页码指示条的位置
        CGFloat width = kScreenWidth / _videosArray.count;
        _pageIndicator.frame = CGRectMake(width * _currentPage, (kScreenHeight - 64) - 20, kScreenWidth / _videosArray.count, 20);
        _pageIndicatorLabel.frame = CGRectMake(_pageIndicator.width / 2 - 15, 0, 30, 18);
        _pageIndicatorLabel.text = [NSString stringWithFormat:@"%li - %li",_currentPage + 1,_videosArray.count];
        _pageTrack.frame = CGRectMake(0, 18, width, 2);
        //设置背景
        [self setBGView];
    }
}
//重置三层背景视图
- (void)setBGView {
    
    VideoModel *midVideo = _videosArray[_currentPage];
    [_midBGView sd_setImageWithURL:[NSURL URLWithString:midVideo.coverBlurred]];
    
    if (_currentPage > 0 ) {
        VideoModel *leftVideo = _videosArray[_currentPage - 1];
        [_leftBGView sd_setImageWithURL:[NSURL URLWithString:leftVideo.coverBlurred]];
    }
    
    if (_currentPage < _videosArray.count - 1) {
        VideoModel *rightVideo = _videosArray[_currentPage + 1];
        [_rightBGView sd_setImageWithURL:[NSURL URLWithString:rightVideo.coverBlurred]];
    }
    
    _leftBGView.alpha = 0.0;
    _midBGView.alpha = kAlpha;
    _rightBGView.alpha = 0.0;

}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //设置滑动视图的子滑动视图偏移量，实现滑动动画
    CGFloat ratio = scrollView.contentOffset.x / scrollView.width;
    for (int i = 0; i < _videosArray.count; i++) {

        if (ratio > i - 1 && ratio < i + 1) {
            SubScrollView *subview = (SubScrollView *)[_midScrollView viewWithTag:10 + i];
            [subview ScrollByRatio:-ratio + i];
            
        }
    }
    
    //背景透明度的渐变效果
    //滑动的相对比例，从 -1 至 1（有系统误差）
    CGFloat relativeOffSet = (scrollView.contentOffset.x - _currentPage ) / kScreenWidth - _currentPage;
    // 向左移动
    if (relativeOffSet < 0) {
//        NSLog(@"%f", - relativeOffSet * kAlpha);
        _midBGView.alpha = (1 + relativeOffSet ) * kAlpha;
        _leftBGView.alpha = - relativeOffSet * kAlpha;
    }
    // 向右移动
    else {
//        NSLog(@"%f", relativeOffSet * kAlpha);
        _midBGView.alpha = (1 - relativeOffSet ) * kAlpha;
        _rightBGView.alpha = relativeOffSet * kAlpha;
    }

    //设置页码指示条位置
    CGFloat pageIndicatorLocation = scrollView.contentOffset.x / scrollView.contentSize.width * kScreenWidth;
    _pageIndicator.left = pageIndicatorLocation;

    
}
//滑动停止时开始缩放动画
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat ratio = offset.x / scrollView.width;
    
    _currentPage = (NSInteger)ratio;
    
    VideoModel *video = _videosArray[_currentPage];
    
    [_textAreaView setVideo:video];

    _pageIndicatorLabel.text = [NSString stringWithFormat:@"%li - %li",_currentPage + 1,_videosArray.count];

    [self setBGView];
}

@end
