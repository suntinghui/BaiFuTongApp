//
//  LocationHelper.m
//  POS2iPhone
//
//  Created by  STH on 12/8/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

/**
 From Apple documentation:
 
 Configuration of your location manager object must always occur on a thread with an active run loop, such as your application’s main thread.
 **/

#import "LocationHelper.h"

@implementation LocationHelper

@synthesize locationManager = _locationManager;

static LocationHelper *instance = nil;

+ (LocationHelper *) sharedLocationHelper
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[LocationHelper alloc] init];
        }
    }
    
    return instance;
}

- (void) startLocate
{
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted) {
            
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.purpose = @"为保证交易安全，完美支付需要取得您的交易地点，否则无法进行交易";
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            self.locationManager.distanceFilter = 1000.0f;
            
            [self.locationManager startUpdatingLocation];
            //[self.locationManager startMonitoringSignificantLocationChanges];
            
        } else {
            NSLog(@"手机定位服务已打开，但是完美支付没有获得定位权限.");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"为了保证交易安全，强烈建议您打开手机定位服务，并允许完美支付访问您的位置。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } else {
        NSLog(@"手机没有打开定位服务.");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"为了保证交易安全，强烈建议您打开手机定位服务，并允许完美支付访问您的位置。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    [geocode reverseGeocodeLocation:manager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            NSLog(@"name = %@", placemark.name);
            NSLog(@"thoroughfare = %@", placemark.thoroughfare);
            NSLog(@"subThoroughfare = %@", placemark.subThoroughfare);
            NSLog(@"locality = %@", placemark.locality);
            NSLog(@"subLocality = %@", placemark.subLocality);
            NSLog(@"administrativeArea = %@",placemark.administrativeArea);
            NSLog(@"subAdministrativeArea = %@",placemark.subAdministrativeArea);
            NSLog(@"Postal Code = %@", placemark.postalCode);
            NSLog(@"ISOcountryCode = %@", placemark.ISOcountryCode);
            NSLog(@"Country = %@", placemark.country);
            NSLog(@"inlandWater = %@", placemark.inlandWater);
            NSLog(@"ocean = %@", placemark.ocean);
            NSLog(@"areasOfInterest = %@",placemark.areasOfInterest);
            
            NSLog(@"addressDictionary = %@",placemark.addressDictionary);
            NSLog(@"location = %@",placemark.location);
            NSLog(@"region = %@",placemark.region);
            /**
             
             2013-04-17 15:40:43.295 POS2iPhone[8048:907] name = 北京市朝阳区白家庄小学
             2013-04-17 15:40:43.297 POS2iPhone[8048:907] thoroughfare = 北京市朝阳区白家庄小学
             2013-04-17 15:40:43.299 POS2iPhone[8048:907] subThoroughfare = (null)
             2013-04-17 15:40:43.300 POS2iPhone[8048:907] locality = (null)
             2013-04-17 15:40:43.303 POS2iPhone[8048:907] subLocality = 朝阳区
             2013-04-17 15:40:43.304 POS2iPhone[8048:907] administrativeArea = 北京市
             2013-04-17 15:40:43.306 POS2iPhone[8048:907] subAdministrativeArea = (null)
             2013-04-17 15:40:43.342 POS2iPhone[8048:907] Postal Code = (null)
             2013-04-17 15:40:43.346 POS2iPhone[8048:907] ISOcountryCode = CN
             2013-04-17 15:40:43.373 POS2iPhone[8048:907] Country = 中国
             2013-04-17 15:40:43.375 POS2iPhone[8048:907] inlandWater = (null)
             2013-04-17 15:40:43.377 POS2iPhone[8048:907] ocean = (null)
             2013-04-17 15:40:43.379 POS2iPhone[8048:907] areasOfInterest = (
             "\U5317\U4eac\U5e02\U671d\U9633\U533a\U767d\U5bb6\U5e84\U5c0f\U5b66"
             
             **/
            
            [[AppDataCenter sharedAppDataCenter] setAddress:[NSString stringWithFormat:@"%f,%f,%@%@%@", placemark.location.coordinate.longitude,placemark.location.coordinate.latitude, placemark.country, placemark.administrativeArea, placemark.subLocality]];
            
            NSLog(@"ADDRESS:%@", [[AppDataCenter sharedAppDataCenter] getValueWithKey:@"__ADDRESS"]);
            
            
        } else if (error == nil && [placemarks count] == 0){
            NSLog(@"No results were returned.");
            [[AppDataCenter sharedAppDataCenter] setAddress:@"UNKNOWN"];
            
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
            [[AppDataCenter sharedAppDataCenter] setAddress:@"UNKNOWN"];
        }
    }];
}

// 当定位出现错误时就会调用这个方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location:=======================");
    [[AppDataCenter sharedAppDataCenter] setAddress:@"UNKNOWN"];
}

// 定位服务权限发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Location:----------------------%d", status);
}

@end
