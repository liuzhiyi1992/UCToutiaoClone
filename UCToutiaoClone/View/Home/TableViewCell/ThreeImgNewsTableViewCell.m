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

#define TOP_BOTTOM_MARGIN_TITLE 10
#define BOTTOM_MARGIN_CELL 10
#define LEADING_IMAGE_VIEW 5
#define LEADING_TITLE_LABEL 8
#define GAP_IMAGE_VIEW 1

#define FONT_SIZE_TITLE 12.f
#define FONT_SIZE_SOURCE_LABEL 8.f

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
    [self setBackgroundColor:[UIColor redColor]];
    self.titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
    [self.contentView addSubview:_titleLabel];
    
    self.sourceLabel = [[UILabel alloc] init];
    [_sourceLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_SOURCE_LABEL]];
    [self.contentView addSubview:_sourceLabel];
    
    self.leftImageView = [[UIImageView alloc] init];
    self.centerImageView = [[UIImageView alloc] init];
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageView];
    [self.contentView addSubview:_centerImageView];
    [self.contentView addSubview:_rightImageView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(LEADING_TITLE_LABEL);
        make.top.equalTo(self.contentView).offset(TOP_BOTTOM_MARGIN_TITLE);
    }];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftImageView.mas_height);
        make.top.equalTo(_titleLabel.mas_bottom).offset(TOP_BOTTOM_MARGIN_TITLE);
        make.leading.equalTo(self.contentView).offset(LEADING_IMAGE_VIEW);
        make.trailing.equalTo(_centerImageView).offset(GAP_IMAGE_VIEW);
    }];
    
    [_centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftImageView);
        make.height.equalTo(_leftImageView);
        make.top.equalTo(_leftImageView);
//        make.bottom.equalTo(_leftImageView);
        make.trailing.equalTo(_rightImageView).offset(GAP_IMAGE_VIEW);
    }];
    
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_leftImageView);
        make.height.equalTo(_leftImageView);
        make.top.equalTo(_leftImageView);
//        make.bottom.equalTo(_leftImageView);
        make.trailing.equalTo(self.contentView).offset(LEADING_IMAGE_VIEW);
    }];
    
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-BOTTOM_MARGIN_CELL);
        make.top.equalTo(_leftImageView).offset(8);
        make.leading.equalTo(_titleLabel);
    }];
    
    
    
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    NSLog(@"update了cell");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
