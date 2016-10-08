//
//  UCTHomeTabBarItem.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTHomeTabBarItem.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"

@interface UCTHomeTabBarItem ()
@property (strong, nonatomic) UIImageView *subImageView;
@property (strong, nonatomic) UIImageView *spotImageView;
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
    
    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
//    [_spotImageView setBackgroundColor:[UIColor hexColor:@"FAC852"]];
    [self addSubview:_spotImageView];
    [self sendSubviewToBack:_spotImageView];
    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
        make.centerX.equalTo(self.mainImageView);
        make.centerY.equalTo(self.mainImageView).offset(0);
    }];
}

- (void)handleClick {
    NSLog(@"点击了");
    [UIView animateWithDuration:0.2f animations:^{
        self.mainImageView.alpha = 0;
        self.subImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.titleLabel setText:@"刷新"];
    }];
    
    CABasicAnimation *subImageViewRotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    subImageViewRotationAnim.fromValue = @(-0.5*M_PI);
    subImageViewRotationAnim.toValue = @(0);
    CABasicAnimation *subImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    subImageViewScaleAnim.fromValue = @(0);
    subImageViewScaleAnim.toValue = @(1);
    
    CAAnimationGroup *subImageViewAnims = [CAAnimationGroup animation];
    [subImageViewAnims setAnimations:@[subImageViewRotationAnim, subImageViewScaleAnim]];
    subImageViewAnims.duration = 0.2f;
    [_subImageView.layer addAnimation:subImageViewAnims forKey:@"subImageView"];
}

- (void)releaseAnim {
    
}

- (void)selectedAnim {
    
}
@end
