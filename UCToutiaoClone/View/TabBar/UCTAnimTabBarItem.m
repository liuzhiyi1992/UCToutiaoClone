//
//  UCTAnimTabBarItem.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTAnimTabBarItem.h"
#import "Masonry.h"

#define TITLE_LABEL_FONT [UIFont systemFontOfSize:10.f]

@interface UCTAnimTabBarItem ()
@end

@implementation UCTAnimTabBarItem
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self setupItem];
//    }
//    return self;
//}

- (void)setupItem {
    self.mainButton = [[UIButton alloc] init];
    [_mainButton addTarget:self action:@selector(handleClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"动画"];
    [_titleLabel setFont:TITLE_LABEL_FONT];
    
    self.mainImageView = [[UIImageView alloc] init];
    [_mainImageView setImage:[UIImage imageNamed:@"icon_search"]];
    
    [_mainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-2);
    }];
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.leading.greaterThanOrEqualTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(_titleLabel.mas_top);
    }];
}

- (void)handleClick {
    NSLog(@"点击");
}
@end
