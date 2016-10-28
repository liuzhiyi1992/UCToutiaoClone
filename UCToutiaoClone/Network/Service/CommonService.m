//
//  CommonService.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "CommonService.h"

@implementation CommonService
+ (void)queryLocationInfoWithLatitude:(double)latitude
                            longitude:(double)longitude
                           completion:(void (^)(UCTNetworkResponseStatus, NSDictionary *))completion {
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionary];
    [reqDict setValue:@"zh" forKey:@"language"];
    [reqDict setValue:@"base" forKey:@"extensions"];
    [reqDict setValue:@"28f346541fd31c674eb2caa0115b2734" forKey:@"key"];
    [reqDict setValue:[NSString stringWithFormat:@"%f,%f", longitude, latitude] forKey:@"location"];
    [reqDict setValue:@"b14adae9bc080537209d4582f0846b8e" forKey:@"scode"];
    [reqDict setValue:@"1473747666717" forKey:@"ts"];
    //http://restapi.amap.com/v3/geocode/regeo?language=zh&extensions=base&key=28f346541fd31c674eb2caa0115b2734&location=113.410492%2C23.135062&scode=b14adae9bc080537209d4582f0846b8e&ts=1473747666717
    [UCTNetwork getWithUrlString:@"http://restapi.amap.com/v3/geocode/regeo" parameters:reqDict responseHandler:^(UCTNetworkResponseStatus status, NSDictionary *resultDict) {
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status, @"");
        });
    }];
}
@end
