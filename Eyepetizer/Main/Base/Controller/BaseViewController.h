//
//  BaseViewController.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavigationController.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

@property (nonatomic, assign)BOOL isListVC;     //是否是视频列表标志，用于判断按钮的push、pop操作

@property (nonatomic, strong)UILabel *dateLabel;    //当前界面视频的日期label

//创建导航栏按钮
- (void)createButtonItem;
- (void)createLeftButtonItem;
- (void)createRightButtonItem;

- (void)backAction:(UIButton *)button;


//复写此方法
- (void)pushViewController;

//是否隐藏标签栏
- (void)hideTabBar:(BOOL)hidden animated:(BOOL)animate;

//显示加载图标
- (void)showHUDWithText:(NSString *)text;

//隐藏加载图标
- (void)hideHUDAfterDelay:(NSTimeInterval)delay;

//显示自定义加载图标
- (void)showHUDCustomViewWithText:(NSString *)text;

@end
