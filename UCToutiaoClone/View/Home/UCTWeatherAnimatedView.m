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

@interface UCTWeatherAnimatedView ()
@property (strong, nonatomic) NSArray *imageViewList;
@end

@implementation UCTWeatherAnimatedView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureAnim) name:@"configureAnim" object:nil];
    }
    return self;
}

- (void)setupView {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 3; i > 0; i --) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Cloud%d", i]];
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:tempImageView];
        [mutArray addObject:tempImageView];
        
        [tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.5);
            make.height.equalTo(tempImageView.mas_width);
        }];
    }
    self.imageViewList = [mutArray copy];
}

- (void)configureAnim {
    UIImageView *firstImageView = _imageViewList.firstObject;
    CAKeyframeAnimation *firstAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    firstAnim.duration = 7.f;
    firstAnim.repeatCount = HUGE_VALF;
//    [firstAnim setAutoreverses:NO];
//    firstAnim.fillMode = kCAFillModeForwards;
//    firstAnim.removedOnCompletion = NO;
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(firstImageView.center.x-15, firstImageView.center.y+2) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    firstAnim.path = firstPath.CGPath;
    [firstImageView.layer addAnimation:firstAnim forKey:@"position"];
    
    UIImageView *secondImageView = _imageViewList[1];
    CAKeyframeAnimation *secondAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    secondAnim.duration = 6.f;
    secondAnim.repeatCount = HUGE_VALF;
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(secondImageView.center.x+5, secondImageView.center.y-2) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    secondAnim.path = secondPath.CGPath;
    [secondImageView.layer addAnimation:secondAnim forKey:@"position"];
    
    UIImageView *thirdImageView = _imageViewList[2];
    CAKeyframeAnimation *thirdAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    thirdAnim.duration = 5.f;
    thirdAnim.repeatCount = HUGE_VALF;
    UIBezierPath *thirdPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(thirdImageView.center.x, thirdImageView.center.y-8) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    thirdAnim.path = thirdPath.CGPath;
    [thirdImageView.layer addAnimation:thirdAnim forKey:@"position"];
    
}
@end
