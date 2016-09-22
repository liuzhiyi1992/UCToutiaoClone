//
//  UCTNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTTableViewCell.h"

#define TITLE_LABEL_FONT [UIFont boldSystemFontOfSize:14.f]
#define SOURCE_LABEL_FONT [UIFont systemFontOfSize:10.f]

@class ZYHArticleModel;
@interface UCTNewsCollectionViewCell : UCTTableViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
