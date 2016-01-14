//
//  BaseViewController.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "FavorViewController.h"
@interface BaseViewController () {
   
    MBProgressHUD *_HUD;
    
    UIView *_menuView;

}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
}

//自定义标题
- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:30];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:24.0f];
    _titleLabel.text = title;
    // 将这个label 设置到navigationItem去
    self.navigationItem.titleView = _titleLabel;
}

- (void)createButtonItem {
    [self createLeftButtonItem];
    [self createRightButtonItem];
}
- (void)createLeftButtonItem {
    //左侧 下拉菜单按钮
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuShowAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    //左侧 日期label
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 21)];
    _dateLabel.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:15.0f];
    UIBarButtonItem *dateLabelItem = [[UIBarButtonItem alloc] initWithCustomView:_dateLabel];
    
    self.navigationItem.leftBarButtonItems = @[menuButtonItem, dateLabelItem];

}
- (void)createRightButtonItem {
    //右侧 返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"whiteeye"] forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor whiteColor]];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.rightBarButtonItem = backButtonItem;
    
}

#pragma mark - 点击事件
//下拉菜单按钮操作
- (void)menuShowAction:(UIButton *)button {
    //创建下拉菜单视图
    if (_menuView == nil) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, -kScreenHeight + 64, kScreenWidth, kScreenHeight - 64)];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.alpha = 0.97;
        [self _createMenuSubViews];
        [self.view addSubview:_menuView];
    }
    //出现下拉菜单
    if (!button.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformMakeRotation(M_PI_2);
            _menuView.transform = CGAffineTransformMakeTranslation(0, _menuView.height);
        }];

    }
    //隐藏下拉菜单
    else {
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformIdentity;
            _menuView.transform = CGAffineTransformIdentity;
        }];
    }
    button.selected = !button.selected;

}
// 创建我的收藏，我的缓存等按钮
- (void)_createMenuSubViews {
    
    NSArray *titles = @[@"我的收藏",@"我的缓存",@"功能开关",@"我要投稿"];
    
    for (int i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((kScreenWidth-100) / 2, 50+80*i, 100, 30);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = 10 + i;
        [button addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menuView addSubview:button];
    }
    
}
- (void)menuButtonAction:(UIButton *)button {
    
    if (button.tag == 10) {
        NSLog(@"进入收藏");
        FavorViewController *favorVC = [[FavorViewController alloc] init];
        [self.navigationController pushViewController:favorVC animated:YES];
    }
    
}
//返回按钮操作
- (void)backAction:(UIButton *)button {
    
    if (!_isListVC) {
        [self.navigationController popViewControllerAnimated:YES];
        //显示标签栏
        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.tabBar.bottom = kScreenHeight;
        }];
        NSLog(@"  pop");

    }
    else {
        NSLog(@"push");
        [self pushViewController];
    }
    button.selected = !button.selected;

}

//push默认高度下的视图
- (void)pushViewController {
    return;
}


//是否隐藏标签栏
- (void)hideTabBar:(BOOL)hidden animated:(BOOL)animate {
    
    if (animate) {
        
        if (hidden) {
            [UIView animateWithDuration:0.3 animations:^{
                self.tabBarController.tabBar.top = kScreenHeight;
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                self.tabBarController.tabBar.bottom = kScreenHeight;
            }];
        }
        
    }
    else {
        
        if (hidden) {
            self.tabBarController.tabBar.top = kScreenHeight;
        }
        else {
            self.tabBarController.tabBar.bottom = kScreenHeight;
        }
        
    }
}


#pragma mark - HUD加载图标
//显示加载图标
- (void)showHUDWithText:(NSString *)text {
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
    }
    _HUD.labelText = text;
    _HUD.dimBackground = YES;
    [_HUD show:YES];
}

//隐藏加载图标
- (void)hideHUDAfterDelay:(NSTimeInterval)delay {
    [_HUD hide:YES afterDelay:delay];
}

//显示自定义加载图标
- (void)showHUDCustomViewWithText:(NSString *)text {
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
    }
    _HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-Small@3x"]];
    _HUD.mode = MBProgressHUDModeCustomView;
    _HUD.labelText = text;
    [_HUD show:YES];
    
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    
//    return UIInterfaceOrientationMaskPortrait;
//}

//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    
//    return toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
//
//}

@end
