//
//  TextArea.h
//  Eyepetizer
//
//  Created by imac on 15/10/3.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoList.h"
#import "ZTypewriteEffectLabel.h"
#import "UIImageView+WebCache.h"
#import "CoreDataManager.h"
@interface TextArea : UIView
@property (nonatomic, strong)VideoModel *video;

@property (nonatomic, strong)UIImageView *background;

@property (strong, nonatomic)ZTypewriteEffectLabel *titleLabel;     //标题label
@property (strong, nonatomic)ZTypewriteEffectLabel *subTitleLabel;  //副标题label
@property (strong, nonatomic)ZTypewriteEffectLabel *contentView;    //内容label

@property (strong, nonatomic)UIButton *favButton;   //收藏按钮（动作缺省）
@property (strong, nonatomic)UIButton *shareButton; //分享按钮（动作缺省）
@property (strong, nonatomic)UIButton *cacheButton; //缓存按钮（动作缺省）




@end
