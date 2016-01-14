//
//  Utils.h
//  HWWeibo
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

//通用 string 转date
+ (NSString *)dateByTimeIntervl:(NSTimeInterval)timeInterval withFormatterStr:(NSString *)formatterStr;

//通用 date 转 string
+ (NSString *)stringFromDate:(NSDate *)date withFormmaterStr:(NSString *)formatterStr;

//专用于微博项目 把 Fri Aug 28 00:00:00 +0800 2009 转换成 月-日 时:分格式
//+ (NSString *)weiboDateString:(NSString *)string;

// 把中文解码成UTF8格式的字符串，用于url的拼接
+ (NSString *)UTF8Decode:(NSString *)str;

@end
