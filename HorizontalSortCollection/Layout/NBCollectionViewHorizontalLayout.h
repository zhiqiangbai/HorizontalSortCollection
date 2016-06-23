//
//  NBCollectionViewHorizontalLayout.h
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  CollectionView水平排列布局(请保证UICollectionView宽高与行列匹配,eg:itemCountForRow=2;rowCount=4;itemSize = {50,50},padding = 10,那么 viewWidth = 250,viewHeight = 130)
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
