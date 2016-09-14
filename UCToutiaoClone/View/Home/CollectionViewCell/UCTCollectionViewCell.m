//
//  UCTCollectionViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTCollectionViewCell.h"

@implementation UCTCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    return @"UCTCollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
@end
