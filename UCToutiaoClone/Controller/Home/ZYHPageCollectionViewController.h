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

@interface ZYHPageCollectionViewController : UICollectionViewController
@property (copy, nonatomic) NSString *channelId;
@property (strong, nonatomic) UIScrollView *homePageScrollView;
@property (weak, nonatomic) id<ZYHPageCollectionViewControllerDelegate> scrollDelegate;
- (void)freshData;
@end
