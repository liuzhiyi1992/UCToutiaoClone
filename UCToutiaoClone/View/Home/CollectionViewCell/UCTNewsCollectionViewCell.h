//
//  UCTNewsTableViewCell.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTCollectionViewCell.h"

#define TITLE_LABEL_FONT [UIFont boldSystemFontOfSize:14.f]
#define SOURCE_LABEL_FONT [UIFont systemFontOfSize:10.f]
#define OP_MARK_IMAGE_TITLE_MARGIN 3
@class ZYHArticleModel;
@interface UCTNewsCollectionViewCell : UCTCollectionViewCell
//todo 弄一个自定义类,控制icon的高度跟字体同高
@property (strong, nonatomic) UIButton *opMark;
//@property (weak, nonatomic) NSLayoutConstraint *opMarkWidthConstraint;
@property (strong, nonatomic) NSArray *footerIconHConstraints;
- (void)updateCellWithModel:(ZYHArticleModel *)model;
@end
