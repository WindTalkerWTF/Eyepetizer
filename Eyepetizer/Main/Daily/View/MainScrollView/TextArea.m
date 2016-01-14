//
//  TextArea.m
//  Eyepetizer
//
//  Created by imac on 15/10/3.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "TextArea.h"

@implementation TextArea

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubViews];
    }
    return self;
}
- (void)_createSubViews {
    //标题label
    _titleLabel = [[ZTypewriteEffectLabel alloc] initWithFrame:CGRectMake(15, 20, self.width - 20, 21)];
    _titleLabel.typewriteTimeInterval = 0.1;
    _titleLabel.hasSound = NO;
    _titleLabel.font = [UIFont fontWithName:kFontName_FZLTZCHJW_GB1_0 size:18];
    _titleLabel.textColor = [UIColor clearColor];
    _titleLabel.typewriteEffectColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:_titleLabel];
    
    //分割线
    CGFloat width = _titleLabel.width - _titleLabel.font.pointSize * 2.5;
    UIView *viewLines = [[UIView alloc] initWithFrame:CGRectMake(10, _titleLabel.bottom + 6, width, 0.6)];
    viewLines.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewLines];

    //副标题label
    _subTitleLabel = [[ZTypewriteEffectLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 20, 21)];
    _subTitleLabel.left = _titleLabel.left;
    _subTitleLabel.top = _titleLabel.bottom + 20;
    _subTitleLabel.typewriteTimeInterval = 0.1;
    _subTitleLabel.font = [UIFont fontWithName:kFontName_FZLTXIHJW_GB1_0 size:12.0f];
    _subTitleLabel.textColor = [UIColor clearColor];
    _subTitleLabel.typewriteEffectColor = [UIColor whiteColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:_subTitleLabel];
    
    //内容label
    _contentView = [[ZTypewriteEffectLabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 2 * (_titleLabel.left), 200)];
    _contentView.left = _titleLabel.left;
    _contentView.top = _subTitleLabel.bottom;
    _contentView.numberOfLines = 0;
    _contentView.textAlignment = NSTextAlignmentLeft;
    _contentView.typewriteTimeInterval = 0.01;
    _contentView.font = [UIFont fontWithName:kFontName_FZLTXIHJW_GB1_0 size:12.0f];
    _contentView.textColor = [UIColor clearColor];
    _contentView.typewriteEffectColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    [self _createButtons];
}

- (void)_createButtons {
    // 4.收藏按钮
    _favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _favButton.frame = CGRectMake(15, self.height - 50, 100, 30);
    [_favButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _favButton.titleLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    _favButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _favButton.tag = 10;
    _favButton.showsTouchWhenHighlighted = YES;
    [_favButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_favButton];
    
    // 5.分享按钮
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButton.frame = CGRectMake(_favButton.right, _favButton.top, 100, 30);
    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _shareButton.titleLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    _shareButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _shareButton.tag = 11;
    [_shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareButton];
    
    // 6.缓存按钮
    _cacheButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cacheButton.frame = CGRectMake(_shareButton.right, _favButton.top, 100, 30);
    [_cacheButton setImage:[UIImage imageNamed:@"btn_download_normal@2x"] forState:UIControlStateNormal];
    [_cacheButton setTitle:@"缓存" forState:UIControlStateNormal];
    [_cacheButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cacheButton.titleLabel.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:13];
    _cacheButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _cacheButton.tag = 12;
    [_cacheButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cacheButton];
    

}


- (void)setVideo:(VideoModel *)video {
    if (_video != video) {
        _video = video;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _titleLabel.text = _video.title;
    [_titleLabel startTypewrite];
    
    NSInteger duration = [_video.duration integerValue];
     _subTitleLabel.text = [NSString stringWithFormat:@"#%@ / %i'%02i\" ", _video.category, duration / 60, duration %60];
    [_subTitleLabel startTypewrite];
    
    _contentView.text = _video.videoDescription;
    _contentView.text = [_contentView.text stringByAppendingFormat:@"\n \n \n \n \n \n \n \n \n \n \n \n \n"];
    [_contentView startTypewrite];
    
    NSDictionary *consumptionDic = _video.consumption;
    
    NSNumber *collectionCount = consumptionDic[@"collectionCount"];
    [_favButton setTitle:[NSString stringWithFormat:@"收藏:%@", collectionCount] forState:UIControlStateNormal];
    
    NSNumber *shareCount = consumptionDic[@"shareCount"];
    [_shareButton setTitle:[NSString stringWithFormat:@"分享:%@", shareCount] forState:UIControlStateNormal];

    
}

#pragma mark - 收藏等按钮点击事件
- (void)buttonAction:(UIButton *)button {
    
    switch (button.tag) {
        case 10:
        {
            
            CoreDataManager *manager = [CoreDataManager defaultManager];
            

            //通过谓词设置查找条件
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title=%@", _video.title];

            NSArray *videos = [manager queryObject:@"Video" predicate:predicate];
            
            if (videos.count > 0) {
                
                NSLog(@"删除%li",(unsigned long)videos.count);
                for (int index = 0; index < videos.count; index++) {
                    VideoModel *video = videos[index];
                    NSLog(@"%@", video.title);
                    [manager deleteObject:(NSManagedObject *)video];
                }
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"删除成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
            else {
                VideoModel *video = (VideoModel *)[manager createMO:@"Video"];
                video.category = [_video.category copy];
                video.videoID = [NSString stringWithFormat:@"%@", _video.videoID];
                video.date = [NSString stringWithFormat:@"%@", _video.date];
                video.idx = [NSString stringWithFormat:@"%@", _video.idx];
                video.coverBlurred = [_video.coverBlurred copy];
                video.coverForDetail = [_video.coverForDetail copy];
                video.coverForFeed = [_video.coverForFeed copy];
                video.title = [_video.title copy];
                video.coverForSharing = [_video.coverForSharing copy];
                video.videoDescription = [_video.videoDescription copy];
                video.duration = [NSString stringWithFormat:@"%@", _video.duration];
                video.playUrl = [_video.playUrl copy];

                [manager addManageObject:(NSManagedObject *)video];
                NSLog(@"收藏成功");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];

            }
            

            

//            //设置文件保存的路径
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            
//            //获取documents路径
//            NSString *documentPath = [paths lastObject];
//            
//            //定义全路径
//            NSString *plistPath = [documentPath stringByAppendingPathComponent:@"favor.plist"];
//            
//            
//            
////            NSString *plistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"favor.plist"];
//            
//            NSMutableArray *videosArray = [NSMutableArray array];
//            
//            if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
//                
//                videosArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
//                
//            }
//            
//            [videosArray addObject:_video];
//            
//            [videosArray writeToFile:plistPath atomically:NO];
//            
//
//            
            // 收藏
            // 如果没收藏则收藏，否则删除该收藏
//            if (!self.model.isFav) {
//                [DBManager addVideo:self.model];
//                self.model.isFav = YES;
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alertView show];
//                
//            }
//            else {
//                [DBManager deleteVideoWithTitle:self.model.title];
//                self.model.isFav = NO;
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alertView show];
//            }
//            break;
        }
        case 11:
            // 分享
            break;
        case 12:
            // 缓存
            break;
            
        default:
            break;
    }
    
}


@end
