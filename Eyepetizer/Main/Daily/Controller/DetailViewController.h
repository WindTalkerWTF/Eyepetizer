//
//  DetailViewController.h
//  Eyepetizer
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "ScrollAnimationView.h"
#import "MainScrollView.h"
#import "UIImageView+WebCache.h"

typedef void(^ScrollToFront)(NSInteger section);
typedef void(^ScrollToNext)(NSInteger section);

typedef void(^BackBlock)(NSInteger section, NSInteger row);

@interface DetailViewController : BaseViewController

@property (nonatomic,strong)NSArray *videosArray;  //存放视频的数组

@property (nonatomic, strong)MainScrollView *mainScrollView;    //主体滑动视图

@property (nonatomic, assign)NSUInteger section;    //当前数据的组数
@property (nonatomic, assign)NSUInteger row;    //当前数据的组数

@property (nonatomic, copy)ScrollToFront scrollToFront; //需要加载前一组数据时调用
@property (nonatomic, copy)ScrollToNext scrollToNext;   //需要加载后一组数据时调用

@property (nonatomic, copy)BackBlock backBlock; //pop视图时的返回操作

@end
