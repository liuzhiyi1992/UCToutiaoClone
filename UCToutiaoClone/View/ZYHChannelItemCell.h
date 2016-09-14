//
//  ZYHCategoryItemCell.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/13.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCTCollectionViewCell.h"

@interface ZYHChannelItemCell : UCTCollectionViewCell
+ (NSString *)cellReuseIdentifier;
- (void)updateCellWithTitle:(NSString *)title;
- (void)changeCellSelect:(BOOL)select;
+ (NSDictionary *)attributeForTitleLabel;
@end
