//
//  EventsBrowsViewController.h
//  Eyepetizer
//
//  Created by apple on 15/9/30.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import "BaseViewController.h"
#import "VideoModel.h"
#import "VideoListCell.h"
#import "MainTabBarController.h"
#import "Utils.h"
#import "DataService.h"
#import "MJRefresh.h"
#import "BaseTabBar.h"
#import "VideoListTable.h"
#import "BaseNavigationController.h"

@interface VideosRankViewController : BaseViewController

@property (nonatomic, copy) NSString *category;

@end
