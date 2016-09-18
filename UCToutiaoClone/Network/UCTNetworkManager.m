//
//  UCTNetworkManager.m
//  UCToutiaoClone
//
//  Created by 刘智艺 on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNetworkManager.h"
#import "UCTNetwork.h"

@implementation UCTNetworkManager
/**
 * stats params
 */
+ (NSDictionary *)zyNetworkAppendDefaultParam:(NSDictionary *)undressedParam {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:undressedParam];
    [mutDict setValue:@"1.5.0.805" forKey:@"ve"];
    [mutDict setValue:@"iphone" forKey:@"fe"];
    [mutDict setValue:@"iPhone7,1" forKey:@"mi"];
    [mutDict setValue:@"195" forKey:@"pf"];
    [mutDict setValue:@"isp:电信;prov:广东;city:广州;na:中国;cc:CN;ac:cp=" forKey:@"cp"];
    [mutDict setValue:@"bTkwBTigl5NEMRtjFm+RjbHqHnskMiIuAfMEejMnsF3quRENtz7M+1hVGmkdEw==" forKey:@"ei"];
    return mutDict;
}

/**
 * 数据有效化 合法化
 */
+ (NSDictionary *)zyNetworkVerifyResultData:(NSDictionary *)resultData response:(NSURLResponse *)response {
    NSLog(@"\nreqUrl: %@", [response.URL absoluteString]);
    return resultData;
}
@end
