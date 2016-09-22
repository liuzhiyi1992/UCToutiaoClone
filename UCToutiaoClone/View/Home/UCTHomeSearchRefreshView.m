//
//  UCTHomeSearchRefreshView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/22.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTHomeSearchRefreshView.h"
#import "UIColor+hexColor.h"
#import "Masonry.h"

#define SEARCH_BAR_LEADING_TRAILNG 10
#define SEARCH_BAR_MARGIN_BOTTOM 10
#define SEARCH_BAR_HEIGHT 30
#define SELF_HEIGHT (2*SEARCH_BAR_MARGIN_BOTTOM + SEARCH_BAR_HEIGHT)
#define TEXT_PLACEHOLDER @"搜索文章、订阅号"

@interface UCTHomeSearchRefreshView ()
@end

@implementation UCTHomeSearchRefreshView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setBackgroundColor:[UIColor hexColor:@"f9f9f9"]];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@SELF_HEIGHT);
        make.width.equalTo(@([[UIScreen mainScreen] bounds].size.width));
    }];
    
    UIView *searchBar = [self createSearchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@SEARCH_BAR_HEIGHT);
        make.leading.equalTo(self).offset(SEARCH_BAR_LEADING_TRAILNG);
        make.trailing.equalTo(self).offset(-SEARCH_BAR_LEADING_TRAILNG);
        make.bottom.equalTo(self).offset(-SEARCH_BAR_MARGIN_BOTTOM);
    }];
    [self addSubview:searchBar];
}

- (UIView *)createSearchBar {
    UIView *searchBar = [[UIView alloc] init];
    [searchBar setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *placeHolderButton = [[UIButton alloc] init];
    [placeHolderButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [placeHolderButton setTitle:TEXT_PLACEHOLDER forState:UIControlStateNormal];
    [placeHolderButton.titleLabel setFont:[UIFont systemFontOfSize:10.f]];
    [searchBar addSubview:placeHolderButton];
    
    [placeHolderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(searchBar);
    }];
    return searchBar;
    
//    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
//    UILabel *textLabel = [[UILabel alloc] init];
//    [textLabel setText:TEXT_PLACEHOLDER];
//    [textLabel setFont:[UIFont systemFontOfSize:10.f]];
//    [searchBar addSubview:searchIcon];
//    [searchIcon addSubview:textLabel];
}

@end
