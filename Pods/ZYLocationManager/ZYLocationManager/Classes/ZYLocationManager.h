//
//  ZYLocationManager.h
//  ZYLocationManager
//
//  Created by lzy on 16/7/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

typedef void (^LocationCompleteBlock)(CLLocationCoordinate2D location, NSError *error);
typedef void (^CityCompleteBlock)(NSString *city, CLLocationCoordinate2D location, NSError *error);

extern const void(^authorityBlock)(NSError *, id<UIAlertViewDelegate>);

@interface ZYLocationManager : NSObject
@property (strong, nonatomic) MKMapView *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D lastCoordinate;
@property(assign, nonatomic)float latitude;
@property(assign, nonatomic)float longitude;

+ (ZYLocationManager *)shareManager;
- (void)getLocationCoordinate:(id)sponsor complete:(LocationCompleteBlock)completeBlock;
- (void)getCity:(id)sponsor complete:(CityCompleteBlock)completeBlock;
@end
