//
//  UCTWeatherAnimatedView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTWeatherAnimatedView.h"
#import "Masonry.h"
#import <QuartzCore/CABase.h>
#import "MainHomeController.h"

NSString * const NOTIFICATION_NAME_BEGIN_WEATHER_ANIMATION = @"NOTIFICATION_NAME_BEGIN_WEATHER_ANIMATION";

@interface UCTWeatherAnimatedView ()
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UCTWeatherAnimatedView
#pragma clang diagnostic pop
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureAnim) name:NOTIFICATION_NAME_BEGIN_WEATHER_ANIMATION object:nil];
        [self setupView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureAnim {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}

- (void)setupView {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
}
//- (void)setupView {
//    NSMutableArray *mutArray = [NSMutableArray array];
//    for (int i = 3; i > 0; i --) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Cloud%d", i]];
//        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:image];
//        [self addSubview:tempImageView];
//        [mutArray addObject:tempImageView];
//        
//        [tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.width.equalTo(self).multipliedBy(1.5);
//            make.height.equalTo(tempImageView.mas_width);
//            make.centerY.equalTo(self).offset(-0.25*[[UIScreen mainScreen] bounds].size.width);
//        }];
//    }
//    self.imageViewList = [mutArray copy];
//}
//
//- (void)configureAnim {
//    UIImageView *firstImageView = _imageViewList.firstObject;
//    CAKeyframeAnimation *firstAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    firstAnim.duration = 7.f;
//    firstAnim.repeatCount = HUGE_VALF;
//    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(firstImageView.center.x-15, firstImageView.center.y-3) radius:3 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    firstAnim.path = firstPath.CGPath;
//    [firstImageView.layer addAnimation:firstAnim forKey:@"position"];
//    
//    UIImageView *secondImageView = _imageViewList[1];
//    CAKeyframeAnimation *secondAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    secondAnim.duration = 6.f;
//    secondAnim.repeatCount = HUGE_VALF;
//    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(secondImageView.center.x+5, secondImageView.center.y-5) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    secondAnim.path = secondPath.CGPath;
//    [secondImageView.layer addAnimation:secondAnim forKey:@"position"];
//    
//    UIImageView *thirdImageView = _imageViewList[2];
//    CAKeyframeAnimation *thirdAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    thirdAnim.duration = 5.f;
//    thirdAnim.repeatCount = HUGE_VALF;
//    UIBezierPath *thirdPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(thirdImageView.center.x, thirdImageView.center.y-10) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    thirdAnim.path = thirdPath.CGPath;
//    [thirdImageView.layer addAnimation:thirdAnim forKey:@"position"];
//}
//
- (void)transformWithHomeScrollOffsetY:(CGFloat)offsetY {
    offsetY += 20;//除去状态栏
    if (offsetY > 0) {
        CGFloat scale = 1 - offsetY/150;
        self.transform = CGAffineTransformMakeScale(scale, 1);
        self.alpha = (CUSTOM_NAV_DISPLAY_HEIGHT-offsetY)/CUSTOM_NAV_DISPLAY_HEIGHT;
    }
}

- (void)transformWithPageScrollOffsetY:(CGFloat)offsetY {
    if (offsetY < 0) {
        CGFloat scale = 1 + -offsetY/250;
        self.transform = CGAffineTransformMakeScale(scale, 1);
    }
}
@end
