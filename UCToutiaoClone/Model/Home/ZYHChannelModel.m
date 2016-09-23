//
//  ZYHChannelModel.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "ZYHChannelModel.h"

@implementation ZYHChannelModel
- (instancetype)initWithChannelDict:(NSDictionary *)channelDict {
    self = [super init];
    if (self) {
        [self packageDataWithDict:channelDict];
    }
    return self;
}

- (void)packageDataWithDict:(NSDictionary *)dict {
    self.channelId = [dict[@"id"] stringValue];
    self.channelName = dict[@"name"];
    self.isDefault = [dict[@"is_default"] boolValue];
    self.isFixed = [dict[@"is_fixed"] boolValue];
}
@end
