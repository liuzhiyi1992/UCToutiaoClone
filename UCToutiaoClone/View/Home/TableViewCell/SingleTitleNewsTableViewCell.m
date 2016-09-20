//
//  SingleTitleNewsTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "SingleTitleNewsTableViewCell.h"
#import "Masonry.h"
#import "ZYHArticleModel.h"

#define TITLE_LABEL_FONT_SIZE 14.f
#define SOURCE_LABEL_FONT_SIZE 8.f
#define LEADING_MARGIN 8
#define TOP_MARGIN 15
#define BOTTOM_MARGIN 10

@interface SingleTitleNewsTableViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@end

@implementation SingleTitleNewsTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SingleTitleNewsTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    [self setBackgroundColor:[UIColor grayColor]];
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE]];
    [self.contentView addSubview:_titleLabel];
    
    self.sourceLabel = [[UILabel alloc] init];
    [_sourceLabel setFont:[UIFont systemFontOfSize:SOURCE_LABEL_FONT_SIZE]];
    [self.contentView addSubview:_sourceLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LEADING_MARGIN);
        make.top.equalTo(self.contentView).offset(TOP_MARGIN);
    }];
    
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(_titleLabel);
        make.bottom.equalTo(self.contentView).offset(BOTTOM_MARGIN);
    }];
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    [_titleLabel setText:model.articleTitle];
    [_sourceLabel setText:model.sourceName];
}
@end
