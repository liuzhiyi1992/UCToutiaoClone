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

#define NAV_SLIDER_ANIMATE_DURATION 0.5f
#define NAV_COLLECTION_VIEW_HEIGHT 40
#define NAV_COLLECTION_VIEW_CONTENT_INSET UIEdgeInsetsMake(0, 12, 0, 12)
#define NAV_COLLECTION_VIEW_CELL_SIZE CGSizeMake(50, NAV_COLLECTION_VIEW_HEIGHT)

#define NAV_SLIDER_BAR_HEIGHT 4.f


@interface MainHomeController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (strong, nonatomic) ZYNavChannelView *navChannelview;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainNavView;
@property (strong, nonatomic) UIView *sliderBar;
@property (strong, nonatomic) NSArray *navChannelList;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSIndexPath *selectedChannelIndexPath;
@end

@implementation MainHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomNavView];
    [self setupNavChannelBar];
    [self setupMainScrollView];
    [self queryChannelData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupCustomNavView {
    self.mainNavView = [[UIView alloc] init];
    [_mainNavView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_mainNavView];
    
    [_mainNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@64);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)setupNavChannelBar {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = NAV_COLLECTION_VIEW_CELL_SIZE;
    self.navChannelview = [[ZYNavChannelView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_navChannelview registerClass:[ZYHChannelItemCell class] forCellWithReuseIdentifier:[ZYHChannelItemCell cellReuseIdentifier]];
    [_navChannelview setShowsHorizontalScrollIndicator:NO];
    _navChannelview.delegate = self;
    _navChannelview.dataSource = self;
    _navChannelview.contentInset = NAV_COLLECTION_VIEW_CONTENT_INSET;
    [self.view addSubview:_navChannelview];
    
    [_navChannelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@NAV_COLLECTION_VIEW_HEIGHT);
        make.top.equalTo(_mainNavView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)setupMainScrollView {
    self.mainScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_mainScrollView];
    [_mainScrollView setPagingEnabled:YES];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    [_mainScrollView setDelegate:self];
    [_mainScrollView setBackgroundColor:[UIColor redColor]];
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navChannelview.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setupHomeTableViewControllers {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    for (int i = 0; i < _navChannelList.count; i ++) {
        ZYHPageTableViewController *tableVC = [[ZYHPageTableViewController alloc] init];
        [self addChildViewController:tableVC];
        [tableVC.view setBackgroundColor:[UIColor greenColor]];
         [_mainScrollView addSubview:tableVC.view];
        [tableVC.view setFrame:CGRectMake(i * screenWidth, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
    }
    [_mainScrollView setContentSize:CGSizeMake(_navChannelList.count * screenWidth, 0)];
}

- (void)queryChannelData {
    [NewsService queryNavChannelWithcompletion:^(UCTNetworkResponseStatus status, NSArray *channelList) {
        if (status == UCTNetworkResponseSucceed) {
            NSLog(@"");
            [self packageChannelDataWithChannelList:channelList];
        } else {
            NSLog(@"");
        }
    }];
}

- (void)packageChannelDataWithChannelList:(NSArray *)channelList {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *channel in channelList) {
        ZYHChannelModel *model = [[ZYHChannelModel alloc] initWithChannelDict:channel];
        [mutArray addObject:model];
    }
    self.navChannelList = [mutArray copy];
    [_navChannelview reloadData];
    [_navChannelview layoutIfNeeded];
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
    //scroll navBar
    [_navChannelview scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //update selection
    self.selectedChannelIndexPath = indexPath;
    //update sliderBar
    [self updateSliderBarWithCell:cell animated:animated];
    //scroll Page
    if (isProactive) {
        CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
        [_mainScrollView setContentOffset:CGPointMake(indexPath.row * screenWidth, 0) animated:NO];
    }
}

- (void)updateSliderBarWithCell:(ZYHChannelItemCell *)cell animated:(BOOL)animated {
    CGRect convertRect = [cell convertRect:cell.titleLabel.frame toView:_navChannelview];
    CGFloat animateDuration = NAV_SLIDER_ANIMATE_DURATION;
    if (!animated) {
        animateDuration = 0.f;
    }
    [UIView animateWithDuration:animateDuration animations:^{
        [self updateSliderBarLocation:CGRectMake(CGRectGetMinX(convertRect), [self sliderBarLocationY], CGRectGetWidth(convertRect), NAV_SLIDER_BAR_HEIGHT)];
    }];
}

- (CGFloat)sliderBarLocationY {
    return CGRectGetHeight(_navChannelview.frame) - NAV_SLIDER_BAR_HEIGHT;
}

- (void)updateSliderBarLocation:(CGRect)locationRect {
    [_sliderBar setFrame:locationRect];
}

- (void)generatorHomeTableViewWithPage:(NSInteger)page {
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tapToChangeChannel:indexPath animated:YES isProactive:NO];
    [self generatorHomeTableViewWithPage:currentPage];
}

@end
