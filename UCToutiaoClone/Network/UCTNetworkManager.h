//
//  UCTNetworkManager.h
//  UCToutiaoClone
//
//  Created by 刘智艺 on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCTNetworkManager : NSObject
+ (NSDictionary *)addDefaultParameters:(NSDictionary *)parameters;
+ (NSDictionary *)verifyResultData:(NSDictionary *)resultData response:(NSURLResponse *)response;
@end
