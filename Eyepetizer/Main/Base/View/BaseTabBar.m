//
//  BaseTabBar.m
//  Eyepetizer
//
//  Created by imac on 15/10/6.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseTabBar.h"

@implementation BaseTabBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        
        _titlesArray = titles;
        
        [self _createBarButton];
    }
    return self;
}

- (void)_createBarButton {
    
    _preSelectIndex = 0;
    
    CGFloat buttonWidth = kScreenWidth / _titlesArray.count;
    
    for (int i = 0; i < _titlesArray.count; i++) {
        //控制器按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, 49)];
        
        [button setTitle:_titlesArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        UIColor *titleColor = i == 0 ? [UIColor darkTextColor] : [UIColor grayColor];
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = 100 + i;
        [self addSubview:button];
        
        if (i > 0) {
            //创建两个按钮中间的分割线
            UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth * i, 9, 1, self.height - 18)];
            separateLine.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:separateLine];
        }
    
    }
    
    
}

- (void)_selectAction:(UIButton *)button {
    
    //字体颜色改变
    UIButton *preButton = (UIButton *)[self viewWithTag:100 + _preSelectIndex];
    [preButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];

    _preSelectIndex = button.tag - 100;
    if (_buttonAction) {
        _buttonAction(_preSelectIndex);
    }
    
}


@end
