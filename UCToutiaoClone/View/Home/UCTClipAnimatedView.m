//
//  UCTClipAnimatedView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/26.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTClipAnimatedView.h"
#import "Masonry.h"

@interface UCTClipAnimatedView ()
@end

@implementation UCTClipAnimatedView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self setBackgroundColor:[UIColor grayColor]];
    self.centerView = [[UIView alloc] init];
    [_centerView setBackgroundColor:[UIColor blueColor]];
    [_centerView setFrame:CGRectMake(150, 20, 80, 80)];
    [self addSubview:_centerView];
    
//    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(10);
//        make.center.equalTo(self);
//        make.leading.equalTo(self).offset(150);
//    }];
}

@end
