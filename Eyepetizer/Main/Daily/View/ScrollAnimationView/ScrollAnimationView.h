//
//  ScrollAnimationView.h
//  ScrollAnimation
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubScrollView.h"

typedef void(^DidEndDecelerate)(NSInteger page);

@interface ScrollAnimationView : UIScrollView

@property (nonatomic, strong)NSArray *videos;   //图片数组

@property (nonatomic, copy)DidEndDecelerate didDecelerate;

- (instancetype)initWithFrame:(CGRect)frame
                  videosArray:(NSArray *)videos;

//- (void)SetSubViewsPositionWithOffset:(CGPoint)offset;

@end
