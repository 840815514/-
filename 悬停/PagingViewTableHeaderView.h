//
//  PagingViewTableHeaderView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWebModel.h"

@protocol PagingViewTableHeaderViewDelegate <NSObject>
-(void)changeCollectionViewheight:(CGFloat)height;
@end

@interface PagingViewTableHeaderView : UIView

@property (nonatomic, copy) NSArray *listUIArr;
@property (nonatomic, assign) CGFloat collectionViewHeight;
@property (nonatomic, assign) id<PagingViewTableHeaderViewDelegate> delegate;
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end





@protocol YPagingViewTableHeaderViewCollectionViewCellDelegate <NSObject>
-(void)canEditCellThisCollectionView:(UILongPressGestureRecognizer *)longGesture;
-(void)deleteThisCellModel:(YWebModel *)model;
@end

@interface YPagingViewTableHeaderViewCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) YWebModel *model;
@property (nonatomic, assign) id<YPagingViewTableHeaderViewCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) UIButton *deleteBtn;
@end
