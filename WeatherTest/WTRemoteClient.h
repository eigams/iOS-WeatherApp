//
//  WTRemoteClient.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^WTRemoteClientCompletion_t)(NSData *, NSError *);

@interface WTRemoteClient : NSObject

+ (instancetype)sharedInstance;
- (void)downloadWeatherData:(CLLocation *)location completion:(WTRemoteClientCompletion_t)completion;

@end
