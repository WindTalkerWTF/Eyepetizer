//
//  MainTabBarController.m
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController () {
    NSArray *_title;
    NSInteger _preSelectIndex;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self _createSubControllers];
    
    [self _createTabBar];
    
}


#pragma mark - 设置子控制器
- (void)_createSubControllers {
    
    NSArray *array = @[@"Daily", @"Categories"];
    
    NSMutableArray *arrayOfVC = [NSMutableArray array];
    
    for (NSString *name in array) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        BaseViewController *baseViewCon = [storyBoard instantiateInitialViewController];
        
        [arrayOfVC addObject:baseViewCon];
    }
    
    self.viewControllers = arrayOfVC;
    
}

#pragma mark - 设置TabBar按钮
- (void)_createTabBar {
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    // 1.移除TabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            [view removeFromSuperview];
        }
    }
        
    // 2.创建自定义按钮
    _title = @[@"每日精选", @"往期分类"];
    
    BaseTabBar *tabBar = [[BaseTabBar alloc] initWithFrame:self.tabBar.bounds titles:_title];
    tabBar.buttonAction = ^(NSInteger buttonIndex){
        
        CATransition *transition = [[CATransition alloc] init];
        transition.type = @"fade";
        transition.duration = 0.15;
        [self.view.layer addAnimation:transition forKey:nil];

        self.selectedIndex = buttonIndex;
    };
    [self.tabBar addSubview:tabBar];

}

- (void)_selectAction:(UIButton *)button {
    //字体颜色改变
    UIButton *preButton = (UIButton *)[self.tabBar viewWithTag:100 + _preSelectIndex];
    preButton.titleLabel.textColor = [UIColor grayColor];
    button.titleLabel.textColor = [UIColor darkTextColor];
    
    //创建转场动画，必须在切换时才有效果
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"fade";
    //transition.subtype = button.tag == 100 ? kCATransitionFromLeft : kCATransitionFromRight;
    transition.duration = 0.15;
    [self.view.layer addAnimation:transition forKey:nil];
    
    _preSelectIndex = button.tag - 100;
    self.selectedIndex = _preSelectIndex;
    
}


//在使用 self.title 的设置器方法时，修改titleLabel的显示文字
- (void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:30];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:18.f];
    _titleLabel.text = title;
    //将这个label 设置到navigationItem去
    self.navigationItem.titleView = _titleLabel;
}


@end
