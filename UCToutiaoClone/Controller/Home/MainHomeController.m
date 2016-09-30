//
//  MainHomeController.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "MainHomeController.h"
#import "ZYNavChannelView.h"
#import "ZYHChannelItemCell.h"
#import "Masonry.h"
#import "ZYHPageTableViewController.h"
#import "ZYHChannelModel.h"
#import "NewsService.h"
#import "UIColor+hexColor.h"
#import "ZYHPageCollectionViewController.h"
#import "UCTClipAnimatedView.h"
#import "UCTWeatherAnimatedView.h"

const NSInteger PRELOAD_PAGE_NUMBER = 3;//!!单数
const BOOL OPEN_PAGE_RECOVER_MECHANISM = YES;
const BOOL ONLY_LOAD_DEFAULT_CHANNEL = YES;


//const CGFloat CUSTOM_NAV_DISPLAY_HEIGHT = 64;
//const CGFloat CUSTOM_NAV_HEIGHT = 375;//184
//const CGFloat MAIN_SCROLLVIEW_OFFSET_TOP = CUSTOM_NAV_HEIGHT - CUSTOM_NAV_DISPLAY_HEIGHT;

#define CHANNEL_SLIDER_ANIMATE_DURATION 0.2f
#define CHANNEL_COLLECTION_VIEW_HEIGHT 40
#define CHANNEL_COLLECTION_VIEW_CONTENT_INSET UIEdgeInsetsMake(0, 12, 0, 12)
#define CHANNEL_COLLECTION_VIEW_CELL_SIZE CGSizeMake(60, CHANNEL_COLLECTION_VIEW_HEIGHT)
#define CHANNEL_SLIDER_BAR_HEIGHT 2.f
#define CHANNEL_SLIDER_BAR_COLOR [UIColor hexColor:@"F85368"]

#define HOME_PAGE_SCROLL_VIEW_HEIGHT (SCREEN_HEIGHT - CHANNEL_COLLECTION_VIEW_HEIGHT - 20 - 49)//tabBar49, statusBar20


@interface MainHomeController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (strong, nonatomic) ZYNavChannelView *navChannelview;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIScrollView *homePageScrollView;
@property (strong, nonatomic) UCTClipAnimatedView *mainNavView;
@property (strong, nonatomic) UIView *sliderBar;
@property (strong, nonatomic) UIView *networkMaskView;
@property (strong, nonatomic) NSArray *navChannelList;
@property (strong, nonatomic) NSArray *preloadPageIndexList;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSIndexPath *selectedChannelIndexPath;
@end

@implementation MainHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.translucent = NO;
    [self setupMainScrollView];
    [self setupCustomNavView];
    [self setupNavChannelBar];
    [self setupPageScrollView];
    [self setupNetworkMaksView];
    [self queryChannelData];
    
    
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"自定" image:[UIImage imageNamed:@"icon_search"] selectedImage:[UIImage imageNamed:@"icon_search"]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_BEGIN_WEATHER_ANIMATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupMainScrollView {
    self.mainScrollView = [[UIScrollView alloc] init];
    [_mainScrollView setShowsVerticalScrollIndicator:NO];
    [_mainScrollView setBounces:NO];
    [_mainScrollView setDelegate:self];
    [_mainScrollView setContentSize:CGSizeMake(0, CUSTOM_NAV_HEIGHT + CHANNEL_COLLECTION_VIEW_HEIGHT + HOME_PAGE_SCROLL_VIEW_HEIGHT)];
    [self.view addSubview:_mainScrollView];
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-MAIN_SCROLLVIEW_OFFSET_TOP);//mainScroll往上噻了多少
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setupCustomNavView {
    self.mainNavView = [[UCTClipAnimatedView alloc] init];
    self.scrollDelegate = (id<MainHomeControllerScrollDelegate>)_mainNavView;
    [self.mainScrollView addSubview:_mainNavView];
    
    [_mainNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(CUSTOM_NAV_HEIGHT));
        make.top.equalTo(_mainScrollView);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)setupNavChannelBar {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = CHANNEL_COLLECTION_VIEW_CELL_SIZE;
    self.navChannelview = [[ZYNavChannelView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_navChannelview registerClass:[ZYHChannelItemCell class] forCellWithReuseIdentifier:[ZYHChannelItemCell cellReuseIdentifier]];
    [_navChannelview setShowsHorizontalScrollIndicator:NO];
    _navChannelview.delegate = self;
    _navChannelview.dataSource = self;
    _navChannelview.contentInset = CHANNEL_COLLECTION_VIEW_CONTENT_INSET;
    [self.mainScrollView addSubview:_navChannelview];
    
    [_navChannelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@CHANNEL_COLLECTION_VIEW_HEIGHT);
        make.top.equalTo(_mainNavView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    //sliderBar
    [self setupSliderBar];
}

- (void)setupPageScrollView {
    self.homePageScrollView = [[UIScrollView alloc] init];
    [_mainScrollView addSubview:_homePageScrollView];
    [_homePageScrollView setBounces:NO];
    [_homePageScrollView setPagingEnabled:YES];
    [_homePageScrollView setShowsHorizontalScrollIndicator:NO];
    [_homePageScrollView setDelegate:self];
    
    [_homePageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@HOME_PAGE_SCROLL_VIEW_HEIGHT);
        make.top.equalTo(_navChannelview.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-44);
    }];
}

