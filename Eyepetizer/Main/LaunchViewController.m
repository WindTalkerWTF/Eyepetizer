//
//  LaunchViewController.m
//  Eyepetizer
//
//  Created by imac on 15/10/15.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController () {
    
    UIImageView *_logoImage;
    UILabel *_ENLabel;
    UILabel *_CNLabel;
    UIImageView *_backgroundImage;
    
    UILabel *_ENTextLabel;
    UILabel *_CNTextLabel;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    //隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
    
    [self createView];
    [self _loadData];
    
}

- (void)createView {
    //背景图片
    _backgroundImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backgroundImage.alpha = 0;
    [self.view addSubview:_backgroundImage];
    //logo图标
    _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 30, kScreenHeight / 2 - 80, 60, 60)];
    _logoImage.image = [UIImage imageNamed:@"whiteeye"];
    [self.view addSubview:_logoImage];
    //英文label
    _ENLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2, 100, 21)];
    _ENLabel.text = @"Eyepetizer";
    _ENLabel.textColor = [UIColor whiteColor];
    _ENLabel.textAlignment = NSTextAlignmentCenter;
    _ENLabel.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:25];
    [self.view addSubview:_ENLabel];
    //中文label
    _CNLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 50, kScreenHeight / 2 + 40, 100, 21)];
    _CNLabel.text = @"开眼";
    _CNLabel.textColor = [UIColor whiteColor];
    _CNLabel.textAlignment = NSTextAlignmentCenter;
    _CNLabel.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:25];
    [self.view addSubview:_CNLabel];
    
    
    _ENTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 150, kScreenHeight - 150, 300, 21)];
    _ENTextLabel.text = @"Daily appetizers for your eyes. Bon eyepetit.";
    _ENTextLabel.textColor = [UIColor whiteColor];
    _ENTextLabel.textAlignment = NSTextAlignmentCenter;
    _ENTextLabel.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:14];
    _ENTextLabel.alpha = 0;
    [self.view addSubview:_ENTextLabel];
    
    _CNTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 150, kScreenHeight - 120, 300, 21)];
    _CNTextLabel.text = @"每日精选视频推介，让你大开眼界。";
    _CNTextLabel.textColor = [UIColor whiteColor];
    _CNTextLabel.textAlignment = NSTextAlignmentCenter;
    _CNTextLabel.font = [UIFont fontWithName:kFontName_Lobster_1_4 size:14];
    _CNTextLabel.alpha = 0;
    [self.view addSubview:_CNTextLabel];


}

- (void)_loadData {
    
    
//    http://baobab.wandoujia.com/api/v1/configs?version=58&model=iPhone%205C&vc=125&t=MjAxNTEwMTUxMzI4MDU2NjUsMjE0Mw%3D%3D&u=ffa794daf57a4c90bb42a5c26124045111888b7d&net=wifi&v=1.8.1&f=iphone
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"58" forKey:@"version"];
    [params setObject:@"" forKey:@"model"];
    [params setObject:@"125" forKey:@"vc"];
    [params setObject:@"" forKey:@"t"];
    [params setObject:@"wifi" forKey:@"net"];
    [params setObject:@"ffa794daf57a4c90bb42a5c26124045111888b7d" forKey:@"u"];
    [params setObject:@"1.8.1" forKey:@"v"];
    [params setObject:@"iphone" forKey:@"f"];
    
    //请求网络
    [DataService requestAFUrl:@"http://baobab.wandoujia.com/api/v1/configs" httpMethod:kGET params:params data:nil block:^(id result) {
        
        [self _loadDataWithResult:result];
        
    }];
    
}

- (void)_loadDataWithResult:(id)result {
    
    NSDictionary *startPage = result[@"startPage"];
    NSString *imageUrl = startPage[@"imageUrl"];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [_backgroundImage sd_setImageWithURL:url];
    
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.5];
}
//开始动画
- (void)startAnimation {
    
    [UIView animateWithDuration:1 animations:^{
        
        _backgroundImage.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            _logoImage.top -= 40;
            _ENLabel.top -= 40;
            _CNLabel.top -= 40;

            _ENTextLabel.alpha = 1;
            _CNTextLabel.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [self showMainViewController];
        }];
        
    }];
    
}


//显示主界面
- (void)showMainViewController {
    
    //读取主界面
    MainTabBarController *mainTabBarCon = [[MainTabBarController alloc] init];
    
    mainTabBarCon.view.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    
    [self.view.window addSubview:mainTabBarCon.view];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
        mainTabBarCon.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.view.window.rootViewController = mainTabBarCon;
    }];
    
}

@end
