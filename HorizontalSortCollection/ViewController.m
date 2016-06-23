//
//  ViewController.m
//  HorizontalSortCollection
//
//  Created by NapoleonBai on 16/6/23.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

#import "ViewController.h"
#import "NBCollectionViewHorizontalLayout.h"


@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(weak,nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController


- (NSMutableArray *)items{
    if (!_items) {
        _items = @[@{@"image":@"",@"text":@""}].mutableCopy;
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NBCollectionViewHorizontalLayout *layout = (NBCollectionViewHorizontalLayout *)[self.collectionView collectionViewLayout];
    layout.rowCount = 2;
    layout.itemCountPerRow = 4;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake((self.view.bounds.size.width-50)/4, ((self.view.bounds.size.width)/2-30)/2);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    self.pageControl.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2];
    self.pageControl.layer.cornerRadius = 10;
    self.pageControl.layer.masksToBounds = YES;
}

- (void)pageTurn:(UIPageControl *)pageControl
{
    NSInteger index = [pageControl currentPage];
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.bounds.size.width * index, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    UILabel *label = [cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"(%ld,%ld)",indexPath.section,indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

-(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click item index row = %ld section = %ld",indexPath.row,indexPath.section);
}



@end
