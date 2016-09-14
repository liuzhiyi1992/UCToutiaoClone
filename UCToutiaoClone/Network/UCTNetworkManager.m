//
//  UCTNetworkManager.m
//  UCToutiaoClone
//
//  Created by 刘智艺 on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNetworkManager.h"
#import "UCTNetwork.h"

@interface UCTNetworkManager () <UCTNetworkDelegate>
@end

@implementation UCTNetworkManager
+ (NSDictionary *)addDefaultParameters:(NSDictionary *)undressedParam {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:undressedParam];
    //stats params
    return mutDict;
}

+ (NSDictionary *)verifyResultData:(NSDictionary *)resultData response:(NSURLResponse *)response {
    //数据有效化 合法化
    return resultData;
}

+ (NSDictionary *)uctNetworkAppendDefaultParam:(NSDictionary *)requestDict {
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithDictionary:requestDict];
    //stats params
    return mutDict;
}
@end
