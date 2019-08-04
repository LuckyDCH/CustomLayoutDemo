//
//  Layout.m
//  FlowLayoutDemo
//
//  Created by king on 16/8/1.
//  Copyright © 2016年 king. All rights reserved.
//

#import "Layout.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface Layout ()

@property(assign,nonatomic)NSInteger curSection;

@end

@implementation Layout

- (void)prepareLayout{
    [super prepareLayout];
    _sectionInsetTop = self.sectionInset.top;
    _supplementaryViewSize = self.headerReferenceSize;
    _sectionArr = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%.f",_sectionInsetTop], nil];
    _curSection = 0;
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    self.sizeDic = [[NSMutableDictionary alloc]init];
    NSInteger section = [self.collectionView numberOfSections];
    if (section == 0) {
        NSInteger count = [self.collectionView numberOfItemsInSection:0];
        for (NSInteger i = 0 ; i < count; i ++) {
            [self layoutItmeSize:[NSIndexPath indexPathForItem:i inSection:0]];
        }
    }else{
        for (NSInteger a = 0 ; a < section; a ++) {
            NSInteger count = [self.collectionView numberOfItemsInSection:a];
            for (NSInteger i = 0 ; i < count; i ++) {
                [self layoutItmeSize:[NSIndexPath indexPathForItem:i inSection:a]];
            }
        }
    }
    
}
- (void)layoutItmeSize:(NSIndexPath*)index{
    CGSize size = CGSizeZero;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:index.row inSection:index.section]];
    }
    
    [self.sizeDic setValue:NSStringFromCGSize(size) forKey:[NSString stringWithFormat:@"%zd-%zd",index.section,index.row]];
}
- (UICollectionViewLayoutAttributes*)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat y = [_sectionArr[indexPath.section] floatValue];
    attr.frame = CGRectMake(10, y,_supplementaryViewSize.width,_supplementaryViewSize.height);
    return attr;
}
//此方法不属于重写，应该理解为构建，在对attr赋值前，打印输出attr.frame的坐标为0，由此判断并非重写。
- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSString *sizeString = [self.sizeDic objectForKey:[NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row]];
    CGSize size = CGSizeFromString(sizeString);//获取cell的size
    static UICollectionViewLayoutAttributes *attr1 = nil;
//    NSLog(@"_supplementaryViewSize.width:%f",_supplementaryViewSize.width);
    //40是collectionView在父视图上的布局，前后分别距离20，得到collectionView实际的宽度，根据情况修改这个值
    //viewwidth是每一行连续占据cell后，剩下的宽度，将这个viewWidth跟cell实际宽度比较，判断接下来添加的cell是否需要换行
    //剩下的宽度
    CGFloat viewWidth = self.contentW - attr1.frame.origin.x - attr1.bounds.size.width;
    if (indexPath.row == 0) {
        attr.frame = CGRectMake(self.leftMarg, _sectionInsetTop+_supplementaryViewSize.height, size.width, size.height);
    }else{
        if (viewWidth >= size.width) {//判断当前cell是否需要换行
            attr.frame = CGRectMake(attr1.frame.origin.x+attr1.frame.size.width+self.itemMargin, attr1.frame.origin.y, size.width, size.height);
        }else{//换行
//            attr.frame = CGRectMake(_supplementaryViewSize.width, attr1.frame.origin.y+attr1.bounds.size.height+self.itemMargin+_supplementaryViewSize.height,size.width, size.height);
            attr.frame = CGRectMake(self.leftMarg, attr1.frame.origin.y+attr1.bounds.size.height+self.itemMargin,size.width, size.height);
        }
    }
//    static NSInteger section = 0;
    if (_curSection != indexPath.section) {
        _sectionInsetTop = attr1.frame.origin.y + attr1.bounds.size.height + self.itemMargin;
        [_sectionArr addObject:[NSString stringWithFormat:@"%.f",_sectionInsetTop]];
//        attr.frame = CGRectMake(_supplementaryViewSize.width, attr1.frame.origin.y+attr1.bounds.size.height+self.itemMargin, size.width, size.height);
        attr.frame = CGRectMake(self.leftMarg, attr1.frame.origin.y+attr1.bounds.size.height+self.itemMargin+_supplementaryViewSize.height, size.width, size.height);
        _curSection = indexPath.section;
    }
    attr1 = attr;
    return attr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
   
    NSMutableArray *array = [NSMutableArray array];
    NSInteger section = [self.collectionView numberOfSections];
    
    for (int b = 0; b < section; b ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:b];
        //add cells
        for (int i=0; i<count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:b];
            
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [array addObject:attributes];
        }

    }
    
  
    //add first supplementaryView
    for (NSInteger a = 0 ; a < [self.collectionView numberOfSections]; a ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:a];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [array addObject:attributes];
    }
    

    return array;
}



//- (CGSize)collectionViewContentSize{
//    return CGSizeMake(WIDTH, self.collectionView.bounds.size.height*2);
//}
@end