- (void)setupHomeTableViewControllers {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        for (int i = 0; i < _navChannelList.count; i ++) {
            ZYHPageCollectionViewController *tableVC = [[ZYHPageCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
            //todo
            tableVC.scrollDelegate = (id<ZYHPageCollectionViewControllerDelegate>)_mainNavView;
            tableVC.homePageScrollView = _mainScrollView;
            [self addChildViewController:tableVC];
             [_homePageScrollView addSubview:tableVC.view];
            [tableVC.view setFrame:CGRectMake(i * screenWidth, 0, _homePageScrollView.frame.size.width, _homePageScrollView.frame.size.height)];
        }
        [_homePageScrollView setContentSize:CGSizeMake(_navChannelList.count * screenWidth, 0)];
    });
}

- (void)setupSliderBar {
    self.sliderBar = [[UIView alloc] init];
    [_sliderBar setBackgroundColor:CHANNEL_SLIDER_BAR_COLOR];
    [self.navChannelview addSubview:_sliderBar];
}

- (void)setupNetworkMaksView {
    self.networkMaskView = [[UIView alloc] init];
    [_networkMaskView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_networkMaskView];
    
    [_networkMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mainNavView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)showNetworkMaskView {
    [self.view bringSubviewToFront:_networkMaskView];
    [_networkMaskView setAlpha:1.f];
}

- (void)hideNetworkView {
    [UIView animateWithDuration:1.f animations:^{
        [_networkMaskView setAlpha:0.f];
    }];
}

- (void)queryChannelData {
    __weak __typeof(&*self)weakSelf = self;
    [self showNetworkMaskView];
    [NewsService queryNavChannelWithcompletion:^(UCTNetworkResponseStatus status, NSArray *channelList) {
        if (status == UCTNetworkResponseSucceed) {
            [weakSelf packageChannelDataWithChannelList:channelList];
            [weakSelf hideNetworkView];
        } else {
            NSLog(@"");
        }
    }];
}

- (void)packageChannelDataWithChannelList:(NSArray *)channelList {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *channel in channelList) {
        ZYHChannelModel *model = [[ZYHChannelModel alloc] initWithChannelDict:channel];
        if (model.isDefault || !ONLY_LOAD_DEFAULT_CHANNEL) {
            [mutArray addObject:model];
        }
    }
    self.navChannelList = [mutArray copy];
    [_navChannelview reloadData];
    [_navChannelview layoutIfNeeded];
    [self setupHomeTableViewControllers];
    [self defaultToSelectfirstPage];
}

- (void)defaultToSelectfirstPage {
    self.currentPage = 0;
}

