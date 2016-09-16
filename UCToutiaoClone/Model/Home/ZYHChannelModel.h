//
//  ZYHChannelModel.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHChannelModel : NSObject
@property (copy, nonatomic) NSString *channelId;
@property (copy, nonatomic) NSString *channelName;
@property (assign, nonatomic) BOOL isDefault;
@property (assign, nonatomic) BOOL isFixed;
@property (assign, nonatomic) BOOL isSelected;
- (instancetype)initWithChannelDict:(NSDictionary *)channelDict;
@end
