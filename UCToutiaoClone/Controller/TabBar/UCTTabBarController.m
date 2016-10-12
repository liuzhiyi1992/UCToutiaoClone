//
//  UCTTabBarController.m
//  UCToutiaoClone
//
//  Created by lzy on 16/10/8.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTTabBarController.h"
#import "UCTSubscribeTabBarItem.h"
#import "UCTVideoTabBarItem.h"
#import "UCTMineTabBarItem.h"
#import "UIView+Utils.h"
#import "Masonry.h"
#import "MainHomeController.h"

@interface UCTTabBarController ()
@property (strong, nonatomic) UIView *customTabBar;
@property (strong, nonatomic) NSMutableArray *tabBarItemList;
@end

@implementation UCTTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self cleanTheBlackLine];
    CGRect tabBarRect = self.tabBar.frame;
    
    self.customTabBar = [[UIView alloc] init];
    [_customTabBar setBackgroundColor:[UIColor whiteColor]];
    [_customTabBar setFrame:CGRectMake(0, 0, tabBarRect.size.width, tabBarRect.size.height)];
    [self.tabBar addSubview:_customTabBar];
    
    //item size由item自己决定
    UCTHomeTabBarItem *homeTabBarItem = [[UCTHomeTabBarItem alloc] initWithTabBarController:self index:0];
    UCTSubscribeTabBarItem *subscribeTabBarItem = [[UCTSubscribeTabBarItem alloc] initWithTabBarController:self index:1];
    UCTVideoTabBarItem *videoTabBarItem = [[UCTVideoTabBarItem alloc] initWithTabBarController:self index:2];
    UCTMineTabBarItem *mineTabBarItem = [[UCTMineTabBarItem alloc] initWithTabBarController:self index:3];
    [self.tabBarItemList addObject:homeTabBarItem];
    [self.tabBarItemList addObject:subscribeTabBarItem];
    [self.tabBarItemList addObject:videoTabBarItem];
    [self.tabBarItemList addObject:mineTabBarItem];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    for (UCTAnimTabBarItem *barItem in _tabBarItemList) {
        CGFloat itemCenterX = [self centerXOfTabBarItem:barItem];
        [_customTabBar addSubview:barItem];
        [barItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_customTabBar);
            make.centerY.equalTo(_customTabBar);
            make.centerX.equalTo(@(itemCenterX - viewWidth/2));
        }];
    }
}

- (void)cleanTheBlackLine {
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
}

- (void)mainHomeTabBarItemChangeAnimStatus:(HomeTabBarItemStatus)status {
    UCTHomeTabBarItem *homeTabBarItem = (UCTHomeTabBarItem *)_tabBarItemList.firstObject;
    if (homeTabBarItem.itemStatus == HomeTabBarItemStatusNeedsRefresh) {
        return;
    }
    [homeTabBarItem setItemStatus:status];
}

- (CGPoint)centerOfTabBarItem:(UCTAnimTabBarItem *)item {
    NSUInteger index = [_tabBarItemList indexOfObject:item];
    CGFloat drawerWidth = self.view.bounds.size.width / _tabBarItemList.count;
    CGFloat centerX = (index+0.5) * drawerWidth;
    return CGPointMake(centerX, _customTabBar.frame.size.height/2);
}

- (CGFloat)centerXOfTabBarItem:(UCTAnimTabBarItem *)item {
    NSUInteger index = [_tabBarItemList indexOfObject:item];
    CGFloat drawerWidth = self.view.bounds.size.width / _tabBarItemList.count;
    CGFloat centerX = (index+0.5) * drawerWidth;
    return centerX;
}

- (NSMutableArray *)tabBarItemList {
    if (nil == _tabBarItemList) {
        _tabBarItemList = [NSMutableArray array];
    }
    return _tabBarItemList;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    if (self.selectedIndex == selectedIndex) {
        if (selectedIndex == 0) {//首页
            //刷新
            UINavigationController *navController = (UINavigationController *)[self.childViewControllers objectAtIndex:selectedIndex];
            MainHomeController *mainHomeController = (MainHomeController *)navController.topViewController;
            [mainHomeController refreshCurrentPage];
        }
    } else {
        UCTAnimTabBarItem *previousItem = [_tabBarItemList objectAtIndex:self.selectedIndex];
        [previousItem releaseAnim];
        [super setSelectedIndex:selectedIndex];
        UCTAnimTabBarItem *currentItem = [_tabBarItemList objectAtIndex:self.selectedIndex];
        [currentItem selectedAnim];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
