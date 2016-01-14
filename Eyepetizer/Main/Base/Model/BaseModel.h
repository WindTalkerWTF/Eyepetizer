//
//  BaseModel.h
//  微博-01
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseModel : NSObject

//初始化方法
- (instancetype)initWithDataDic:(NSDictionary *)dataDic;

//获取属性映射字典
- (NSDictionary *)attributeMapDictionary;

//设置属性
- (void)setAttributes:(NSDictionary *)dataDic;

@end
