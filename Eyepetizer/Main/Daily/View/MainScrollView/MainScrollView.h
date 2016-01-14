//
//  MainScrollView.h
//  Eyepetizer
//
//  Created by imac on 15/10/3.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollAnimationView.h"
#import "MidView.h"
#import "TextArea.h"
#import "LoadingScrollView.h"
@interface MainScrollView : UIScrollView

@property (nonatomic, strong)NSArray *videosArray;  //存放视频的数组

@property (nonatomic, strong)MidView *midView;  //中间数据展示视图

@property (nonatomic, strong)LoadingScrollView *leftScrollView;     //左侧加载视图
@property (nonatomic, strong)LoadingScrollView *rightScrollView;    //右侧加载视图


- (instancetype)initWithFrame:(CGRect)frame videosArray:(NSArray *)videos;

- (void)setVideos:(NSArray *)videos withCurrentPage:(NSInteger)page;

- (void)setContentPage:(NSInteger)page animated:(BOOL)animated;

@end
