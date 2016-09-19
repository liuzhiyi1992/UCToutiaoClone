//
//  UCTNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTTableViewCell.h"

@class ZYHArticleModel;
@interface UCTNewsTableViewCell : UCTTableViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
