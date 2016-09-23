//
//  NewsService.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCTNetwork.h"

@interface NewsService : NSObject
+ (void)queryNavChannelWithcompletion:(void(^)(UCTNetworkResponseStatus status, NSArray *channelList))completion;

+ (void)queryNewsWithChannelId:(NSString *)channelId
                        method:(NSString *)method
                        recoid:(NSString *)recoid
                    completion:(void (^)(UCTNetworkResponseStatus, NSDictionary *))completion;
@end
