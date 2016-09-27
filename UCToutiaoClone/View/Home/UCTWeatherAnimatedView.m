//
//  UCTWeatherAnimatedView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTWeatherAnimatedView.h"
#import "Masonry.h"

@implementation UCTWeatherAnimatedView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    for (int i = 3; i > 0; i --) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Cloud%d", i]];
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:tempImageView];
        
        [tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(1.5);
            make.height.equalTo(tempImageView.mas_width);
        }];
    }
}
@end
