//
//  CategoriesListModel.h
//  Eyepetizer
//
//  Created by imac on 15/10/6.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "BaseModel.h"

@interface CategoriesListModel : BaseModel

@property (nonatomic, copy)NSString *alias;
@property (nonatomic, copy)NSString *bgColor;
@property (nonatomic, copy)NSString *bgPicture;
@property (nonatomic, copy)NSString *name;

@end
