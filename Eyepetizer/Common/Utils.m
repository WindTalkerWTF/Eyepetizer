//
//  Utils.m
//  HWWeibo
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 zhukai. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//+ (NSString *)dateOfMonthDayByTimeIntervl:(NSTimeInterval)timeInterval withFormatterStr:(NSString *)formatterStr {
//    
//    
//}


+ (NSString *)dateByTimeIntervl:(NSTimeInterval)timeInterval withFormatterStr:(NSString *)formatterStr {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formatterStr];
    
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormmaterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    NSString *dateString = [formatter stringFromDate:date];
    return  dateString;

    
}



+ (NSString *)UTF8Decode:(NSString *)str {
    
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *dataStr = [[[strData description] uppercaseString] mutableCopy];
    [dataStr deleteCharactersInRange:NSMakeRange(0, 1)];
    [dataStr deleteCharactersInRange:NSMakeRange(dataStr.length - 1, 1)];
    
    NSMutableString *retStr = [NSMutableString string];
    NSArray *strArray = [dataStr componentsSeparatedByString:@" "];
    retStr = [[strArray componentsJoinedByString:@""] mutableCopy];
    
    for (int i = 0; i < retStr.length; i += 3) {
        [retStr insertString:@"\%" atIndex:i];
    }
    
    return retStr;
    
}

@end
