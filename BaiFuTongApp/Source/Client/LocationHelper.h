//
//  LocationHelper.h
//  POS2iPhone
//
//  Created by  STH on 12/8/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationHelper : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager       *_locationManager;
}

@property (nonatomic, strong) CLLocationManager     *locationManager;

+ (LocationHelper *) sharedLocationHelper;
- (void) startLocate;

@end
