//
//  MainHomeController.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
extern const CGFloat MAIN_SCROLLVIEW_OFFSET_TOP;
extern const CGFloat CUSTOM_NAV_HEIGHT;
extern const CGFloat CUSTOM_NAV_DISPLAY_HEIGHT;

#define CUSTOM_NAV_DISPLAY_HEIGHT 64    //不包括状态栏
#define CUSTOM_NAV_HEIGHT SCREEN_WIDTH
#define MAIN_SCROLLVIEW_OFFSET_TOP (CUSTOM_NAV_HEIGHT - CUSTOM_NAV_DISPLAY_HEIGHT)

@protocol MainHomeControllerScrollDelegate <NSObject>
- (void)mainHomeScrollViewDidScroll2OffsetY:(CGFloat)offsetY;
@end

@interface MainHomeController : UIViewController
@property (weak, nonatomic) id<MainHomeControllerScrollDelegate> scrollDelegate;
@end
