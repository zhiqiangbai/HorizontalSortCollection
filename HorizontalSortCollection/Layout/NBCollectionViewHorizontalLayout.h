//
//  NBCollectionViewHorizontalLayout.h
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBCollectionViewHorizontalLayout : UICollectionViewFlowLayout

// 一行中 cell的个数
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;

@end
