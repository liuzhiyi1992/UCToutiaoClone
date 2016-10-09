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
@property (assign, nonatomic) BOOL tmpFlag;
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
    _spotImageView.alpha = 0;
    [self addSubview:_spotImageView];
    [self sendSubviewToBack:_spotImageView];
    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
        make.center.equalTo(self.mainImageView);
    }];
}

- (void)handleClick {
    if (_tmpFlag) {
        [self releaseAnim];
        self.tmpFlag = NO;
    } else {
        [self selectedAnim];
        self.tmpFlag = YES;
    }
}

- (void)releaseAnim {
    _spotImageView.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.mainImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.titleLabel setText:@"首页"];
    }];
    //mainImageView
    CABasicAnimation *mainImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    mainImageViewScaleAnim.fromValue = @(1.2);
    mainImageViewScaleAnim.toValue = @(1);
    mainImageViewScaleAnim.duration = 0.3f;
    [self.mainImageView.layer addAnimation:mainImageViewScaleAnim forKey:@"mainImageView"];
    
    //subImageView
    CABasicAnimation *subImageViewRotationAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    NSValue *fromVal = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.f, 0.0f, 0.f, 0.f)];
    NSValue *toVal = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.5*M_PI, 0.0f, 0.0f, -1.0f)];
    subImageViewRotationAnim.fromValue = fromVal;
    subImageViewRotationAnim.toValue = toVal;
    CABasicAnimation *subImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    subImageViewScaleAnim.fromValue = @(1);
    subImageViewScaleAnim.toValue = @(0);
    CAAnimationGroup *subImageViewAnims = [CAAnimationGroup animation];
    [subImageViewAnims setAnimations:@[subImageViewRotationAnim, subImageViewScaleAnim]];
    subImageViewAnims.duration = 0.3f;
    [_subImageView.layer addAnimation:subImageViewAnims forKey:@"subImageView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CATransform3D combine;
    CATransform3D rotate;
    CATransform3D scale;
    scale = CATransform3DMakeScale(0.f, 0.f, 0.f);
    rotate = CATransform3DMakeRotation(0.5*M_PI, 0.0f, 0.0f, -1.0f);
    combine = CATransform3DConcat(rotate, scale);
    [_subImageView.layer setTransform:combine];
    [CATransaction commit];
}

- (void)selectedAnim {
    _subImageView.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.mainImageView.alpha = 0;
        _subImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [self.titleLabel setText:@"刷新"];
    }];
    //mainImageView
    CABasicAnimation *mainImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    mainImageViewScaleAnim.fromValue = @(1);
    mainImageViewScaleAnim.toValue = @(1.2);
    mainImageViewScaleAnim.duration = 0.3f;
    [self.mainImageView.layer addAnimation:mainImageViewScaleAnim forKey:@"mainImageView"];
    
    //subImageView
    CABasicAnimation *subImageViewRotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    subImageViewRotationAnim.fromValue = @(-0.5*M_PI);
    subImageViewRotationAnim.toValue = @(0);
    CABasicAnimation *subImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    subImageViewScaleAnim.fromValue = @(0);
    subImageViewScaleAnim.toValue = @(1);
    CAAnimationGroup *subImageViewAnims = [CAAnimationGroup animation];
    [subImageViewAnims setAnimations:@[subImageViewRotationAnim, subImageViewScaleAnim]];
    subImageViewAnims.duration = 0.3f;
    [_subImageView.layer addAnimation:subImageViewAnims forKey:@"subImageView"];
    //spotImageView
    _spotImageView.alpha = 1;
    CABasicAnimation *spotImageViewScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    spotImageViewScale.fromValue = @(0);
    spotImageViewScale.toValue = @(1);
    spotImageViewScale.duration = 0.3f;
    [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"soptImageView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _subImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    [CATransaction commit];
}
@end
