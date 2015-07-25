//
//  WTWeatherData.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WTCity.h"

@interface WTWeatherData : NSObject

@property (nonatomic, strong) WTCity *city;
@property (nonatomic, strong) NSArray *forecasts;

@end
