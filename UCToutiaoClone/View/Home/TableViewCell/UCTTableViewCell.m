//
//  UCTTableViewCell.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/19.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTTableViewCell.h"

@implementation UCTTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"UCTTableViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
@end
