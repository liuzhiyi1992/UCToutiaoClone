//
//  SingleImgNewsTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "SingleImgNewsTableViewCell.h"
#import "Masonry.h"
#import "ZYHArticleModel.h"
#import "UIImageView+WebCache.h"

#define TITLE_LABEL_FONT_SIZE 14.f
#define LEADING_MARGIN 10
#define TRAILING_MARGIN 4
#define MARGIN_LABEL_2_IMAGEVIEW 8
#define WIDTH_HEIGHT_SCALE_IMAGEVIEW 1.46
#define HEIGHT_IMAGEVIEW 180

@interface SingleImgNewsTableViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UILabel *sourceLabel;
@end

@implementation SingleImgNewsTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SingleImgNewsTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    [self setBackgroundColor:[UIColor greenColor]];
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE]];
    [_titleLabel setNumberOfLines:2];
    [self.contentView addSubview:_titleLabel];
    
    self.mainImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_mainImageView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LEADING_MARGIN);
        make.top.equalTo(self.contentView).offset(LEADING_MARGIN);
    }];
    
    [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.greaterThanOrEqualTo(_titleLabel.mas_trailing).offset(MARGIN_LABEL_2_IMAGEVIEW);
        make.trailing.equalTo(self.contentView).offset(-TRAILING_MARGIN);
        make.top.equalTo(self.contentView).offset(TRAILING_MARGIN);
        make.bottom.equalTo(self.contentView).offset(-TRAILING_MARGIN);
        make.height.equalTo(@HEIGHT_IMAGEVIEW);
        make.width.equalTo(_mainImageView.mas_height).multipliedBy(WIDTH_HEIGHT_SCALE_IMAGEVIEW);
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
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
