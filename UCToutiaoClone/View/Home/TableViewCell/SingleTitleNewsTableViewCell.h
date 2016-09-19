//
//  SingleTitleNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNewsTableViewCell.h"

@class ZYHArticleModel;
@interface SingleTitleNewsTableViewCell : UCTNewsTableViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
