//
//  MainHomeController.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "MainHomeController.h"
#import "ZYNavCategoryView.h"
#import "ZYHCategoryItemCell.h"
#import "Masonry.h"

#define NAV_COLLECTION_VIEW_HEIGHT 40
#define NAV_COLLECTION_VIEW_CONTENT_INSET UIEdgeInsetsMake(0, 12, 0, 12)
#define NAV_COLLECTION_VIEW_CELL_SIZE CGSizeMake(80, NAV_COLLECTION_VIEW_HEIGHT)

@interface MainHomeController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) ZYNavCategoryView *categoryView;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) NSArray *categoryList;
@end

@implementation MainHomeController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self setupCustomNavView];
    [self setupCategoryBar];
    [self setupMainScrollView];
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
    
}

- (void)setupCategoryBar {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = NAV_COLLECTION_VIEW_CELL_SIZE;
    self.categoryView = [[ZYNavCategoryView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_categoryView registerClass:[ZYHCategoryItemCell class] forCellWithReuseIdentifier:[ZYHCategoryItemCell cellReuseIdentifier]];
    [_categoryView setShowsHorizontalScrollIndicator:NO];
    _categoryView.delegate = self;
    _categoryView.dataSource = self;
    _categoryView.contentInset = NAV_COLLECTION_VIEW_CONTENT_INSET;
    [self.view addSubview:_categoryView];
    
    [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@NAV_COLLECTION_VIEW_HEIGHT);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)setupMainScrollView {
    self.mainScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_mainScrollView];
//    [_mainScrollView setBounces:NO];
    [_mainScrollView setPagingEnabled:YES];
    [_mainScrollView setShowsHorizontalScrollIndicator:NO];
    [_mainScrollView setDelegate:self];
    [_mainScrollView setBackgroundColor:[UIColor redColor]];
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)queryCategoryData {
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _categoryList.count;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
