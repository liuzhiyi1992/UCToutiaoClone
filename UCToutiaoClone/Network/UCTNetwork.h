//
//  UCTNetwork.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UCTNetworkManagerClassString @"UCTNetworkManager"
#define NETWORK_REQUEST_TIMEOUT_INTERVAL 20

@class UCTNetworkManager;
typedef NS_ENUM(NSUInteger, UCTNetworkResponseStatus) {
    UCTNetworkResponseSucceed = 0,
    UCTNetworkResponseFail = 1
};
typedef void(^UCTNetworkResponseHandler)(UCTNetworkResponseStatus status, NSDictionary *resultDict);

@protocol UCTNetworkDelegate <NSObject>
+ (NSDictionary *)uctNetworkAppendDefaultParam:(NSDictionary *)requestDict;
+ (NSDictionary *)verifyResultData:(NSDictionary *)resultData response:(NSURLResponse *)response;
@end

@interface UCTNetwork : NSObject
@property (weak, nonatomic) id<UCTNetworkDelegate> delegate;
+ (NSURLSessionTask *)getWithUrlString:(NSString *)urlString
                             parameters:(NSDictionary *)parameters
                        responseHandler:(UCTNetworkResponseHandler)responseHandler;
@end
