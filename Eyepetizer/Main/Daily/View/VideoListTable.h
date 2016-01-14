//
//  VideoListTable.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoList.h"
#import "VideoListCell.h"
#import "DetailViewController.h"
#import "Utils.h"

typedef void(^ScrollNextSection)(NSString *dateString);


@interface VideoListTable : UITableView <UITableViewDataSource, UITableViewDelegate> {
    DetailViewController *_detailVC;
}

@property (nonatomic, strong)NSArray *dailyList;

@property (nonatomic, copy)ScrollNextSection scrollNextSection;

- (void)ScrollToFront;
- (void)ScrollToNext;

@end
