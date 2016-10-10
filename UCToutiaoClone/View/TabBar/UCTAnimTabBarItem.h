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
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (assign, nonatomic) NSUInteger index;
- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController index:(NSUInteger)index;
- (void)setupItem;
- (void)handleClick;
@end
