//
//  NBCollectionViewHorizontalLayout.m
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "NBCollectionViewHorizontalLayout.h"

@interface NBCollectionViewHorizontalLayout()

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
            NSLog(@"===for ===>>>>%ld === %ld",indexPath.section,indexPath.row);
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
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
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
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
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
