//
//  UCTAnimTabBarItem.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTAnimTabBarItem.h"
#import "Masonry.h"
#import "UIView+Utils.h"
#import "UIColor+hexColor.h"

#define TITLE_LABEL_FONT [UIFont systemFontOfSize:9.f]
#define TITLE_LABEL_TEXT_COLOR [UIColor hexColor:@"bdbec0"]
#define TABBAR_ITEM_WIDTH 60.f

@interface UCTAnimTabBarItem ()
@end

@implementation UCTAnimTabBarItem
- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController index:(NSUInteger)index {
    self = [super init];
    if (self) {
        _index = index;
        _tabBarController = tabBarController;
        [self setupItem];
    }
    return self;
}
- (void)setupItem {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(TABBAR_ITEM_WIDTH));
    }];
    
    self.mainButton = [[UIButton alloc] init];
    [_mainButton addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainButton];
    
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"Anim"];
    [_titleLabel setFont:TITLE_LABEL_FONT];
    [_titleLabel setTextColor:TITLE_LABEL_TEXT_COLOR];
    [self addSubview:_titleLabel];
    
    self.mainImageView = [[UIImageView alloc] init];
    [self addSubview:_mainImageView];
    
    [_mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
    }];
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.leading.greaterThanOrEqualTo(self);
        make.bottom.equalTo(_titleLabel.mas_top);
        make.width.and.height.equalTo(@30);
    }];
}

- (void)handleClick {
    _tabBarController.selectedIndex = _index;
}
@end
