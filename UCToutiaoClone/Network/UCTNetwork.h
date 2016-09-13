//
//  UCTNetwork.h
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCTNetwork : NSObject
+ (NSURLSessionTask *)getWithUrlString:(NSString *)basicUrlString
                             parameters:(NSDictionary *)parameters
                               complete:(void(^)())complete;
@end
