//
//  ZYHPageCollectionViewController.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/21.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYHPageCollectionViewControllerDelegate <NSObject>
- (void)pageScrollViewDidScroll2OffsetY:(CGFloat)offsetY;
@end

@protocol ZYHPageCollectionViewControllerHomeDelegate <NSObject>
- (void)pageScrollViewDidEndDragging;
- (void)pageScrollViewDidEndDecelerating;
@end

@interface ZYHPageCollectionViewController : UICollectionViewController
@property (copy, nonatomic) NSString *channelId;
@property (strong, nonatomic) UIScrollView *homePageScrollView;
@property (weak, nonatomic) id<ZYHPageCollectionViewControllerDelegate> scrollDelegate;
@property (weak, nonatomic) id<ZYHPageCollectionViewControllerHomeDelegate> homeDelegate;
- (void)freshData;
@end
