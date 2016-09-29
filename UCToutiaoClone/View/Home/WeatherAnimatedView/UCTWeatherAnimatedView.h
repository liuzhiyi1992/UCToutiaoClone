//
//  UCTWeatherAnimatedView.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCTWeatherAnimatedView : UIView
- (void)transformWithHomeScrollOffsetY:(CGFloat)offsetY;
- (void)transformWithPageScrollOffsetY:(CGFloat)offsetY;
@end
