//
//  WeatherService.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCTNetwork.h"

@interface WeatherService : NSObject
+ (void)queryWeatherInfoWithCity:(NSString *)city
                      completion:(void (^)(UCTNetworkResponseStatus status, NSDictionary *resultDict))completion;
@end
