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
@end

@implementation UCTGloomRainWeatherView
- (void)setupView {
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 3; i > 0; i --) {
        if (1 == i) {
            //添加下雨图层
            for (int k = 0; k < 3; k ++) {
                UIImageView *rainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Rain%d", k]]];
                [self addSubview:rainImageView];
                
                [rainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.centerX.equalTo(self).offset(0.5*[[UIScreen mainScreen] bounds].size.width);
                    make.width.equalTo(self).multipliedBy(1.5);
                    make.height.equalTo(rainImageView.mas_width).multipliedBy(1/RAIN_VIEW_H_W_RATIO);
                }];
            }
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"Gloom%d", i]]];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.5);
            make.height.equalTo(imageView.mas_width);
            make.centerY.equalTo(self).offset(-0.25*[[UIScreen mainScreen] bounds].size.width);
        }];
    }
    self.imageViewList = [mutArray copy];
}

- (void)configureAnim {
}
@end
