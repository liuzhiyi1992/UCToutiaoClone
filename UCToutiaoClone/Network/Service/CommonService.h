//
//  CommonService.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCTNetwork.h"

@interface CommonService : NSObject
+ (void)queryLocationInfoWithLatitude:(double)latitude
                            longitude:(double)longitude
                           completion:(void(^)(UCTNetworkResponseStatus status, NSDictionary *resultDict))completion;
@end
