//
//  WTOpenWeatherMapData.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTWeatherData;

@interface WTOpenWeatherMapDataManager : NSObject

+ (WTWeatherData *)toWeatherData:(NSData *)data;

@end
