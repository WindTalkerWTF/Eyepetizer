//
//  BaseModel.m
//  微博-01
//
//  Created by imac on 15/9/14.
//  Copyright (c) 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//初始化方法
- (instancetype)initWithDataDic:(NSDictionary *)dataDic {
    if (self = [super init]) {
        
        [self setAttributes:dataDic];
    }
    
    return self;
}

//获取属性映射字典
- (NSDictionary *)attributeMapDictionary {
    return nil;
}
- (SEL)getSetterSelWithAttributeName:(NSString *)attributeName {
    //处理字符串获取set方法
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *settreName = [NSString stringWithFormat:@"set%@%@:", capital, [attributeName substringFromIndex:1]];
    
    return NSSelectorFromString(settreName);
}
//设置属性
- (void)setAttributes:(NSDictionary *)dataDic {
    
    NSDictionary *attributeMapDic = [self attributeMapDictionary];
    //如果没有影射字典，则直接用字段名作为属性
    if (attributeMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:dataDic.count];
        for (NSString *key in dataDic) {
            [dic setValue:key forKey:key];
        }
        //映射字典赋值
        attributeMapDic = dic;
    }
        
    NSArray *attrbuteNameArray = [attributeMapDic allKeys];
    for (NSString *attributeName in attrbuteNameArray) {
        //通过属性名获得set方法
        SEL sel = [self getSetterSelWithAttributeName:attributeName];
        //setName setTime
        if ([self respondsToSelector:sel]) {
            //得到数据字典中的字段关键值
            NSString *dataDicKey = [attributeMapDic objectForKey:attributeName];
            //得到数据字典中的值
            id attributeValue = [dataDic objectForKey:dataDicKey];
            //调用set方法 为属性赋值
            [self performSelector:sel withObject:attributeValue];
        }
        
    }

    
}


@end
