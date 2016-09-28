//
//  MainHomeController.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>


extern const CGFloat MAIN_SCROLLVIEW_OFFSET_TOP;
extern const CGFloat CUSTOM_NAV_HEIGHT;
extern const CGFloat CUSTOM_NAV_DISPLAY_HEIGHT;

@protocol MainHomeControllerScrollDelegate <NSObject>
- (void)mainHomeScrollViewDidScroll2OffsetY:(CGFloat)offsetY;
@end

@interface MainHomeController : UIViewController
@property (weak, nonatomic) id<MainHomeControllerScrollDelegate> scrollDelegate;
@end
