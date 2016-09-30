//
//  UCTOPMarkView.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTOPMarkView.h"
#import "Masonry.h"
#import "UIColor+hexColor.h"
#import "UIImageView+WebCache.h"

#define LABEL_FONT [UIFont systemFontOfSize:10.f]
#define LABEL_TEXT_COLOR [UIColor hexColor:@"3F4449"]

@interface UCTOPMarkView ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation UCTOPMarkView
+ (CGSize)opMarkSizeWithString:(NSString *)string {
    CGSize textSize = [string sizeWithAttributes:@{NSFontAttributeName:LABEL_FONT}];
    CGFloat imageWidth = textSize.height;
    return CGSizeMake(textSize.width + imageWidth + OP_MARK_IMAGE_TITLE_MARGIN, textSize.height);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:LABEL_TEXT_COLOR];
    [_titleLabel setFont:LABEL_FONT];
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:_titleLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(_titleLabel);
        make.width.equalTo(_imageView.mas_height);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_imageView.mas_trailing).offset(OP_MARK_IMAGE_TITLE_MARGIN);
        make.centerY.equalTo(_imageView);
    }];
}

- (void)updateWithTitle:(NSString *)title iconUrlString:(NSString *)iconUrlString {
    [_titleLabel setText:title];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:iconUrlString]];
}
@end
