//
//  VideoModel.h
//  Eyepetizer
//
//  Created by imac on 15/9/30.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

@property (nonatomic, copy)NSString *category;          //电影分类
@property (nonatomic, copy)NSString *videoID;           //电影序号（接收为id）
@property (nonatomic, copy)NSString *date;              //
@property (nonatomic, copy)NSString *idx;               //

@property (nonatomic, copy)NSString *coverBlurred;      //模糊图片
@property (nonatomic, copy)NSString *coverForDetail;    //详情图片
@property (nonatomic, copy)NSString *coverForFeed;      //
@property (nonatomic, copy)NSString *coverForSharing;   //分享图片


@property (nonatomic, copy)NSString *title;             //标题
@property (nonatomic, copy)NSString *videoDescription;  //正文描述（接收为description）
@property (nonatomic, strong)NSDictionary *consumption; //消费数(播放数，收藏数，回复数，分享数)


@property (nonatomic, copy)NSString *duration;          //视频时间长度（s）
@property (nonatomic, copy)NSString *playUrl;           //播放地址
@property (nonatomic, strong)NSArray *playInfo;         //播放地址信息（普清，高清）
@property (nonatomic, strong)NSDictionary *provider;    //提供方


@property (nonatomic, copy)NSString *rawWebUrl;         //视频网站
@property (nonatomic, copy)NSString *webUrl;            //app网站



@end
