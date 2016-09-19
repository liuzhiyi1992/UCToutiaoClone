//
//  ThreeImgNewsTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ThreeImgNewsTableViewCell.h"
#import "ZYHArticleModel.h"

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
    
}

- (void)updateCellWithModel:(ZYHArticleModel *)model {
    NSLog(@"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
