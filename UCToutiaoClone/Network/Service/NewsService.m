//
//  NewsService.m
//  UCToutiaoClone
//
//  Created by lzy on 16/9/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "NewsService.h"

@implementation NewsService
+ (void)queryNavChannelWithcompletion:(void (^)(UCTNetworkResponseStatus, NSArray *))completion {
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionary];
    [reqDict setValue:@"ucnews-iflow" forKey:@"app"];
    [reqDict setValue:@"dnnivebichfrmintcpgieiwidsudsvadpf" forKey:@"uc_param_str"];
    [reqDict setValue:@"800" forKey:@"bi"];
    [reqDict setValue:@"tt_13" forKey:@"ch"];
    [reqDict setValue:@"2" forKey:@"nt"];
    [reqDict setValue:@"bTkwBeisrUb0JXE+5nOLXtHCaoVEGnZEcZ9GZSMD8qSqiUkx9w5kp+ipqOit7w==" forKey:@"ei"];
    [reqDict setValue:@"bTkwBRKsswSNIHuFlUfKYACkD2uGdSKto+sWoMV/uqjx7Q==" forKey:@"ds"];
    [reqDict setValue:@"release" forKey:@"sv"];
    
    [UCTNetwork getWithUrlString:@"http://iflow.uczzd.cn/iflow/api/v1/channels" parameters:reqDict responseHandler:^(UCTNetworkResponseStatus status, NSDictionary *resultDict) {
        NSDictionary *dataDict = [resultDict objectForKey:@"data"];
        NSArray *channelList = [dataDict objectForKey:@"channel"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status, channelList);
        });
    }];
    
    //iflow.uczzd.cn/iflow/api/v1/channels?app=ucnews-iflow&uc_param_str=dnnivebichfrmintcpgieiwidsudsvadpf&dn=&ve=1.5.0.805&bi=800&ch=tt_13&fr=iphone&mi=iPhone7,1&nt=2&cp=&gi=&ei=bTkwBeisrUb0JXE+5nOLXtHCaoVEGnZEcZ9GZSMD8qSqiUkx9w5kp+ipqOit7w==&wi=&ds=bTkwBRKsswSNIHuFlUfKYACkD2uGdSKto+sWoMV/uqjx7Q==&sv=release&pf=195
}
@end