- (void)tapToChangeChannel:(NSIndexPath *)indexPath animated:(BOOL)animated isProactive:(BOOL)isProactive {
    //previous cell
    if (_selectedChannelIndexPath) {
        ZYHChannelItemCell *previousCell = (ZYHChannelItemCell *)[_navChannelview cellForItemAtIndexPath:_selectedChannelIndexPath];
        [previousCell changeCellSelect:NO];
        ZYHChannelModel *previousModel = _navChannelList[_selectedChannelIndexPath.row];
        previousModel.isSelected = NO;
    }
    //current cell
    ZYHChannelItemCell *cell = (ZYHChannelItemCell *)[_navChannelview cellForItemAtIndexPath:indexPath];
    [cell changeCellSelect:YES];
    ZYHChannelModel *currentModel = _navChannelList[indexPath.row];
    currentModel.isSelected = YES;
    //scroll channelBar
    [_navChannelview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //update selection
    self.selectedChannelIndexPath = indexPath;
    //update sliderBar
    [self updateSliderBarWithCell:cell animated:animated];
    //scroll Page
    if (isProactive) {
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        [_homePageScrollView setContentOffset:CGPointMake(indexPath.row * screenWidth, 0) animated:NO];
    }
}

- (void)updateSliderBarWithCell:(ZYHChannelItemCell *)cell animated:(BOOL)animated {
    CGRect convertRect = [cell convertRect:cell.titleLabel.frame toView:_navChannelview];
    CGFloat animateDuration = animated ? CHANNEL_SLIDER_ANIMATE_DURATION : 0.f;
    [UIView animateWithDuration:animateDuration animations:^{
        [self updateSliderBarLocation:CGRectMake(CGRectGetMinX(convertRect), [self sliderBarLocationY], CGRectGetWidth(convertRect), CHANNEL_SLIDER_BAR_HEIGHT)];
    }];
}

- (CGFloat)sliderBarLocationY {
    return CGRectGetHeight(_navChannelview.frame) - CHANNEL_SLIDER_BAR_HEIGHT;
}

- (void)updateSliderBarLocation:(CGRect)locationRect {
    [_sliderBar setFrame:locationRect];
}

- (void)generatorHomeTableViewWithPage:(NSInteger)page {
    //同时加载前后两页(页面VC内部做重复加载避免)
    NSMutableArray *loadedPageArray = [NSMutableArray array];
    [self loadPageDataWithPage:page];
    [loadedPageArray addObject:@(page)];
    for (int i = 0; i < PRELOAD_PAGE_NUMBER/2; i ++) {
        [self loadPageDataWithPage:page + (i+1)];
        [loadedPageArray addObject:@(page + (i+1))];
        [self loadPageDataWithPage:page - (i+1)];
        [loadedPageArray addObject:@(page - (i+1))];
    }
    self.preloadPageIndexList = [loadedPageArray copy];
}

- (void)loadPageDataWithPage:(NSInteger)page {
    if ([self validPage:page]) {
        ZYHChannelModel *model = [_navChannelList objectAtIndex:page];
        ZYHPageTableViewController *viewController = [[self childViewControllers] objectAtIndex:page];
        [viewController setChannelId:model.channelId];
    }
}

- (BOOL)validPage:(NSInteger)page {
    if (page >= 0 && page < _navChannelList.count) {
        return YES;
    }
    return NO;
}

- (void)handleFreshCategoryPageDataWithPageIndexList:(NSArray *)pageIndexList {
    BOOL canNotFresh = NO;
    for (NSNumber *previousNumber in _preloadPageIndexList) {
        if ([self validPage:previousNumber.integerValue]) {
            //有效page
            for (NSNumber *currentNumber in pageIndexList) {
                if ([previousNumber isEqualToNumber:currentNumber]) {
                    //包含，不需释放
                    canNotFresh = YES;
                    break;
                } else {
                    //继续寻找
                    canNotFresh = NO;
                    continue;
                }
            }
            if (!canNotFresh) {
                //不包含，fresh
                [self freshTableViewDataWithPage:[previousNumber integerValue]];
            }
        } else {
            //无效page不处理
            continue;
        }
    }
}

- (void)freshTableViewDataWithPage:(NSInteger)page {
    ZYHPageTableViewController *viewController =  [[self childViewControllers] objectAtIndex:page];
    if (viewController) {
        [viewController freshData];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYHChannelItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZYHChannelItemCell cellReuseIdentifier] forIndexPath:indexPath];
    ZYHChannelModel *model = _navChannelList[indexPath.row];
    [cell updateCellWithChannel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _navChannelList.count;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self tapToChangeChannel:indexPath animated:YES isProactive:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_homePageScrollView]) {
        CGFloat scrollContentOffsetX = scrollView.contentOffset.x;
        int currentPage = [[NSString stringWithFormat:@"%.0f", (scrollContentOffsetX / [[UIScreen mainScreen] bounds].size.width)] intValue];
        if (currentPage != _currentPage) {
            self.currentPage = currentPage;
        }
    } else if ([scrollView isEqual:_mainScrollView]) {
        CGFloat scrollContentOffsetY = scrollView.contentOffset.y;
        [_scrollDelegate mainHomeScrollViewDidScroll2OffsetY:scrollContentOffsetY];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
    [self tapToChangeChannel:indexPath animated:YES isProactive:NO];
    [self generatorHomeTableViewWithPage:currentPage];
}

- (void)setPreloadPageIndexList:(NSArray *)preloadPageIndexList {
    //fresh
    if (OPEN_PAGE_RECOVER_MECHANISM) {
        [self handleFreshCategoryPageDataWithPageIndexList:preloadPageIndexList];
    }
    _preloadPageIndexList = [preloadPageIndexList copy];
}

@end
