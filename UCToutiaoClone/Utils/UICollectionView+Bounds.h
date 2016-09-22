//
//  UICollectionView+Bounds.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/22.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Bounds)
@property (assign, nonatomic) BOOL isForbidSpringback;        //是否禁止回弹状态
@property (assign, nonatomic) CGFloat offsetYBoundary;        //禁止回弹分界线
@property (assign, nonatomic) CGFloat forbidAndAutoDistanceY;  //过禁止回弹分界线后自动终点
@property (assign, nonatomic) BOOL isAnimating;
@end
