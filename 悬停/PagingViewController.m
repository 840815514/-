//
//  OCExampleViewController.m
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewController.h"
#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "PagingViewTableHeaderView.h"
#import "TestListBaseView.h"
#import "UIImage+imgaeWithColor.h"
#import "YWebModel.h"


//static const CGFloat JXTableHeaderViewHeight = 310;
//static const CGFloat JXheightForHeaderInSection = 50;

@interface PagingViewController () <JXPagerViewDelegate, JXCategoryViewDelegate,PagingViewTableHeaderViewDelegate>
//导航条上的searchBar
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;




@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;


@property (nonatomic, assign) CGFloat jXTableHeaderViewHeight;
@property (nonatomic, assign) CGFloat jXheightForCollectionView;
@property (nonatomic, assign) CGFloat jXheightForHeaderInSection;


@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
//    _titles = @[@"能力", @"爱好", @"队友",@"能力", @"爱好", @"队友",@"能力", @"爱好", @"队友"];

//    TestListBaseView *powerListView = [[TestListBaseView alloc] init];
////    powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
//
//    TestListBaseView *hobbyListView = [[TestListBaseView alloc] init];
////    hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
//
//    TestListBaseView *partnerListView = [[TestListBaseView alloc] init];
////    partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
////    YClassifyNewsViewController *powerListView = [YClassifyNewsViewController new];
////    YClassifyNewsViewController *hobbyListView = [YClassifyNewsViewController new];
////    YClassifyNewsViewController *partnerListView = [YClassifyNewsViewController new];
//    _listViewArray = @[powerListView, hobbyListView, partnerListView, powerListView, hobbyListView, partnerListView ,powerListView, hobbyListView, partnerListView];

//    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, JXheightForHeaderInSection)];
//    self.categoryView.titles = self.titles;
//    self.categoryView.backgroundColor = [UIColor whiteColor];
//    self.categoryView.delegate = self;
//    self.categoryView.titleSelectedColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
//    self.categoryView.titleColor = [UIColor blackColor];
//    self.categoryView.titleColorGradientEnabled = YES;
//    self.categoryView.titleLabelZoomEnabled = YES;
//
//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    lineView.indicatorLineViewColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
//    lineView.indicatorLineWidth = 30;
//    self.categoryView.indicators = @[lineView];

    //_pagingView = [[JXPagerView alloc] initWithDelegate:self];
    
    
    self.jXheightForHeaderInSection = 46;
    self.jXheightForCollectionView = ceil([self.listArr count]/5.0)*70;
    self.jXTableHeaderViewHeight = 170 + self.jXheightForCollectionView;
    
    [self.view addSubview:self.pagingView];

//    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    

}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagingView.frame = self.view.bounds;
}



#pragma mark 设置导航条
- (void)setupNavBar {
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 取消掉底部的那根线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.titleView = self.searchBar;
}


#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (CGFloat)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.jXTableHeaderViewHeight - 64;
}

