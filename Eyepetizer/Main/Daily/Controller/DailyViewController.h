//
//  DailyViewController.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseViewController.h"
#import "DataService.h"
#import "VideoList.h"
#import "VideoListTable.h"
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, ControllerType) {
    ControllerTypeDaily = 1,    //每日界面
    ControllerTypeRank = 2,     //排行界面
    
};

//typedef void(^LoadMoreDataCompletion)();

@interface DailyViewController : BaseViewController

@property (nonatomic, assign)ControllerType *controllerType;
@property (nonatomic, copy)ScrollNextSection scrollNextSection;

//@property (nonatomic, copy)LoadMoreDataCompletion completion;

- (void)_loadMoreData;

@end
