//
//  NBCollectionViewHorizontalLayout.h
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  CollectionView水平排列布局
 */
@interface NBCollectionViewHorizontalLayout : UICollectionViewFlowLayout

/**
 *  每行最多有几个item
 */
@property (nonatomic) NSUInteger itemCountForRow;
/**
 *  总共显示几行
 */
@property (nonatomic) NSUInteger rowCount;

@end
