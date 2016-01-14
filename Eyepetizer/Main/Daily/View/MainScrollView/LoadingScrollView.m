//
//  LoadingScrollView.m
//  Eyepetizer
//
//  Created by imac on 15/10/4.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "LoadingScrollView.h"

@implementation LoadingScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self _initScrollView];
        
        [self _createSubviews];
        
    }
    
    return self;
}

- (void)_initScrollView {
    self.backgroundColor = [UIColor whiteColor];
    [self setUserInteractionEnabled:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    self.delegate = self;
    [self setContentSize:CGSizeMake(self.width, 0)];

}

- (void)showLoadingWithText:(NSString *)text {
    _label.text = text;
}
- (void)stopLoadingWithText:(NSString *)text {
    _label.text = text;
    [self performSelector:@selector(_clearText) withObject:nil afterDelay:0.6];
}
- (void)_clearText {
    _label.text = @"";
}
- (void)_createSubviews {
    
    _bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2 - 30, self.height / 2 - 60 - 32, 60, 60)];
    _bigImageView.image = [UIImage imageNamed:@"Icon-Spotlight-40@3x"];
    [self addSubview:_bigImageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
    _label.center = _bigImageView.center;
    _label.top = _bigImageView.bottom + 10;
    _label.font = [UIFont fontWithName:kFontName_FZLTXIHJW_GB1_0 size:12.0f];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
    
}

@end