- (CGFloat)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.jXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSArray<UIView<JXPagerViewListViewDelegate> *> *)listViewsInPagerView:(JXPagerView *)pagerView {
    return self.listViewArray;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
    
    
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
    CGFloat offset = scrollView.contentOffset.y - self.jXTableHeaderViewHeight/8;
    //根据透明度来生成图片
    //找最大值/
    CGFloat alpha = offset * 1 / 136.0;   // (200 - 64) / 136.0f
    if (alpha >= 1) {
        alpha = 0.99;
    }

    //拿到标题 标题文字的随着移动高度的变化而变化
    UISearchBar *searchbar = (UISearchBar *)self.navigationItem.titleView;
    searchbar.alpha = alpha;

    //把颜色生成图片
    UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
    //把颜色生成图片
    UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
    //修改导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - PagingViewTableHeaderView de Delegate
-(void)changeCollectionViewheight:(CGFloat)height {
    self.jXheightForCollectionView = height;
    
    self.jXTableHeaderViewHeight = 170 + self.jXheightForCollectionView;
    
    CGRect frame = self.userHeaderView.frame;
    frame.size.height = self.jXTableHeaderViewHeight;
    self.userHeaderView.frame = frame;
    
    [self.pagingView reloadData];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}



//#pragma mark - set
//-(void)setJXTableHeaderViewHeight:(CGFloat)jXTableHeaderViewHeight {
//    _jXTableHeaderViewHeight = jXTableHeaderViewHeight;
//
//}



#pragma mark - 懒加载
-(NSMutableArray *)listArr {
    if(_listArr == nil) {
        _listArr = [NSMutableArray new];
        
        
        YWebModel *m = [YWebModel new];
        m.href_addr = @"https://www.feixiaohao.com/";
        m.id = @"999";
        m.logo = @"http://103.229.116.92:51001/FtpUpload/admin/images/url_info/2018-08-13/TB99ab54YKn7G6j80J1y_1534146597407_28.png";
        m.title = @"IMtoken";
        m.canDelete = NO;
        [_listArr addObject:m];
        
        for (int i = 0; i < 7; i++) {
            YWebModel *model = [YWebModel new];
            model.href_addr = @"https://www.kcash.com/index-cn.html";
            model.id = [NSString stringWithFormat:@"%d",1000+i];
            model.logo = @"http://103.229.116.92:51001/FtpUpload/admin/images/url_info/2018-08-13/TB99ab54YKn7G6j80J1y_1534146597407_28.png";
            model.title = @"KCash";
            model.canDelete = YES;
            [_listArr addObject:model];
        }
        
        YWebModel *m1 = [YWebModel new];
        m1.href_addr = @"http://bi.vip/";
        m1.id = @"998";
        m1.logo = @"http://103.229.116.92:51001/FtpUpload/admin/images/url_info/2018-08-13/TB99ab54YKn7G6j80J1y_1534146597407_28.png";
        m1.title = @"OKEX";
        m1.canDelete = NO;
        [_listArr addObject:m1];
        
    }
    return _listArr;
}
-(NSArray<NSString *> *)titles {
    if(_titles == nil) {
        _titles = @[@"能力", @"爱好", @"队友",@"能力", @"爱好", @"队友",@"能力", @"爱好", @"队友"];
    }
    return _titles;
}
-(NSArray<TestListBaseView *> *)listViewArray {
    if(_listViewArray == nil) {
        TestListBaseView *powerListView = [[TestListBaseView alloc] init];
        TestListBaseView *hobbyListView = [[TestListBaseView alloc] init];
        TestListBaseView *partnerListView = [[TestListBaseView alloc] init];
        _listViewArray = @[powerListView, hobbyListView, partnerListView, powerListView, hobbyListView, partnerListView ,powerListView, hobbyListView, partnerListView];
    }
    return _listViewArray;
}
-(UISearchBar *)searchBar {
    if(_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 4, self.view.frame.size.width-40, 36)];
        _searchBar.alpha = 0;
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor orangeColor];
        _searchBar.placeholder = @"搜索币名、交易所、应用、白皮书";
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
                    //设置默认文字颜色
                    UIColor *color = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
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
-(JXPagerView *)pagingView {
    if(_pagingView == nil) {
        _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    }
    return _pagingView;
}
-(PagingViewTableHeaderView *)userHeaderView {
    if(_userHeaderView == nil) {
        _userHeaderView = [[PagingViewTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.jXTableHeaderViewHeight)];
        _userHeaderView.delegate = self;
        _userHeaderView.listUIArr = [self.listArr copy];
        _userHeaderView.collectionViewHeight = self.jXheightForCollectionView;
    }
    return _userHeaderView;
}
-(JXCategoryTitleView *)categoryView {
    if(_categoryView == nil) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, self.jXheightForHeaderInSection)];
        _categoryView.titles = self.titles;
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.delegate = self;
        _categoryView.titleSelectedColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
        _categoryView.titleColor = [UIColor blackColor];
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.titleLabelZoomEnabled = YES;
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineViewColor = [UIColor colorWithRed:0.31 green:0.6 blue:0.96 alpha:1];
        lineView.indicatorLineWidth = 30;
        _categoryView.indicators = @[lineView];
        _categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    }
    return _categoryView;
}
@end


