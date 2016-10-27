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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Fine1"]];
        [self addSubview:imageView];
        
        CGFloat widthMultiply = 1.5 - i*0.1;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(widthMultiply);
            make.height.equalTo(imageView.mas_width);
            make.centerY.equalTo(self).offset(-0.25*[[UIScreen mainScreen] bounds].size.width);
        }];
    }
    self.imageViewList = [mutArray copy];
}

- (void)configureAnim {
}

@end
