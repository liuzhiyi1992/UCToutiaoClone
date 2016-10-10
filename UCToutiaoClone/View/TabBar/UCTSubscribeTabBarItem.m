//
//  UCTSubscribeTabBarItem.m
//  UCToutiaoClone
//
//  Created by lzy on 16/10/9.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTSubscribeTabBarItem.h"
#import "Masonry.h"

@interface UCTSubscribeTabBarItem ()
@property (strong, nonatomic) UIImageView *spotImageView;
@property (assign, nonatomic) BOOL tmpFlag;
@end

@implementation UCTSubscribeTabBarItem
- (void)setupItem {
    [super setupItem];
    [self.mainImageView setImage:[UIImage imageNamed:@"icon_subscribe"]];
    [self.titleLabel setText:@"订阅号"];
    
    self.spotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ornament7"]];
    _spotImageView.alpha = 0;
    [self addSubview:_spotImageView];
    [self sendSubviewToBack:_spotImageView];
    [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mainImageView).multipliedBy(0.4);
        make.trailing.equalTo(self.mainImageView).offset(-4);
        make.top.equalTo(self.mainImageView).offset(1);
    }];
}

- (void)handleClick {
    [super handleClick];
}

- (void)releaseAnim {
    CABasicAnimation *spotImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    spotImageViewScaleAnim.fromValue = @(1);
    spotImageViewScaleAnim.toValue = @(0);
    spotImageViewScaleAnim.duration = 0.3f;
    [_spotImageView.layer addAnimation:spotImageViewScaleAnim forKey:@"mainImageView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [_spotImageView.layer setTransform:CATransform3DMakeScale(0, 0, 0)];
    [CATransaction commit];
}

- (void)selectedAnim {
    _spotImageView.alpha = 1;
    CABasicAnimation *spotImageViewScaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    spotImageViewScaleAnim.fromValue = @(0);
    spotImageViewScaleAnim.toValue = @(1);
    spotImageViewScaleAnim.duration = 0.3f;
    [_spotImageView.layer addAnimation:spotImageViewScaleAnim forKey:@"mainImageView"];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [_spotImageView.layer setTransform:CATransform3DMakeScale(1, 1, 1)];
    [CATransaction commit];
}

@end
