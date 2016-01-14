//
//  VideoListCell.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoListCell : UITableViewCell {
    BOOL _isLongPressed;
}
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoSubTitle;
@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (nonatomic, strong)VideoModel *video;

@end
