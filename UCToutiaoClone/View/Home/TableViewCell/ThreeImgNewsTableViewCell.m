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
    self.leftImageView = [[UIImageView alloc] init];
    self.centerImageView = [[UIImageView alloc] init];
    self.rightImageView = [[UIImageView alloc] init];
    
    [_imageViewList[0] mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [_imageViewList[1] mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [_imageViewList[2] mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
