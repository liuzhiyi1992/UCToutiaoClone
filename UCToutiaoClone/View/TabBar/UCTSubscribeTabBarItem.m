//
//  UCTSubscribeTabBarItem.m
//  UCToutiaoClone
//
//  Created by lzy on 16/10/9.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTSubscribeTabBarItem.h"

@interface UCTSubscribeTabBarItem ()
@property (strong, nonatomic) UIImageView *spotImageView;
@end

@implementation UCTSubscribeTabBarItem
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupItem];
    }
    return self;
}

- (void)setupItem {
    [super setupItem];
}

@end
