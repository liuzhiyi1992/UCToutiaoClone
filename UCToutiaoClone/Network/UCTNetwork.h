//
//  UCTNetwork.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UCTNetworkResponseStatus) {
    UCTNetworkResponseSucceed = 0,
    UCTNetworkResponseFail = 1
};

typedef void(^UCTNetworkResponseHandler)(UCTNetworkResponseStatus status, NSDictionary *resultDict);

@interface UCTNetwork : NSObject
+ (NSURLSessionTask *)getWithUrlString:(NSString *)urlString
                             parameters:(NSDictionary *)parameters
                        responseHandler:(UCTNetworkResponseHandler)responseHandler;
@end
