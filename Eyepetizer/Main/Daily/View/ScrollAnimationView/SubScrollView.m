//
//  SubScrollView.m
//  ScrollAnimation
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "SubScrollView.h"


@interface SubScrollView () {
    
    UIImageView *_backgroundView;
    
}

@end

@implementation SubScrollView

- (instancetype)initWithFrame:(CGRect)frame video:(VideoModel *)video {

    if (self = [super initWithFrame:frame]) {
        
        _video = video;
        
        [self _initScrollView];
        
        [self _createBackgroundView];
    }
    
    return self;
}

- (void)_initScrollView {
    
    self.scrollEnabled = NO;
    [self setContentSize:CGSizeMake(self.frame.size.width * 2, self.frame.size.height)];
    
}

- (void)_createBackgroundView {
    
    //设置图片
    _backgroundView = [[UIImageView alloc] init];
    NSURL *url = [NSURL URLWithString:_video.coverForDetail];
    [_backgroundView sd_setImageWithURL:url];
    _backgroundView.frame = CGRectMake(0, 0, self.frame.size.width * 2, self.frame.size.height);
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:_backgroundView];
    
    
    //播放图标
    UIImageView *playIamge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    playIamge.image = [UIImage imageNamed:@"btn_play@2x"];
    playIamge.alpha = 0.7;
    playIamge.center = _backgroundView.center;
    [self addSubview:playIamge];
    
    //点击播放手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
    

    
}
- (void)tapAction:(UIGestureRecognizer *)gesture {
    NSLog(@"tap 播放视频");
    
    NSString *urlStr = _video.playUrl;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    MPMoviePlayerViewController *playViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    playViewController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
//    CATransition *transition = [[CATransition alloc] init];
//    transition.type = @"fade";
//    transition.duration = 0.3;
//    [self.controller.view.layer addAnimation:transition forKey:nil];

    //采用模态视图的形式弹出
    [self.controller presentViewController:playViewController animated:NO completion:nil];
    
}
    
- (void)ScrollByRatio:(CGFloat)ratio {
    
    CGFloat speed = kSpeed + self.frame.size.width;
    
    [self setContentOffset:CGPointMake(kPositon + ratio * speed, 0)];
    
}

- (void)shouldZooming:(BOOL)zooming {
    
    NSTimer *timer;

    if (zooming) {
        timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(zooming:) userInfo:nil repeats:YES];
        [timer fire];
    }
    else {
        if (timer) {
            [timer invalidate];
            _backgroundView.transform = CGAffineTransformIdentity;
        }
    }
    
}

- (void)zooming:(NSTimer *)timer  {
    
    [UIView animateWithDuration:10 animations:^{
        _backgroundView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:10 animations:^{
            _backgroundView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

- (void)setVideo:(VideoModel *)video {
    if (_video != video) {
        _video = video;
        NSURL *url = [NSURL URLWithString:_video.coverForDetail];
        [_backgroundView sd_setImageWithURL:url];
    }
}
@end
