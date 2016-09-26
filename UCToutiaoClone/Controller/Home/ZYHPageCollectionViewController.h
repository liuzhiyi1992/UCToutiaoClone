//
//  ZYHPageCollectionViewController.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/21.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHPageCollectionViewController : UICollectionViewController
@property (copy, nonatomic) NSString *channelId;
@property (strong, nonatomic) UIScrollView *homePageScrollView;//todo
- (void)freshData;
@end
