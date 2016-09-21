//
//  ZYHCategoryItemCell.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHChannelItemCell.h"
#import "UIColor+hexColor.h"
#import "Masonry.h"
#import "ZYHChannelModel.h"

#define TITLE_FONT_SIZE 16.f
#define TITLE_COLOR_NORMAL [UIColor hexColor:@"777777"]
#define TITLE_COLOR_SELECTED [UIColor hexColor:@"777777"]

@interface ZYHChannelItemCell ()
@end

@implementation ZYHChannelItemCell
+ (NSString *)cellReuseIdentifier {
    return @"ZYHChannelItemCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

+ (NSDictionary *)attributeForTitleLabel {
    return @{NSFontAttributeName:[UIFont systemFontOfSize:TITLE_FONT_SIZE]};
}

- (void)setupCell {
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
    [_titleLabel setTextColor:TITLE_COLOR_NORMAL];
    [self addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

- (void)updateCellWithChannel:(ZYHChannelModel *)channel {
    [_titleLabel setText:channel.channelName];
    [self changeCellSelect:channel.isSelected];
}

- (void)changeCellSelect:(BOOL)select {
    if (select) {
        [_titleLabel setTextColor:TITLE_COLOR_SELECTED];
    } else {
        [_titleLabel setTextColor:TITLE_COLOR_NORMAL];
    }
}

@end
