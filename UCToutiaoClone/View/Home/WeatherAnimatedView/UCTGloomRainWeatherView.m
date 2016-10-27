//
//  UCTGloomRainWeatherView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTGloomRainWeatherView.h"
#import "Masonry.h"

#define RAIN_VIEW_H_W_RATIO 1.5f

@interface UCTGloomRainWeatherView ()
@property (strong, nonatomic) NSArray *imageViewList;
@property (strong, nonatomic) NSArray *rainImageViewList;
@end

@implementation UCTGloomRainWeatherView
- (void)setupView {
    NSMutableArray *mutArray = [NSMutableArray array];
    NSMutableArray *rainMutArray = [NSMutableArray array];
    for (int i = 3; i > 0; i --) {
        if (1 == i) {
            //Rain层
            for (int k = 1; k < 4; k ++) {
                UIImageView *rainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Rain%d", k]]];
                [self addSubview:rainImageView];
                [rainMutArray addObject:rainImageView];
                
                [rainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.centerX.equalTo(self).offset(0.4*[[UIScreen mainScreen] bounds].size.width);
                    make.width.equalTo(self);
                    make.height.equalTo(rainImageView.mas_width).multipliedBy(1/RAIN_VIEW_H_W_RATIO);
                }];
            }
        }
        //Gloom层
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Gloom%d", i]]];
        [self addSubview:imageView];
        [mutArray addObject:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.5);
            make.height.equalTo(imageView.mas_width);
            make.centerY.equalTo(self).offset(-0.25*[[UIScreen mainScreen] bounds].size.width);
        }];
    }
    self.imageViewList = [mutArray copy];
    self.rainImageViewList = [rainMutArray copy];
}

- (void)configureAnim {
    //Gloom
    UIImageView *firstImageView = _imageViewList.firstObject;
    CAKeyframeAnimation *firstAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    firstAnim.duration = 7.f;
    firstAnim.repeatCount = HUGE_VALF;
    UIBezierPath *firstPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(firstImageView.center.x-15, firstImageView.center.y-3) radius:3 startAngle:0 endAngle:2*M_PI clockwise:YES];
    firstAnim.path = firstPath.CGPath;
    [firstImageView.layer addAnimation:firstAnim forKey:@"position"];
    
    UIImageView *secondImageView = _imageViewList[1];
    CAKeyframeAnimation *secondAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    secondAnim.duration = 6.f;
    secondAnim.repeatCount = HUGE_VALF;
    UIBezierPath *secondPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(secondImageView.center.x+5, secondImageView.center.y-5) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    secondAnim.path = secondPath.CGPath;
    [secondImageView.layer addAnimation:secondAnim forKey:@"position"];
    
    UIImageView *thirdImageView = _imageViewList[2];
    CAKeyframeAnimation *thirdAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    thirdAnim.duration = 5.f;
    thirdAnim.repeatCount = HUGE_VALF;
    UIBezierPath *thirdPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(thirdImageView.center.x, thirdImageView.center.y-10) radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    thirdAnim.path = thirdPath.CGPath;
    [thirdImageView.layer addAnimation:thirdAnim forKey:@"position"];
    
    //Rain
    UIImageView *firstRain = _rainImageViewList.firstObject;
    CGFloat destinationX = firstRain.center.x - 0.5*firstRain.frame.size.width;
    CGFloat destinationY = firstRain.center.y + 1.5*firstRain.frame.size.height;
    CGPoint rainDestinationCenter = CGPointMake(destinationX, destinationY);
    for (int index = 0; index < _rainImageViewList.count; index ++) {
        UIImageView *rainImageView = _rainImageViewList[index];
        CAKeyframeAnimation *firstRainAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        firstRainAnim.duration = 7.f;
        firstRainAnim.repeatCount = HUGE_VALF;
        firstRainAnim.beginTime = CACurrentMediaTime() + index * 7/3;
        UIBezierPath *firstRainPath = [UIBezierPath bezierPath];
        [firstRainPath moveToPoint:firstRain.center];
        [firstRainPath addLineToPoint:rainDestinationCenter];
        firstRainAnim.path = firstRainPath.CGPath;
        [rainImageView.layer addAnimation:firstRainAnim forKey:@"position"];
    }
}
@end
