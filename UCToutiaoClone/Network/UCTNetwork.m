//
//  UCTNetwork.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNetwork.h"
#import "AFNetworking.h"
#import "UCTNetworkManager.h"

const NSTimeInterval REQ_TIMEOUT_INTERVAL = 20;
static UCTNetwork *_uctNetwork = nil;

@interface UCTNetwork ()
@property (strong, nonatomic) AFHTTPSessionManager *afHTTPSessionManager;
@end

@implementation UCTNetwork
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _uctNetwork = [[UCTNetwork alloc] init];
        _uctNetwork.afHTTPSessionManager = [AFHTTPSessionManager manager];
        [_uctNetwork configureSessionManager];
    });
    return _uctNetwork;
}

- (void)configureSessionManager {
    [_afHTTPSessionManager.requestSerializer setTimeoutInterval:REQ_TIMEOUT_INTERVAL];
}

+ (NSURLSessionTask *)getWithUrlString:(NSString *)urlString
                             parameters:(NSDictionary *)parameters
                        responseHandler:(UCTNetworkResponseHandler)responseHandler {
    NSDictionary *requestParam = [UCTNetworkManager addDefaultParameters:parameters];
    NSURLSessionTask *task = [[UCTNetwork shareInstance].afHTTPSessionManager GET:urlString
                                                                       parameters:requestParam
                                                                         progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseWithResponseHandler:responseHandler status:UCTNetworkResponseSucceed jsonResult:responseObject task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseWithResponseHandler:responseHandler status:UCTNetworkResponseFail jsonResult:nil task:task];
    }];
    return task;
}

+ (NSURLSessionTask *)postWithUrlString:(NSString *)urlString
                            parameters:(NSDictionary *)parameters
                       responseHandler:(UCTNetworkResponseHandler)responseHandler {
    NSDictionary *requestParam = [UCTNetworkManager addDefaultParameters:parameters];
    NSURLSessionTask *task = [[UCTNetwork shareInstance].afHTTPSessionManager POST:urlString
                                                                        parameters:requestParam
                                                                          progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleResponseWithResponseHandler:responseHandler status:UCTNetworkResponseSucceed jsonResult:responseObject task:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleResponseWithResponseHandler:responseHandler status:UCTNetworkResponseFail jsonResult:nil task:task];
    }];
    return task;
}

+ (void)handleResponseWithResponseHandler:(UCTNetworkResponseHandler)responseHandler
                                   status:(UCTNetworkResponseStatus)status
                               jsonResult:(NSDictionary *)jsonResult
                                     task:(NSURLSessionTask *)task {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *correctDict = [UCTNetworkManager verifyResultData:jsonResult response:task.response];
        responseHandler ? responseHandler(status, correctDict) : nil;
    });
}
@end
