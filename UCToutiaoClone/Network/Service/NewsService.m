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

+ (void)queryNewsWithChannelId:(NSString *)channelId
                        method:(NSString *)method
                        recoid:(NSString *)recoid
                    completion:(void (^)(UCTNetworkResponseStatus, NSDictionary *))completion {
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionary];
    [reqDict setValue:@"ucnews-iflow" forKey:@"app"];
    [reqDict setValue:recoid forKey:@"recoid"];
    [reqDict setValue:method forKey:@"method"];//todo 首次进来用new，有记录用his
    [reqDict setValue:@"1" forKey:@"count"];
    [reqDict setValue:@"0" forKey:@"no_op"];
    [reqDict setValue:@"0" forKey:@"auto"];
    [reqDict setValue:@"0" forKey:@"content_ratio"];
    [reqDict setValue:@"1473747667214" forKey:@"_tm"];
    [reqDict setValue:@"bTkwBcWgaRC/PjPslhNEDNe84yQbLtkn5tanjJklndVj6ApITzQh2Fbc" forKey:@"sign"];
    [reqDict setValue:@"1" forKey:@"puser"];
    [reqDict setValue:@"广州" forKey:@"city_name"];
    [reqDict setValue:@"dnnivebichfrmintcpgieiwidsudsvadpf" forKey:@"uc_param_str"];
    [reqDict setValue:@"9321578384-1db433a0" forKey:@"dn"];
    [reqDict setValue:@"bTkwBcigiWmgMREUnxKmoI3rJ8EAJ87vg4GZ8dB3Z8PuvA==" forKey:@"ni"];
    [reqDict setValue:@"800" forKey:@"bi"];
    [reqDict setValue:@"tt_13" forKey:@"ch"];
    [reqDict setValue:@"2" forKey:@"nt"];
    [reqDict setValue:@"bTkwBSqgldqfZlmkLBiTO7bsGuCbcHyeOYUbKu0ktHIbow==" forKey:@"gi"];
    [reqDict setValue:@"bTkwBc2gmnLANAJ73lvT1paMWU98XXCBkIdZ1pRb9WbCgQ==" forKey:@"ds"];
    [reqDict setValue:@"bTkwBeKgnFzDbkNOmHL79L2RRO9IXGvmGvlhrS10pfZq6g==" forKey:@"ud"];
    [reqDict setValue:@"release" forKey:@"sv"];
    
    NSMutableString *urlString = [NSMutableString stringWithString:@"http://iflow.uczzd.cn/iflow/api/v1/channel"];
    [urlString appendString:[NSString stringWithFormat:@"/%@", channelId]];
    [UCTNetwork getWithUrlString:urlString parameters:reqDict responseHandler:^(UCTNetworkResponseStatus status, NSDictionary *resultDict) {
        NSDictionary *dataDict = [resultDict objectForKey:@"data"];
//        BOOL isCleanCache = [[dataDict objectForKey:@"is_clean_cache"] boolValue];
//        NSDictionary *pullDownHintDict = [dataDict objectForKey:@"pull_down_hint"];
//        NSArray *bannersList = [dataDict objectForKey:@"banners"];
//        //暂时用到
//        NSArray *articlesIdList = [dataDict objectForKey:@"items"];
//        NSDictionary *articlesDict = [dataDict objectForKey:@"articles"];
//        NSDictionary *specialsDict = [dataDict objectForKey:@"specials"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status, dataDict);
        });
    }];
    //iflow.uczzd.cn/iflow/api/v1/channel/100?app=ucnews-iflow&recoid=9860030714514883214&ftime=1473664510105&method=new&count=20&no_op=0&auto=0&content_ratio=0&_tm=1473664518824&sign=bTkwBTtoN3s9%2FPYNHZAlwZZdVSV8zGeDIT5onjUOChy9m8PvYhVKWdyu&sc=wemedia&uc_param_str=dnnivebichfrmintcpgieiwidsudsvadpf&dn=4725376569-64cbf0ae&ni=bTkwBd9oa%2b2Z%2bTOG5MdAJN9d4zdUmYfnFWmTYc5TYE8gAQ%3d%3d&ve=1.6.0.809&bi=997&ch=&fr=iphone&mi=iPhone7%2c1&nt=2&cp=isp%3a%E7%A7%BB%E5%8A%A8%3bprov%3a%E7%A6%8F%E5%BB%BA%3bcity%3a%E6%B3%89%E5%B7%9E%3bna%3a%3bcc%3a%3bac%3a&gi=bTkwBQBof9WlrmOj0sC5xhlXyOrPwIiguz3ZO2tcdgaQEg%3d%3d&ei=bTkwBRxog9qg%2bS%2bqMre9MklaNu3sgtqc1UvAIYdfdGhameFhxx6c19R9htSROw%3d%3d&wi=&ds=bTkwBT9oiBBe%2fBCZQIPhdPo8ZQNg7ZRFKj%2bXjE4jO4x4OQ%3d%3d&ud=bTkwBfdojvSVvRSXo7SrVCxFbzri7nyyFXlaIDA6U65pEA%3d%3d&sv=app&pf=195
}
@end
