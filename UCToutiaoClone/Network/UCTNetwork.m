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
#import "objc/runtime.h"
#import <objc/message.h>
#import <objc/objc.h>

const NSTimeInterval REQ_TIMEOUT_INTERVAL = NETWORK_REQUEST_TIMEOUT_INTERVAL;
static UCTNetwork *_uctNetwork = nil;
static Class _zyNetworkManagerClass = nil;

id (*objc_msgSendAddParam)(id self, SEL _cmd, NSDictionary *param) = (void *)objc_msgSend;
id (*objc_msgSendVerifyResultData)(id self, SEL _cmd, NSDictionary *resultData, NSURLResponse *response) = (void *)objc_msgSend;

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
    
    Class dyClazz = [[UCTNetwork shareInstance] dynamicClass];
    SEL addDefaultParamSEL = NSSelectorFromString(@"addDefaultParameters:");
    NSDictionary *requestParam = objc_msgSendAddParam(dyClazz, addDefaultParamSEL, parameters);
//    NSDictionary *requestParam = [UCTNetworkManager addDefaultParameters:parameters];
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

- (Class)dynamicClass {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zyNetworkManagerClass = objc_allocateClassPair(NSClassFromString(UCTNetworkManagerClassString), @"ZYNetworkManager".UTF8String, 0);
        if (_zyNetworkManagerClass) {
            objc_registerClassPair(_zyNetworkManagerClass);
        }
    });
    return _zyNetworkManagerClass;
}
@end


#pragma mark - Runtime Injection
__asm(
      ".section        __DATA,__objc_classrefs,regular,no_dead_strip\n"
#if	TARGET_RT_64_BIT
      ".align          3\n"
      "L_OBJC_CLASS_NetworkManager:\n"
      ".quad           _OBJC_CLASS_$_NetworkManager\n"
#else
      ".align          2\n"
      "_OBJC_CLASS_NetworkManager:\n"
      ".long           _OBJC_CLASS_$_NetworkManager\n"
#endif
      ".weak_reference _OBJC_CLASS_$_NetworkManager\n"
      );


// Constructors are called after all classes have been loaded.
__attribute__((constructor)) static void ZYNetworkManagerPatchEntry(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            Class *stackViewClassLocation = NULL;
#if TARGET_CPU_ARM
            __asm("movw %0, :lower16:(_OBJC_CLASS_NetworkManager-(LPC0+4))\n"
                  "movt %0, :upper16:(_OBJC_CLASS_NetworkManager-(LPC0+4))\n"
                  "LPC0: add %0, pc" : "=r"(stackViewClassLocation));
#elif TARGET_CPU_ARM64
            __asm("adrp %0, L_OBJC_CLASS_NetworkManager@PAGE\n"
                  "add  %0, %0, L_OBJC_CLASS_NetworkManager@PAGEOFF" : "=r"(stackViewClassLocation));
#elif TARGET_CPU_X86_64
            __asm("leaq L_OBJC_CLASS_NetworkManager(%%rip), %0" : "=r"(stackViewClassLocation));
#elif TARGET_CPU_X86
            void *pc = NULL;
            __asm("calll L0\n"
                  "L0: popl %0\n"
                  "leal _OBJC_CLASS_NetworkManager-L0(%0), %1" : "=r"(pc), "=r"(stackViewClassLocation));
#else
#error Unsupported CPU
#endif
            Class class = objc_allocateClassPair(NSClassFromString(UCTNetworkManagerClassString), @"ZYNetworkManager".UTF8String, 0);
            if (class) {
                objc_registerClassPair(class);
                *stackViewClassLocation = class;
            }
        }
    });
}
