//
//  UIView+Controller.m
//  Eyepetizer
//
//  Created by imac on 15/10/2.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)


- (UIViewController *)controller {
    
    UIResponder *responder = self.nextResponder;
    
    while (responder) {
        
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    
    return nil;
}

@end
