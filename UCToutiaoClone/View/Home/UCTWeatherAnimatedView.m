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
    CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
    CAKeyframeAnimation *firstAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    firstAnim.duration = 2.f;
    firstAnim.repeatCount = HUGE_VALF;
//    [firstAnim setAutoreverses:NO];
//    firstAnim.fillMode = kCAFillModeForwards;
//    firstAnim.removedOnCompletion = NO;
    
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:firstImageView.center radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    firstAnim.path = firstPath.CGPath;
    [firstImageView.layer addAnimation:firstAnim forKey:@"position"];
    
    
}
@end
