//
//  ThreeImgNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTTableViewCell.h"

@class ZYHArticleModel;
@interface ThreeImgNewsTableViewCell : UCTTableViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
