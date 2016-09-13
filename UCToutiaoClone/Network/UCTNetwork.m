//
//  UCTNetwork.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "UCTNetwork.h"
#import "AFNetworking.h"

@interface UCTNetwork ()
@property (strong, nonatomic) AFHTTPSessionManager *afHTTPSessionManager;
@end

@implementation UCTNetwork
+ (NSURLSessionTask *)getWithUrlString:(NSString *)basicUrlString
                             parameters:(NSDictionary *)parameters
                               complete:(void(^)())complete {
    return nil;
}
@end
