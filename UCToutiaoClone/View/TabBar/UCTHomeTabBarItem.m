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

#define SPOTIMAGEVIEW_CENTERY_OFFSET 2
NSString * const NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA = @"NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA";

@interface UCTHomeTabBarItem ()
@property (strong, nonatomic) UIImageView *subImageView;
@property (strong, nonatomic) UIImageView *spotImageView;
@property (assign, nonatomic) BOOL tmpFlag;
@property (assign, nonatomic) CGFloat spotImageViewCurrentScale;
@end

@implementation UCTHomeTabBarItem
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self setupItem];
//    }
//    return self;
//}

- (void)dealloc {
    [self resignNotification];
}

- (void)setupItem {
    [super setupItem];
    [self registerNotification];
    self.itemStatus = HomeTabBarItemStatusWeather;
    [self.mainImageView setImage:[UIImage imageNamed:@"icon_home"]];
    [self.titleLabel setText:@"首页"];
    
    self.subImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_refresh"]];
    _subImageView.alpha = 0;
    [self addSubview:_subImageView];
    [_subImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainImageView);
    }];
    
    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
    _spotImageViewCurrentScale = 1.f;
    [self addSubview:_spotImageView];
    [self sendSubviewToBack:_spotImageView];
    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
        make.centerX.equalTo(self.mainImageView);
        make.centerY.equalTo(self.mainImageView).offset(SPOTIMAGEVIEW_CENTERY_OFFSET);
    }];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageDidRefresh) name:NOTIFICATION_NAME_HOME_PAGE_DID_LOAD_DATA object:nil];
}

- (void)resignNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pageDidRefresh {
    switch (_itemStatus) {
        case HomeTabBarItemStatusReading:
            break;
        case HomeTabBarItemStatusWeather:
            break;
        case HomeTabBarItemStatusNeedsRefresh:
            [self toReadingStatusAnim];
            self.itemStatus = HomeTabBarItemStatusReading;
            break;
        default:
            break;
    }
}

- (void)handleClick {
    [super handleClick];
}

