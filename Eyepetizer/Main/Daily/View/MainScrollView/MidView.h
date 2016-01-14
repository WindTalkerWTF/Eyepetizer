//
//  MidView.h
//  Eyepetizer
//
//  Created by imac on 15/10/4.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollAnimationView.h"
#import "TextArea.h"

#define kAlpha 0.5

@interface MidView : UIView <UIScrollViewDelegate> {
    
    //三层背景，用于产生渐变效果
    UIImageView *_leftBGView;
    UIImageView *_midBGView;
    UIImageView *_rightBGView;

}

@property (nonatomic, strong)NSArray *videosArray;  //存放视频的数组
@property (nonatomic, assign)NSInteger currentPage; //当前组的页数

@property (nonatomic, strong)ScrollAnimationView *midScrollView;    //视频图片展示的滑动视图

@property (nonatomic, strong)TextArea *textAreaView;    //下方文本区域

@property (strong, nonatomic)UIView *pageIndicator;         //页码指示条
@property (strong, nonatomic)UILabel *pageIndicatorLabel;   //页码label
@property (strong, nonatomic)UIView *pageTrack;

//初始化方法，并设置视频数据
- (instancetype)initWithFrame:(CGRect)frame withVideos:(NSArray *)videos;

//重置数据并定位到指定的页数
- (void)setVideosArray:(NSArray *)videosArray withPage:(NSInteger)page;

@end
