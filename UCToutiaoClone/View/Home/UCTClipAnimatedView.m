//
//  UCTClipAnimatedView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/26.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTClipAnimatedView.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"
#import "UCTWeatherAnimatedView.h"
#import "MainHomeController.h"
#import "ZYHPageCollectionViewController.h"
#import "UCTCloudWeatherView.h"
#import "UCTSunnyWeatherView.h"
#import "UCTGloomRainWeatherView.h"

#define TEMPERATURE_LABEL_FONT [UIFont boldSystemFontOfSize:40.f]
#define TEMPERATURE_LABEL_TEXT_COLOR [UIColor hexColor:@"3F444D"]

@interface UCTClipAnimatedView () <MainHomeControllerScrollDelegate>
@property (strong, nonatomic) UILabel *temperatureLabel;
@property (strong, nonatomic) UCTWeatherAnimatedView *weatherView;
@end

@implementation UCTClipAnimatedView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self queryWeatherInfo];
        [self setupView];
    }
    return self;
}

- (void)queryWeatherInfo {
    
}

- (void)setupView {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.weatherView = [[UCTGloomRainWeatherView alloc] init];
    [self addSubview:_weatherView];
    
    self.temperatureLabel = [[UILabel alloc] init];
    [_temperatureLabel setFont:TEMPERATURE_LABEL_FONT];
    [_temperatureLabel setTextColor:TEMPERATURE_LABEL_TEXT_COLOR];
    [_temperatureLabel setText:@"- -"];
    [self addSubview:_temperatureLabel];
    
    UIView *dotView = [[UIView alloc] init];
    [dotView setBackgroundColor:TEMPERATURE_LABEL_TEXT_COLOR];
    [self addSubview:dotView];
    
    [_temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-12);
    }];
    
    [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@6);
        make.width.equalTo(dotView.mas_height);
        make.leading.equalTo(_temperatureLabel.mas_trailing).offset(5);
        make.top.equalTo(_temperatureLabel).offset(5);
    }];
    
    [_weatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
    }];
}

- (void)mainHomeScrollViewDidScroll2OffsetY:(CGFloat)offsetY {
    [_weatherView transformWithHomeScrollOffsetY:offsetY];
}

- (void)pageScrollViewDidScroll2OffsetY:(CGFloat)offsetY {
    [_weatherView transformWithPageScrollOffsetY:offsetY];
}

@end
