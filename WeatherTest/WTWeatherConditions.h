//
//  WTWeatherConditions.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTWeatherConditions : NSObject

@property (nonatomic, assign) NSUInteger time;
@property (nonatomic, copy) NSString *time_txt;
@property (nonatomic, assign) CGFloat temp;
@property (nonatomic, assign) CGFloat temp_min;
@property (nonatomic, assign) CGFloat temp_max;
@property (nonatomic, assign) CGFloat pressure;
@property (nonatomic, assign) CGFloat humidity;

@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *details;

@end
