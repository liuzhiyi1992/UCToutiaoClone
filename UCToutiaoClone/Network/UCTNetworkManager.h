//
//  UCTNetworkManager.h
//  UCToutiaoClone
//
//  Created by 刘智艺 on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCTNetwork.h"

@interface UCTNetworkManager : NSObject <UCTNetworkDelegate>
+ (NSDictionary *)zyNetworkAppendDefaultParam:(NSDictionary *)parameters;
+ (NSDictionary *)zyNetworkVerifyResultData:(NSDictionary *)resultData response:(NSURLResponse *)response;
@end
