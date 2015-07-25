//
//  NSDate+WTWeatherTest.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "NSDate+WTWeatherTest.h"

static NSDateFormatter * _dateFormatter;

@implementation NSDate (WTWeatherTest)

- (NSString *)stringWithDateFormat:(NSString *)dateFormat {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    });
    
    [_dateFormatter setDateFormat:dateFormat];
    return [_dateFormatter stringFromDate:self];
}

@end
