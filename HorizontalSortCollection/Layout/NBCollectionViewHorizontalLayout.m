//
//  NBCollectionViewHorizontalLayout.m
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBCollectionViewHorizontalLayout.h"

@interface NBCollectionViewHorizontalLayout()
/**
 *  存储item相关信息
 */
@property (strong, nonatomic) NSMutableArray *allAttributes;

@end

@implementation NBCollectionViewHorizontalLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    
    for (NSUInteger indexSection = 0 ; indexSection < sectionCount ; indexSection++) {
        NSUInteger count = [self.collectionView numberOfItemsInSection:indexSection];
        for (NSUInteger i = 0; i<count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:indexSection];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.allAttributes addObject:attributes];
        }
    }
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *newAttr = [super layoutAttributesForItemAtIndexPath:newIndexPath];
    newAttr.indexPath = indexPath;
    return newAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath == attr2.indexPath) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}

/**
 * 根据item计算目标item的位置
 *  @param item 目标item
 *  @param x    横向偏移
 *  @param y    竖向偏移
 */
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemCountForRow*self.rowCount);
    
    NSUInteger newX = item % self.itemCountForRow + page * self.itemCountForRow;
    NSUInteger newY = item / self.itemCountForRow - page * self.rowCount;
    if (x != NULL) {
        *x = newX;
    }
    if (y != NULL) {
        *y = newY;
    }
}

/**
 *  根据偏移量计算item
 *
 *  @param x 横向偏移
 *  @param y 竖向偏移
 *
 *  @return
 */
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y
{
    NSUInteger item = x * self.rowCount + y;
    return item;
}

@end
