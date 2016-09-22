//
//  SingleImgNewsCollectionViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "SingleImgNewsCollectionViewCell.h"
#import "Masonry.h"
#import "ZYHArticleModel.h"
#import "UIImageView+WebCache.h"
#import "UIColor+hexColor.h"

#define TITLE_LABEL_FONT_COLOR [UIColor hexColor:@"3F4449"]
#define SOURCE_LABEL_FONT_COLOR [UIColor hexColor:@"9C9DA0"]

#define LEADING_MARGIN 12
#define TRAILING_MARGIN 4
#define BOTTOM_MARGIN 12
#define MARGIN_LABEL_2_IMAGEVIEW 10
#define WIDTH_HEIGHT_SCALE_IMAGEVIEW 1.36
#define WIDTH_SCREEN_SCALE_IMAGEVIEW 2.59
#define WIDTH_IMAGEVIEW ([[UIScreen mainScreen] bounds].size.width / WIDTH_SCREEN_SCALE_IMAGEVIEW)

@interface SingleImgNewsCollectionViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation SingleImgNewsCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SingleImgNewsCollectionViewCell";
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
    [_titleLabel setFont:TITLE_LABEL_FONT];
    [_titleLabel setTextColor:TITLE_LABEL_FONT_COLOR];
    [_titleLabel setNumberOfLines:2];
    [self.contentView addSubview:_titleLabel];
    
    self.mainImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_mainImageView];
    
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
        make.top.equalTo(self.contentView).offset(LEADING_MARGIN);
    }];
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.greaterThanOrEqualTo(_titleLabel.mas_trailing).offset(MARGIN_LABEL_2_IMAGEVIEW);
        make.trailing.equalTo(self.contentView).offset(-TRAILING_MARGIN);
        make.top.equalTo(self.contentView).offset(TRAILING_MARGIN);
        make.bottom.equalTo(self.contentView).offset(-TRAILING_MARGIN);
        make.width.equalTo(@WIDTH_IMAGEVIEW);
        make.height.equalTo(_mainImageView.mas_width).multipliedBy(1/WIDTH_HEIGHT_SCALE_IMAGEVIEW);
    }];
    
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleLabel);
        make.bottom.equalTo(self.contentView).offset(-BOTTOM_MARGIN);
        make.top.greaterThanOrEqualTo(_titleLabel.mas_bottom).offset(8);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_sourceLabel.mas_trailing).offset(5);
        make.top.equalTo(_sourceLabel);
    }];
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    //todo 根据cell的宽高比决定cell样式
    [_titleLabel setText:model.articleTitle];
    if (model.thumbnails.count > 0) {
        NSDictionary *thumbnailDict = model.thumbnails.firstObject;
        NSString *urlString = thumbnailDict[@"url"];
        [_mainImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
    
    [_sourceLabel setText:model.sourceName];
    [_timeLabel setText:model.publicTimeString];
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
