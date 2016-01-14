//
//  CategoriesCollectionView.m
//  Eyepetizer
//
//  Created by imac on 15/10/6.
//  Copyright © 2015年 zhangzheng. All rights reserved.
//

#import "CategoriesCollectionView.h"

@implementation CategoriesCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    UICollectionViewFlowLayout *layout = [self _createlayout];
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self _initCollection];
    }
    
    return self;
}
- (UICollectionViewFlowLayout *)_createlayout {
    // 1.创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 2.设定单元格size
    CGFloat width = (kScreenWidth - 3 * 3) / 2.0;
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    
    return layout;
}
- (void)_initCollection {
    
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.showsVerticalScrollIndicator = NO;
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _categoriesArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // 数据字典
    CategoriesListModel *categories = _categoriesArray[indexPath.item];
    
    // 背景视图
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    bgImageView.userInteractionEnabled = YES;
    NSString *urlStr = categories.bgPicture;
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    [cell.contentView addSubview:bgImageView];
    
    // 透明的遮罩视图，效果更好一些
    UIView *maskView = [[UIView alloc] initWithFrame:bgImageView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.3;
    [bgImageView addSubview:maskView];
    
    // 分类名Label
    UILabel *categoriesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    NSString *nameStr = [NSString stringWithFormat:@"#%@", categories.name];
    categoriesLabel.text = nameStr;
    categoriesLabel.center = bgImageView.center;
    categoriesLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:16];
    categoriesLabel.textColor = [UIColor whiteColor];
    categoriesLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:categoriesLabel];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoriesListModel *categories = _categoriesArray[indexPath.item];
    
    NSLog(@"进入 %@ 栏目",  categories.name);
    
    // 点击某个分类选项，该分类中的数据并push
    VideosRankViewController *videosRankVC = [[VideosRankViewController alloc] init];
    videosRankVC.category =  categories.name;
    [self.controller.navigationController pushViewController:videosRankVC animated:YES];
    
}

@end
