//
//  UCTHomeTabBarItem.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTAnimTabBarItem.h"

typedef NS_ENUM(NSUInteger, HomeTabBarItemStatus) {
    HomeTabBarItemStatusWeather = 0,
    HomeTabBarItemStatusReading = 1,
    HomeTabBarItemStatusNeedsRefresh = 2,
};

@interface UCTHomeTabBarItem : UCTAnimTabBarItem
@property (assign, nonatomic) HomeTabBarItemStatus itemStatus;
@end
