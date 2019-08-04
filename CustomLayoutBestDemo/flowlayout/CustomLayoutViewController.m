//
//  CustomLayoutViewController.m
//  CustomLayoutBestDemo
//
//  Created by DCH on 2019/8/4.
//  Copyright © 2019 DCH. All rights reserved.
//

#import "CustomLayoutViewController.h"
#import "Layout.h"
#import "TextCollectionViewCell.h"

#define screen_w ([UIScreen mainScreen].bounds.size.width)
#define screen_h ([UIScreen mainScreen].bounds.size.height)

@interface CustomLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)Layout *layout;
@property(strong,nonatomic)UICollectionViewFlowLayout *flowlayout;
@property(strong,nonatomic)NSMutableArray *dataSources;

@end

@implementation CustomLayoutViewController

-(Layout *)layout
{
    if (!_layout) {
        _layout = [[Layout alloc] init];
        _layout.delegate = self;
        _layout.sectionInset = UIEdgeInsetsMake(5, 20, 0, 20);
        _layout.leftMarg = 20;
        _layout.rightMarg = 20;
        _layout.itemMargin = 10;
        _layout.sectionInsetTop = 5;
        _layout.headerReferenceSize = CGSizeMake(screen_w, 42);
        _layout.contentW = screen_w-40;
    }
    return _layout;
}

//-(UICollectionViewFlowLayout *)flowlayout
//{
//    if (!_flowlayout) {
//        _flowlayout = [[UICollectionViewFlowLayout alloc] init];
//        _flowlayout.minimumInteritemSpacing = 10;
//        _flowlayout.minimumLineSpacing = 10;
//        _flowlayout.sectionInset =UIEdgeInsetsMake(5, 20, 0, 20);
//    }
//    return _flowlayout;
//}


-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[TextCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [self loadData];
    
}

- (void)loadData{
    [self.dataSources addObject:@[@"哈哈哈",@"十九大政策",@"哈哈",@"哈哈哈哈哈",@"服务",@"数据是是"]];
    [self.dataSources addObject:@[@"哈哈哈",@"十九大政策",@"哈哈",@"哈哈哈哈哈",@"服务",@"数据是是"]];
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSources.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSources[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell configCellWithContent:self.dataSources[indexPath.section][indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(screen_w, 42);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self calculateWidth:self.dataSources[indexPath.section][indexPath.row] fontsize:15 labelH:32];
    return CGSizeMake(width+20, 32);
}

- (CGFloat)calculateWidth:(NSString *)str fontsize:(NSInteger)fontsize labelH:(CGFloat)height
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return rect.size.width;
}


@end
