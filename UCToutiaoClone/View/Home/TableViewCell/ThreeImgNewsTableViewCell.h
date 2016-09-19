//
//  ThreeImgNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNewsTableViewCell.h"

@class ZYHArticleModel;
@interface ThreeImgNewsTableViewCell : UCTNewsTableViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