- (void)releaseAnim {
    if (_itemStatus == HomeTabBarItemStatusWeather) {
        //spotImageView
        _spotImageView.alpha = 1;
        CABasicAnimation *spotImageViewScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        spotImageViewScale.fromValue = @(1);
        spotImageViewScale.toValue = @(0);
        spotImageViewScale.duration = 0.3f;
        [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"soptImageView"];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _spotImageView.layer.transform = CATransform3DMakeScale(0, 0, 1);
        [CATransaction commit];
    } else if (_itemStatus == HomeTabBarItemStatusReading || _itemStatus == HomeTabBarItemStatusNeedsRefresh) {
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
}

- (void)selectedAnim {
    if (_itemStatus == HomeTabBarItemStatusWeather) {
        //spotImageView
        _spotImageView.alpha = 1;
        CABasicAnimation *spotImageViewScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        spotImageViewScale.fromValue = @(0);
        spotImageViewScale.toValue = @(1);
        spotImageViewScale.duration = 0.3f;
        [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"soptImageView"];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _spotImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        [CATransaction commit];
    } else if (_itemStatus == HomeTabBarItemStatusReading || _itemStatus == HomeTabBarItemStatusNeedsRefresh) {
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
        spotImageViewScale.toValue = @(_spotImageViewCurrentScale);
        spotImageViewScale.duration = 0.35f;
        [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"soptImageView"];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _subImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        _spotImageView.layer.transform = CATransform3DMakeScale(_spotImageViewCurrentScale, _spotImageViewCurrentScale, 1);
        [CATransaction commit];
    }
}

- (void)toReadingStatusAnim {
    if (_itemStatus == HomeTabBarItemStatusWeather) {
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
        spotImageViewScale.fromValue = @(_spotImageViewCurrentScale);
        spotImageViewScale.toValue = @(1);
        CABasicAnimation *spotImageViewPoiAnim = [CABasicAnimation animationWithKeyPath:@"position"];
        spotImageViewPoiAnim.fromValue = [NSValue valueWithCGPoint:_spotImageView.layer.position];
        CGPoint toPoint = CGPointMake(_spotImageView.layer.position.x, _spotImageView.layer.position.y-SPOTIMAGEVIEW_CENTERY_OFFSET);
        spotImageViewPoiAnim.toValue = [NSValue valueWithCGPoint:toPoint];
        CAAnimationGroup *spotImageViewAnims = [CAAnimationGroup animation];
        [spotImageViewAnims setAnimations:@[spotImageViewScale, spotImageViewPoiAnim]];
        spotImageViewAnims.duration = 0.3f;
        [_spotImageView.layer addAnimation:spotImageViewAnims forKey:@"spotImageView"];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _subImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        [_spotImageView.layer setPosition:toPoint];
        [_spotImageView.layer setTransform:CATransform3DMakeScale(1, 1, 1)];
        _spotImageViewCurrentScale = 1.f;
        [CATransaction commit];
    } else if (_itemStatus == HomeTabBarItemStatusNeedsRefresh) {
        //spotImageView
        CABasicAnimation *spotImageViewScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        spotImageViewScale.fromValue = @(_spotImageViewCurrentScale);
        spotImageViewScale.toValue = @(1);
        spotImageViewScale.duration = 0.3f;
        [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"spotImageView"];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        _spotImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        _spotImageViewCurrentScale = 1.f;
        [CATransaction commit];
    }
}

- (void)toWeatherStatusAnim {
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
    
    //spotImageView
    CABasicAnimation *spotImageViewPoiAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    spotImageViewPoiAnim.fromValue = [NSValue valueWithCGPoint:_spotImageView.layer.position];
    CGPoint toPoint = CGPointMake(_spotImageView.layer.position.x, _spotImageView.layer.position.y+SPOTIMAGEVIEW_CENTERY_OFFSET);
    spotImageViewPoiAnim.toValue = [NSValue valueWithCGPoint:toPoint];
    spotImageViewPoiAnim.duration = 0.3f;
    [_spotImageView.layer addAnimation:spotImageViewPoiAnim forKey:@"spotImagView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CATransform3D combine;
    CATransform3D rotate;
    CATransform3D scale;
    scale = CATransform3DMakeScale(0.f, 0.f, 0.f);
    rotate = CATransform3DMakeRotation(0.5*M_PI, 0.0f, 0.0f, -1.0f);
    combine = CATransform3DConcat(rotate, scale);
    [_subImageView.layer setTransform:combine];
    [_spotImageView.layer setPosition:toPoint];
    [CATransaction commit];
}

- (void)toNeedsRefreshStatusAnim {
    //急需刷新状态
    //spotImageView
    CABasicAnimation *spotImageViewScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    spotImageViewScale.fromValue = @(1);
    spotImageViewScale.toValue = @(2.5);
    spotImageViewScale.duration = 0.3f;
    [_spotImageView.layer addAnimation:spotImageViewScale forKey:@"spotImageView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    _spotImageView.layer.transform = CATransform3DMakeScale(2.5, 2.5, 1);
    _spotImageViewCurrentScale = 2.5f;
    [CATransaction commit];
}

- (void)setItemStatus:(HomeTabBarItemStatus)itemStatus {
    if (_itemStatus == itemStatus) {
        return;
    }
    switch (itemStatus) {
        case HomeTabBarItemStatusReading:
            [self toReadingStatusAnim];
            break;
        case HomeTabBarItemStatusWeather:
            [self toWeatherStatusAnim];
            break;
        case HomeTabBarItemStatusNeedsRefresh:
            [self toNeedsRefreshStatusAnim];
            break;
        default:
            break;
    }
    _itemStatus = itemStatus;
}
@end
