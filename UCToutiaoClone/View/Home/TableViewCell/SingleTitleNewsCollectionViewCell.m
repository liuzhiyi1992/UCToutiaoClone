//
//  SingleTitleNewsCollectionViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "SingleTitleNewsCollectionViewCell.h"
#import "Masonry.h"
#import "ZYHArticleModel.h"
#import "UIColor+hexColor.h"

#define TITLE_LABEL_FONT_COLOR [UIColor hexColor:@"3F4449"]
#define SOURCE_LABEL_FONT_COLOR [UIColor hexColor:@"9C9DA0"]

#define LEADING_MARGIN 12
#define TOP_MARGIN 15
#define BOTTOM_MARGIN 10

@interface SingleTitleNewsCollectionViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation SingleTitleNewsCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SingleTitleNewsCollectionViewCell";
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self setupCell];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:TITLE_LABEL_FONT_COLOR];
    [_titleLabel setFont:TITLE_LABEL_FONT];
    [self.contentView addSubview:_titleLabel];
    
    self.sourceLabel = [[UILabel alloc] init];
    [_sourceLabel setTextColor:SOURCE_LABEL_FONT_COLOR];
    [_sourceLabel setFont:SOURCE_LABEL_FONT];
    [self.contentView addSubview:_sourceLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [_timeLabel setTextColor:SOURCE_LABEL_FONT_COLOR];
    [_timeLabel setFont:SOURCE_LABEL_FONT];
    [self.contentView addSubview:_timeLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LEADING_MARGIN);
        make.top.equalTo(self.contentView).offset(TOP_MARGIN);
    }];
    
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(_titleLabel);
        make.bottom.equalTo(self.contentView).offset(-BOTTOM_MARGIN);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_sourceLabel.mas_trailing).offset(5);
        make.top.equalTo(_sourceLabel);
    }];
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    [_titleLabel setText:model.articleTitle];
    [_sourceLabel setText:model.sourceName];
    [_timeLabel setText:model.publicTimeString];
}
@end
