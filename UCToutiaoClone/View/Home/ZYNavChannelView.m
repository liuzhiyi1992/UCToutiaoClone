//
//  ZYNavCategoryView.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYNavChannelView.h"
#import "Masonry.h"

@implementation ZYNavChannelView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //do something
        [self setBackgroundColor:[UIColor yellowColor]];
    }
    return self;
}
@end
