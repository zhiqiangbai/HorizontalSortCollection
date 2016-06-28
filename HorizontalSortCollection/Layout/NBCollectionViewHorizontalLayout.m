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

/**
 *  布局前准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //设置为水平方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //初始化item配置信息存储数组
    self.allAttributes = [NSMutableArray array];
    //得到一共存在几个分组
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    for (NSUInteger indexSection = 0 ; indexSection < sectionCount ; indexSection++) {
        //得到每个分组有多少个item
        NSUInteger count = [self.collectionView numberOfItemsInSection:indexSection];
        for (NSUInteger i = 0; i<count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:indexSection];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            //得到每个item的具体配置信息,并存储起来
            [self.allAttributes addObject:attributes];
        }
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    //不论设置为垂直还是水平,都默认设置为水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
/**
 *  返回contentsize的总大小
 *
 *  @return
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width * self.collectionView.numberOfSections, [super collectionViewContentSize].height);
}

/**
 *  返回每个item的布局属性
 *
 *  @param indexPath 位置
 *
 *  @return
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    //准换当前item所在位置
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    //得到偏移后的item
    NSUInteger newItem = [self originItemAtX:x y:y];
    //得到新位置
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newItem inSection:indexPath.section];    
    //配置新属性
    UICollectionViewLayoutAttributes *newAttr = [super layoutAttributesForItemAtIndexPath:newIndexPath];
    newAttr.indexPath = indexPath;
    return newAttr;
}
/**
 *  返回布局的配置数组,完成布局的自定义配置
 *
 *  @param rect
 *
 *  @return
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if ([attr.indexPath isEqual:attr2.indexPath]) {
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
    //当前item的横向偏移量
    NSUInteger newX = item % self.itemCountForRow;
    //当前item的纵向偏移量
    NSUInteger newY = item / self.itemCountForRow;
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
