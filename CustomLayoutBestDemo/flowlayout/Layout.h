//
//  Layout.h
//  FlowLayoutDemo
//
//  Created by king on 16/8/1.
//  Copyright © 2016年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LayoutDelegate<NSObject>

@optional
- (void)getchangeLineCount:(NSInteger)count;

@end

@interface Layout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic,strong)NSMutableDictionary *sizeDic;// 用于存放cell的frame
@property (nonatomic,retain)NSMutableArray *sectionArr;//存放section的y轴坐标
@property (nonatomic,assign)CGFloat sectionInsetTop;
//有sectionHeader或者其他需求，自行修改这个属性，这是额外的frame
@property (nonatomic,assign)CGSize  supplementaryViewSize;
@property (assign, nonatomic)CGFloat  leftMarg;
@property (assign, nonatomic)CGFloat  rightMarg;
@property (assign, nonatomic)CGFloat  plusWidth;
@property (assign, nonatomic)CGFloat  itemMargin;
@property (assign, nonatomic)CGFloat  contentW;

@property(weak, nonatomic)id<LayoutDelegate> layoutdelegate;

@end
