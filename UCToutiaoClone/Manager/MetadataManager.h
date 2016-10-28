//
//  MetadataManager.h
//  UCToutiaoClone
//
//  Created by zhiyi on 16/10/28.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MetadataManager : NSObject
+ (instancetype)shareManager;
- (void)prepareLocationInfo;
- (CLLocationCoordinate2D)location;
- (NSString *)city;
@end
