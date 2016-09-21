//
//  ThreeImgNewsTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ThreeImgNewsTableViewCell.h"
#import "ZYHArticleModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIColor+hexColor.h"

#define TOP_BOTTOM_MARGIN_TITLE 12
#define BOTTOM_MARGIN_CELL 10
#define LEADING_IMAGE_VIEW 5
#define LEADING_TITLE_LABEL 12
#define GAP_IMAGE_VIEW 1
#define HEIGHT_IMAGEVIEW 205.f

#define TITLE_LABEL_FONT_SIZE 14.f
#define SOURCE_LABEL_FONT_SIZE 11.f

#define TITLE_LABEL_FONT_COLOR [UIColor hexColor:@"3F4449"]
#define SOURCE_LABEL_FONT_COLOR [UIColor hexColor:@"9C9DA0"]

//todo 组装
@interface ThreeImgNewsTableViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSArray *imageViewList;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *centerImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UILabel *sourceLabel;
@end

@implementation ThreeImgNewsTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"ThreeImgNewsTableViewCell";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:TITLE_LABEL_FONT_COLOR];
    [_titleLabel setFont:[UIFont systemFontOfSize:TITLE_LABEL_FONT_SIZE]];
    [self.contentView addSubview:_titleLabel];
    
    self.sourceLabel = [[UILabel alloc] init];
    [_sourceLabel setTextColor:SOURCE_LABEL_FONT_COLOR];
    [_sourceLabel setFont:[UIFont systemFontOfSize:SOURCE_LABEL_FONT_SIZE]];
    [self.contentView addSubview:_sourceLabel];
    
    self.leftImageView = [[UIImageView alloc] init];
    self.centerImageView = [[UIImageView alloc] init];
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageView];
    [self.contentView addSubview:_centerImageView];
    [self.contentView addSubview:_rightImageView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LEADING_TITLE_LABEL);
        make.trailing.equalTo(self.contentView).offset(LEADING_TITLE_LABEL);
        make.top.equalTo(self.contentView).offset(TOP_BOTTOM_MARGIN_TITLE);
    }];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@HEIGHT_IMAGEVIEW);
        make.width.equalTo(_leftImageView.mas_height);
        make.top.equalTo(_titleLabel.mas_bottom).offset(TOP_BOTTOM_MARGIN_TITLE);
        make.leading.equalTo(self.contentView).offset(LEADING_IMAGE_VIEW);
        make.trailing.equalTo(_centerImageView.mas_leading).offset(GAP_IMAGE_VIEW);
    }];

    [_centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftImageView);
        make.height.equalTo(_leftImageView);
        make.top.equalTo(_leftImageView);
        make.trailing.equalTo(_rightImageView.mas_leading).offset(GAP_IMAGE_VIEW);
    }];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftImageView);
        make.height.equalTo(_leftImageView);
        make.top.equalTo(_leftImageView);
        make.trailing.equalTo(self.contentView).offset(-LEADING_IMAGE_VIEW);
    }];
    
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-BOTTOM_MARGIN_CELL);
        make.top.equalTo(_leftImageView.mas_bottom).offset(8);
        make.leading.equalTo(_titleLabel);
    }];
    
    
    
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    //title
    [_titleLabel setText:model.articleTitle];
    //images
    NSArray *thumbnailsList = model.thumbnails;
    NSAssert((thumbnailsList.count >= 3),
             @"ERROR - thumbnails less than 3");
    if (thumbnailsList.count >= 3) {
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:thumbnailsList[0][@"url"]]];
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:thumbnailsList[1][@"url"]]];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:thumbnailsList[2][@"url"]]];
    }
    //_sourceLabel
    [_sourceLabel setText:model.sourceName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
