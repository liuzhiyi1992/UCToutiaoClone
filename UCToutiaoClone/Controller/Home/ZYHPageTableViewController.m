//
//  ZYHomePageTableViewController.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/12.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHPageTableViewController.h"

@implementation ZYHPageTableViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    
}

- (void)freshData {
    NSLog(@"fresh Data");
}

- (void)setChannelId:(NSString *)channelId {
    NSLog(@"load page");
}

@end
