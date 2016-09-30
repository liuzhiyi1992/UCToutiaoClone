//
//  UCTNewsTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNewsCollectionViewCell.h"
#import "ZYHArticleModel.h"

@implementation UCTNewsCollectionViewCell
- (void)updateCellWithModel:(ZYHArticleModel *)model {
    //opMark
    if (_opMark) {
        if (self.footerIconHConstraints) {
            [self.contentView removeConstraints:self.footerIconHConstraints];
        }
        if (model.opMark.length > 0) {
            [self.opMark setHidden:NO];
            [self.opMark updateWithTitle:model.opMark iconUrlString:model.opMarkIconUrl];
            //layout sourceLabel & opMark
            CGSize opMarkSize = [UCTOPMarkView opMarkSizeWithString:model.opMark];
            [self.opMark setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.sourceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSDictionary *views = @{@"opMark":self.opMark, @"sourceLabel":self.sourceLabel};
            //todo sourceLabel不一定有
            NSString *hConstraintString = [NSString stringWithFormat:@"H:|-12-[opMark(%f)]-5-[sourceLabel]", opMarkSize.width];
            NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hConstraintString options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
            self.footerIconHConstraints = hConstraints;
            [self.contentView addConstraints:self.footerIconHConstraints];
        } else {
            [self.opMark setHidden:YES];
        }
    }
}
@end
