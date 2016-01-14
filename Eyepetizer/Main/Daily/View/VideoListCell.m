//
//  VideoListCell.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "VideoListCell.h"
#import "UIImageView+WebCache.h"
@implementation VideoListCell

- (void)awakeFromNib {
    _isLongPressed = NO;
    self.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self _createLongPressGesture];
}

- (void)setVideo:(VideoModel *)video {
    if (_video != video) {
        _video = video;
        [self setNeedsLayout];
    }
}
- (void)layoutSubviews {
    //图片
    NSURL *url = [NSURL URLWithString:_video.coverForFeed];
    [_background sd_setImageWithURL:url];
    _background.contentMode = UIViewContentModeScaleAspectFill;
    _background.layer.masksToBounds = YES;
    
    //标题
    _videoTitle.text = _video.title;
    _videoTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14];

    
    //副标题
    NSString *category = _video.category;
    NSString *durationStr = _video.duration;
    NSUInteger duration = [durationStr integerValue];
    NSString *subTitle = [NSString stringWithFormat:@"#%@ / %lu'%02lu\" ", category, duration / 60, duration %60];
    _videoSubTitle.text = subTitle;
    _videoSubTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14];

    
    //设置初始透明度
    _background.alpha = 0.7;
    _videoTitle.alpha = 1.0;
    _videoSubTitle.alpha = 1.0;
}


- (void)_createLongPressGesture {
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 1;
    [self addGestureRecognizer:longPress];
    
}
- (void)longPressAction:(UIGestureRecognizer *)gesture {

    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:1 animations:^{
            _background.alpha = 1.0;
            _videoTitle.alpha = 0;
            _videoSubTitle.alpha = 0;
        }];
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        [UIView animateWithDuration:1 animations:^{
            _background.alpha = 0.7;
            _videoTitle.alpha = 1.0;
            _videoSubTitle.alpha = 1.0;
        }];
    }
    
}
//设置长按高亮动画
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [UIView animateWithDuration:1 animations:^{
//        _background.alpha = 1.0;
//        _videoTitle.alpha = 0;
//        _videoSubTitle.alpha = 0;
//    }];
//    _isLongPressed = YES;
//    
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    if (_isLongPressed) {
//        [UIView animateWithDuration:1 animations:^{
//            _background.alpha = 0.7;
//            _videoTitle.alpha = 1.0;
//            _videoSubTitle.alpha = 1.0;
//        }];
//    }
//    _isLongPressed = NO;
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
