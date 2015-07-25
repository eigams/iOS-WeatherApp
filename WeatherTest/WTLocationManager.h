//
//  WTLocationManager.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^WTLocationManagerCompletion_t)(CLLocation *location, NSError *error) ;

@interface WTLocationManager : NSObject

//+ (id)sharedManager;

- (void) start:(WTLocationManagerCompletion_t)completion;
- (void) stop;

@end
