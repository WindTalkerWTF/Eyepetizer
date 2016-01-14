//
//  ScrollAnimationView.m
//  ScrollAnimation
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "ScrollAnimationView.h"

#define kSelf_Width self.frame.size.width
#define kSelf_Height self.frame.size.height

@interface ScrollAnimationView () <UIScrollViewDelegate>

@end

@implementation ScrollAnimationView

- (instancetype)initWithFrame:(CGRect)frame
                    videosArray:(NSArray *)videos {
    
    if (self = [super initWithFrame:frame]) {
        
        _videos = videos;
        
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
    
    [self setContentSize:CGSizeMake(_videos.count * kSelf_Width, 0)];

    //上划pop手势
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipAction:)];
    swipGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipGesture];
}
- (void)swipAction:(UIGestureRecognizer *)gesture {
    [self.controller.navigationController popViewControllerAnimated:YES];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.controller.navigationController.tabBarController.tabBar.bottom = kScreenHeight;
    }];
    //显示标签栏

}

//创建子 滑动视图
- (void)_createSubviews {
    
    for (int index = 0; index < _videos.count; index++) {
        
        [self _createSubViewWithIndex:index];
    }
    
}
- (SubScrollView *)_createSubViewWithIndex:(NSInteger)index {
    
    SubScrollView *subview = [[SubScrollView alloc] initWithFrame:CGRectMake(index * kSelf_Width, 0, kSelf_Width, kScreenHeight / 2) video:_videos[index]];
    subview.tag = 10 + index;
    [subview ScrollByRatio:0];
    [self addSubview:subview];
    
    return subview;
}

//重写 video 的setter 方法
- (void)setVideos:(NSArray *)videos {
    if (_videos != videos) {
        _videos = videos;
        [self setContentSize:CGSizeMake(_videos.count * kSelf_Width, 0)];
        for (int i = 0; i < _videos.count; i++) {
            //设置滑动视图
            SubScrollView *subview = (SubScrollView *)[self viewWithTag:10 + i];
            if (subview == nil) {
                subview = [self _createSubViewWithIndex:i];
            }
            [subview setVideo:_videos[i]];
        }
    }
    
}
//#pragma mark - UIScrollViewDelegate
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    CGFloat ratio = scrollView.contentOffset.x / kSelf_Width;
//    
//    for (int i = 0; i < _videos.count; i++) {
////        NSLog(@"nonononono");
//        if (ratio > i - 1 && ratio < i + 1) {
//            SubScrollView *subview = (SubScrollView *)[self viewWithTag:10 + i];
////            [subview shouldZooming:NO];
//            [subview ScrollByRatio:-ratio + i];
//        }
//    }
//}
////滑动停止时开始缩放动画
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    
//    CGPoint offset = scrollView.contentOffset;
//    
//    CGFloat ratio = offset.x / scrollView.width;
//
//    _didDecelerate((NSInteger)ratio);
//    
////    CGFloat ratio = scrollView.contentOffset.x / kSelf_Width;
////    
////    for (int i = 0; i < _videos.count; i++) {
//////        NSLog(@"yesyesyesyes");
////        if (ratio > i - 1 && ratio < i + 1) {
////            SubScrollView *subview = (SubScrollView *)[self viewWithTag:10 + i];
////            [subview shouldZooming:YES];
////        }
////    }
//
//    
//}

@end
