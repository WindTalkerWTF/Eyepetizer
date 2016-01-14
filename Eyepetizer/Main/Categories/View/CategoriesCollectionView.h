//
//  CategoriesCollectionView.h
//  Eyepetizer
//
//  Created by imac on 15/10/6.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesListModel.h"
#import "VideosRankViewController.h"
#import "UIImageView+WebCache.h"
@interface CategoriesCollectionView : UICollectionView <UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray *categoriesArray;


@end
