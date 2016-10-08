//
//  UCTHomeTabBarItem.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTHomeTabBarItem.h"
#import "Masonry.h"

@interface UCTHomeTabBarItem ()
@property (strong, nonatomic) UIImageView *subImageView;
@end

@implementation UCTHomeTabBarItem
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupItem];
    }
    return self;
}

- (void)setupItem {
    [super setupItem];
    [self.mainImageView setImage:[UIImage imageNamed:@"icon_home"]];
    [self.titleLabel setText:@"首页"];
    
    self.subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh"]];
    _subImageView.alpha = 0;
    [self addSubview:_subImageView];
    [_subImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainImageView);
    }];
}

- (void)handleClick {
    NSLog(@"点击了");
//    self.subImageView.transform = CGAffineTransformMakeRotation(-0.5*M_PI);
    [UIView animateWithDuration:0.5f animations:^{
        self.mainImageView.alpha = 0;
        self.subImageView.alpha = 1;
//        self.subImageView.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)releaseAnim {
    
}

- (void)selectedAnim {
    
}
@end
