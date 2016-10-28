//
//  MetadataManager.m
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/28.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import "MetadataManager.h"
#import "ZYLocationManager.h"
#import "CommonService.h"
#import "WeatherService.h"

static MetadataManager *_metadataManager = nil;
@interface MetadataManager () <UIAlertViewDelegate>
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSDictionary *weatherDict;
@end

@implementation MetadataManager
{
    CLLocationCoordinate2D _location;
    NSString *_city;
}
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _metadataManager = [[MetadataManager alloc] init];
    });
    return _metadataManager;
}

- (void)prepareLocationInfo {
    __weak __typeof(self) weakSelf = self;
    [[ZYLocationManager shareManager] getCity:weakSelf complete:^(NSString *city, CLLocationCoordinate2D location, NSError *error) {
        if (nil == error) {
            if (city.length > 0) {
                self.city = city;
            }
            self.location = location;
        } else {
            //verify authority
            authorityBlock(error, weakSelf);
        }
    }];
}

- (CLLocationCoordinate2D)location {
    //每次获取后更新一次定位信息
    [self prepareLocationInfo];
    return _location;
}

- (void)setLocation:(CLLocationCoordinate2D)location {
    _location = location;
}

- (NSString *)city {
    [self prepareLocationInfo];
    return _city;
}

- (void)setCity:(NSString *)city {
    _city = [city copy];
    __weak __typeof(self) weakSelf = self;
    [WeatherService queryWeatherInfoWithCity:_city completion:^(UCTNetworkResponseStatus status, NSDictionary *resultDict) {
        weakSelf.weatherDict = resultDict;
    }];
}
@end
