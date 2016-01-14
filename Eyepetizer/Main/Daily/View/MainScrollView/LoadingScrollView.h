//
//  LoadingScrollView.h
//  Eyepetizer
//
//  Created by imac on 15/10/4.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong)UIImageView *bigImageView;  //图片视图

@property (nonatomic, strong)UIImageView *centerImageView;   //中间转动的视图（缺省）

@property (nonatomic, strong)UILabel *label;


- (void)showLoadingWithText:(NSString *)text;

- (void)stopLoadingWithText:(NSString *)text;

@end
