//
//  WeatherService.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/27.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "WeatherService.h"

@implementation WeatherService
//http://wea.uc.cn/v2/swa_weather.php?uc_param_str=nieidnutssvebipfcp&ni=bTkwBcd6OU+h1+EknDFySo+hR/ME5WOj3Sc5R4aZCpXoTw==&ei=bTkwBcp6WRXW18XtgEFXD+2mgmcA/q4i2wVC8I2V9tsiwRl1f1Y043KT1P831Q==&dn=4725376569-64cbf0ae&ss=414x736&ve=1.6.0.809&bi=997&pf=195&cp=isp:%E7%A7%BB%E5%8A%A8;prov:%E7%A6%8F%E5%BB%BA;city:%E6%B3%89%E5%B7%9E;na:;cc:;ac:&city=%E5%B9%BF%E5%B7%9E&county=%E5%A4%A9%E6%B2%B3%E5%8C%BA&v=1&vcode=bb1495bb5b6736c5
+ (void)queryWeatherInfoWithCity:(NSString *)city
                      completion:(void (^)(UCTNetworkResponseStatus, NSDictionary *))completion {
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionary];
    [reqDict setValue:city forKey:@"city"];
    [reqDict setValue:@"nieidnutssvebipfcp" forKey:@"uc_param_str"];
    [reqDict setValue:@"bTkwBcd6OU h1 EknDFySo hR/ME5WOj3Sc5R4aZCpXoTw==" forKey:@"ni"];
    [reqDict setValue:@"bTkwBcp6WRXW18XtgEFXD 2mgmcA/q4i2wVC8I2V9tsiwRl1f1Y043KT1P831Q==" forKey:@"ei"];
    [reqDict setValue:@"4725376569-64cbf0ae" forKey:@"dn"];
    [reqDict setValue:@"414x736" forKey:@"ss"];
    [reqDict setValue:@"997" forKey:@"bi"];
    [reqDict setValue:@"bb1495bb5b6736c5" forKey:@"vcode"];
    [reqDict setValue:@"天河区" forKey:@"county"];
//    [reqDict setValue:@"1" forKey:@"v"];
    //county
    //ve=1.6.0.809
    
    [UCTNetwork getWithUrlString:@"http://wea.uc.cn/v2/swa_weather.php" parameters:reqDict responseHandler:^(UCTNetworkResponseStatus status, NSDictionary *resultDict) {
        NSDictionary *dataDict = [resultDict objectForKey:@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(status, dataDict);
        });
    }];
}
@end
