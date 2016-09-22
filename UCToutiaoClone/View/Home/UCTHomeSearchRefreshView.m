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
#define TEXT_FONT [UIFont systemFontOfSize:12.f]
#define TEXT_FONT_COLOR [UIColor hexColor:@"9C9DA0"]

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
    }];
    
    UIView *searchBar = [self createSearchBar];
    [self addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@SEARCH_BAR_HEIGHT);
        make.leading.equalTo(self).offset(SEARCH_BAR_LEADING_TRAILNG);
        make.trailing.equalTo(self).offset(-SEARCH_BAR_LEADING_TRAILNG);
        make.bottom.equalTo(self).offset(-SEARCH_BAR_MARGIN_BOTTOM);
    }];
}

- (UIView *)createSearchBar {
    UIView *searchBar = [[UIView alloc] init];
    [searchBar setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *placeHolderButton = [[UIButton alloc] init];
    [placeHolderButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [placeHolderButton setTitle:TEXT_PLACEHOLDER forState:UIControlStateNormal];
    [placeHolderButton setTitleColor:TEXT_FONT_COLOR forState:UIControlStateNormal];
    [placeHolderButton.titleLabel setFont:TEXT_FONT];
    [placeHolderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
    [searchBar addSubview:placeHolderButton];
    
    [placeHolderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(searchBar);
        make.center.equalTo(searchBar);
    }];
    return searchBar;
}

- (CGFloat)searchRefreshViewHeight {
    if (self.bounds.size.height <= 0) {
        return SELF_HEIGHT;
    }
    return self.bounds.size.height;
}

@end
