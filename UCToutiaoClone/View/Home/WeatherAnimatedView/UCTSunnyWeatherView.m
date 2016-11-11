//
//  UCTSunnyWeatherView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTSunnyWeatherView.h"
#import "Masonry.h"

@interface UCTSunnyWeatherView ()
@property (strong, nonatomic) NSArray *imageViewList;
@end

@implementation UCTSunnyWeatherView
- (void)setupView {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Fine4"]];
        [self addSubview:imageView];
        [mutArray addObject:imageView];
        
        CGFloat widthMultiply = 1.3 - i*0.1;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(widthMultiply);
            make.height.equalTo(imageView.mas_width);
            make.centerY.equalTo(self).offset(-0.2*[[UIScreen mainScreen] bounds].size.width);
        }];
    }
    self.imageViewList = [mutArray copy];
}

- (void)configureAnim {
    UIImageView *firstImageView = _imageViewList.firstObject;
    CAKeyframeAnimation *firstAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    firstAnim.duration = 7.f;
    firstAnim.repeatCount = HUGE_VALF;
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(firstImageView.center.x-10, firstImageView.center.y-3) radius:3 startAngle:0 endAngle:2*M_PI clockwise:YES];
    firstAnim.path = firstPath.CGPath;
    [firstImageView.layer addAnimation:firstAnim forKey:@"position"];
    CABasicAnimation *firstRotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    firstRotateAnim.duration = 16.f;
    firstRotateAnim.repeatCount = HUGE_VALF;
    firstRotateAnim.fromValue = @(0);
    firstRotateAnim.toValue = @(-2*M_PI);
    [firstImageView.layer addAnimation:firstRotateAnim forKey:@"rotation"];
    
    UIImageView *secondImageView = _imageViewList[1];
    CAKeyframeAnimation *secondAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    secondAnim.duration = 6.f;
    secondAnim.repeatCount = HUGE_VALF;
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(secondImageView.center.x, secondImageView.center.y-5) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    secondAnim.path = secondPath.CGPath;
    [secondImageView.layer addAnimation:secondAnim forKey:@"position"];
    CABasicAnimation *secondRotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    secondRotateAnim.duration = 23.f;
    secondRotateAnim.repeatCount = HUGE_VALF;
    secondRotateAnim.fromValue = @(M_PI);
    secondRotateAnim.toValue = @(2*M_PI);
    [secondImageView.layer addAnimation:secondRotateAnim forKey:@"rotation"];
    
    UIImageView *thirdImageView = _imageViewList[2];
    CAKeyframeAnimation *thirdAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    thirdAnim.duration = 5.f;
    thirdAnim.repeatCount = HUGE_VALF;
    UIBezierPath *thirdPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(thirdImageView.center.x+5, thirdImageView.center.y-10) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    thirdAnim.path = thirdPath.CGPath;
    [thirdImageView.layer addAnimation:thirdAnim forKey:@"position"];
    CABasicAnimation *thirdRotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    thirdRotateAnim.duration = 30.f;
    thirdRotateAnim.repeatCount = HUGE_VALF;
    thirdRotateAnim.fromValue = @(0);
    thirdRotateAnim.toValue = @(-2*M_PI);
    [thirdImageView.layer addAnimation:thirdRotateAnim forKey:@"rotation"];
}

@end
