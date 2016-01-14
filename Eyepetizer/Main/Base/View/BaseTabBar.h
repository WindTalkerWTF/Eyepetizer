//
//  BaseTabBar.h
//  Eyepetizer
//
//  Created by imac on 15/10/6.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(NSInteger buttonIndex);

@interface BaseTabBar : UIView {
    NSInteger _preSelectIndex;
}

@property (nonatomic, strong)NSArray *titlesArray;

@property (nonatomic, copy)ButtonAction buttonAction;


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;


@end
