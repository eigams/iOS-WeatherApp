//
//  WTLocationManager.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "WTLocationManager.h"

@interface WTLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) WTLocationManagerCompletion_t completion;

@end

@implementation WTLocationManager

//+ (id)sharedManager {
//    
//    static WTLocationManager *manager;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        manager = [[WTLocationManager alloc] init];
//    });
//    
//    return manager;
//}

- (id)init {
    
    self = [super init];
    if(self) {
        self.locationManager = [[CLLocationManager alloc] init];
        
        if([CLLocationManager locationServicesEnabled]) {
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            self.locationManager.distanceFilter = 100.0;
        }
    }
    
    return self;
}

- (void)start:(WTLocationManagerCompletion_t)completion {
    
    self.completion = completion;
    self.locationManager.delegate = self;
    
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    else {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)stop {
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = (CLLocation *)[locations lastObject];
    
    self.completion(location, nil);
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.completion(nil, error);
    
    [self.locationManager stopUpdatingLocation];
}

@end
