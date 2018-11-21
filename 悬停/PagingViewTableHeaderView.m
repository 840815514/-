//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewTableHeaderView.h"
@interface PagingViewTableHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,YPagingViewTableHeaderViewCollectionViewCellDelegate>
@property (nonatomic, assign) CGRect imageViewFrame;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *indexImv;
@property (nonatomic, strong) UILabel *indexLbl;
@property (nonatomic, strong) UILabel *indexText;
@property (nonatomic, strong) UIButton *signInLbl;
@property (nonatomic, strong) UIImageView *signInImv;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *lineImv;
/**是否抖动*/
@property (nonatomic,assign) BOOL isBegin;
/**是否已经抖动*/
//@property (nonatomic,assign) BOOL isStarBegin;
/**抖动手势*/
//@property (nonatomic,strong) UILongPressGestureRecognizer *recognize;
///**移动手势*/
//@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;



@end

@implementation PagingViewTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];

        self.imageViewFrame = self.imageView.frame;
        
        //添加控件
        [self addSubview:self.indexImv];
        [self addSubview:self.indexLbl];
        [self addSubview:self.indexText];
        [self addSubview:self.signInLbl];
        [self addSubview:self.signInImv];
        [self addSubview:self.signInBtn];
        [self addSubview:self.searchBar];
        [self addSubview:self.lineImv];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopLongPress)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


#pragma mark 头部悬停 delegate 事件
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}


#pragma mark --- collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.listUIArr count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YPagingViewTableHeaderViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    YWebModel *model = self.listUIArr[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    if(_isBegin && model.canDelete) {
        [self starLongPress:cell];
        cell.deleteBtn.hidden = NO;
    }
    else {
        cell.deleteBtn.hidden = YES;
    }
    return cell;
}

#pragma mark - YPagingViewTableHeaderViewCollectionViewCell的delegate方法
//进入编辑状态
-(void)canEditCellThisCollectionView:(UILongPressGestureRecognizer *)longGesture;{
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.isBegin = YES;
            [self.collectionView reloadData];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}
//删除当前cell
-(void)deleteThisCellModel:(YWebModel *)model {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.listUIArr];
    [mArr removeObject:model];
    self.listUIArr = [mArr copy];
    self.collectionViewHeight = ceil([self.listUIArr count]/5.0)*70;
    if([self.delegate respondsToSelector:@selector(changeCollectionViewheight:)]) {
        [self.delegate changeCollectionViewheight:self.collectionViewHeight];
    }
    [self.collectionView reloadData];
}


#pragma mark 抖动动画
//开始抖动
- (void)starLongPress:(YPagingViewTableHeaderViewCollectionViewCell*)cell{
    CABasicAnimation *animation = (CABasicAnimation *)[cell.layer animationForKey:@"rotation"];
    if (animation == nil) {
        [self shakeImage:cell];
    }else {
        [self resume:cell];
    }
}
//这个参数的理解比较复杂，我的理解是所在layer的时间与父layer的时间的相对速度，为1时两者速度一样，为2那么父layer过了一秒，而所在layer过了两秒（进行两秒动画）,为0则静止。
- (void)pause:(YPagingViewTableHeaderViewCollectionViewCell*)cell {
    cell.layer.speed = 0.0;
}
- (void)resume:(YPagingViewTableHeaderViewCollectionViewCell*)cell {
    cell.layer.speed = 1.0;
}
- (void)shakeImage:(YPagingViewTableHeaderViewCollectionViewCell*)cell {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.08];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [cell.layer addAnimation:animation forKey:@"rotation"];
}

#pragma mark - 通过手势 停止编辑  抖动
-(void)stopLongPress {
    self.isBegin = NO;
    [self.collectionView reloadData];
}





#pragma mark - set
-(void)setListUIArr:(NSArray *)listUIArr {
    _listUIArr = listUIArr;
    [self addSubview:self.collectionView];
}
-(void)setCollectionViewHeight:(CGFloat)collectionViewHeight {
    _collectionViewHeight = collectionViewHeight;
    CGRect frame = self.collectionView.frame;
    frame.size.height = collectionViewHeight;
    self.collectionView.frame = frame;
    
    CGRect linFrame = self.lineImv.frame;
    linFrame.origin.y = 160+ collectionViewHeight;
    self.lineImv.frame = linFrame;
}

