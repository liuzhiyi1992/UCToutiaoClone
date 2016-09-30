//
//  UCTAnimTabBarItem.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/30.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCTAnimTabBarItem : UIView
@property (strong, nonatomic) UIButton *mainButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *mainImageView;
- (void)setupItem;
@end
