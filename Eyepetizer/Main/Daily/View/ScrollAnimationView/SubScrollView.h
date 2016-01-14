//
//  SubScrollView.h
//  ScrollAnimation
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>

#define kPositon self.frame.size.width / 2
#define kSpeed -100  //通过此参数设置图片移动方向和速度。（正数表示图片移动方向与滑动方向相反，反之相同。0则表示图片不移动）

@interface SubScrollView : UIScrollView

@property (nonatomic, strong)VideoModel *video;

- (instancetype)initWithFrame:(CGRect)frame video:(VideoModel *)video;

- (void)ScrollByRatio:(CGFloat)ratio;

- (void)shouldZooming:(BOOL)zooming;    //自动缩放动画

@end