#pragma mark - 懒加载
-(UIImageView *)indexImv {
    if(_indexImv == nil) {
        _indexImv = [[UIImageView alloc]initWithFrame:CGRectMake(14, 45, 16, 12)];
        _indexImv.image = [UIImage imageNamed:@"图层 1"];
    }
    return _indexImv;
}
-(UILabel *)indexLbl {
    if(_indexLbl == nil) {
        _indexLbl = [[UILabel alloc]initWithFrame:CGRectMake(36, 35, 40, 24)];
        _indexLbl.text = @"48";
        _indexLbl.textColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
        _indexLbl.font = [UIFont systemFontOfSize:30];
    }
    return _indexLbl;
}
-(UILabel *)indexText {
    if(_indexText == nil) {
        _indexText = [[UILabel alloc]initWithFrame:CGRectMake(77, 48, 48, 11)];
        _indexText.text = @"恐慌指数";
        _indexText.font = [UIFont systemFontOfSize:11];
        _indexText.textColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
    }
    return _indexText;
}
-(UIButton *)signInLbl {
    if(_signInLbl == nil) {
        _signInLbl = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 37, 52, 23)];
        [_signInLbl setTitle:@"签到" forState:0];
        [_signInLbl setTitleColor:[UIColor colorWithRed:0.35 green:0.62 blue:0.96 alpha:1] forState:0];
        _signInLbl.layer.cornerRadius = 12;
        _signInLbl.layer.borderColor = [UIColor colorWithRed:0.35 green:0.62 blue:0.96 alpha:1].CGColor;
        _signInLbl.backgroundColor = [UIColor colorWithRed:0.89 green:0.93 blue:0.99 alpha:1];
        _signInLbl.titleLabel.font = [UIFont systemFontOfSize:13];
        _signInLbl.userInteractionEnabled = NO;
    }
    return _signInLbl;
}
-(UIImageView *)signInImv {
    if(_signInImv == nil) {
        _signInImv = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 87, 46, 30, 20)];
        _signInImv.image = [UIImage imageNamed:@"jinbi"];
    }
    return _signInImv;
}
-(UIButton *)signInBtn {
    if(_signInBtn == nil) {
        _signInBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 87, 37, 70, 30)];
    }
    return _signInBtn;
}
-(UISearchBar *)searchBar {
    if(_searchBar == nil) {
        
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(28, 83, [UIScreen mainScreen].bounds.size.width-56, 44)];
        _searchBar.showsCancelButton = NO;
        _searchBar.placeholder = @"搜索币名、交易所、应用、白皮书";
        _searchBar.layer.borderColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1].CGColor;
        _searchBar.layer.borderWidth = 1;
        _searchBar.layer.cornerRadius = 22;
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor whiteColor];
                    //设置默认文字颜色
                    UIColor *color = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索币名、交易所、应用、白皮书"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
                    textField.leftView = imageView;
                }
            }
        }
    }
    return _searchBar;
}
-(UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/5, 70);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 150,  [UIScreen mainScreen].bounds.size.width, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[YPagingViewTableHeaderViewCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    }
    return _collectionView;
}
-(UIImageView *)lineImv {
    if(_lineImv == nil) {
        _lineImv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        _lineImv.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    return _lineImv;
}

@end




@interface YPagingViewTableHeaderViewCollectionViewCell()
@property (nonatomic, strong) UIImageView *webBgImv;
@property (nonatomic, strong) UILabel *webTitleLbl;
@end

@implementation YPagingViewTableHeaderViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.webBgImv];
        [self.contentView addSubview:self.webTitleLbl];
        [self.contentView addSubview:self.deleteBtn];
        self.deleteBtn.hidden = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToNewVC:)];
        [self addGestureRecognizer:tap];
        
        
        
        //初始化一个长按手势
        UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
        //长按等待时间
        longPressGest.minimumPressDuration = 1;
        //长按时候,手指头可以移动的距离
        longPressGest.allowableMovement = 30;
        
        [self addGestureRecognizer:longPressGest];
    }
    return self;
}

#pragma mark - 手势事件
//点击事件
-(void)goToNewVC:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%@",self.model.id);
}
//长按编辑事件
-(void)longPressView:(UILongPressGestureRecognizer *)longGesture {
    if([self.delegate respondsToSelector:@selector(canEditCellThisCollectionView:)]) {
        [self.delegate canEditCellThisCollectionView:longGesture];
    }
}
-(void)deleteThisCellModel {
    if([self.delegate respondsToSelector:@selector(deleteThisCellModel:)]) {
        [self.delegate deleteThisCellModel:self.model];
    }
}
#pragma mark - set方法
-(void)setModel:(YWebModel *)model {
    _model = model;
    self.webTitleLbl.text = model.title;
}



#pragma mark - 懒加载
-(UIImageView *)webBgImv {
    if(_webBgImv == nil) {
        _webBgImv = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/10-20, 10, 40, 40)];
        _webBgImv.backgroundColor = [UIColor orangeColor];
    }
    return _webBgImv;
}
-(UILabel *)webTitleLbl {
    if(_webTitleLbl == nil) {
        _webTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, [UIScreen mainScreen].bounds.size.width/5, 15)];
        _webTitleLbl.textColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
        _webTitleLbl.textAlignment = NSTextAlignmentCenter;
        _webTitleLbl.font = [UIFont systemFontOfSize:12];
    }
    return _webTitleLbl;
}
-(UIButton *)deleteBtn {
    if(_deleteBtn == nil) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/10+7, 0, 25, 25)];
        [_deleteBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteThisCellModel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}



@end
