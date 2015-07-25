//
//  WTOpenWeatherMapData.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WTOpenWeatherMapDataManager.h"
#import "WTWeatherData.h"
#import "WTWeatherConditions.h"

@implementation WTOpenWeatherMapDataManager


+ (WTWeatherData *)toWeatherData:(NSData *)data {

    if (nil == data || [data length] < 1) {
        return nil;
    }
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:0
                                                               error:&error];
    
    if(nil != error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
        return nil;
    }

    WTWeatherData *weatherData = [[WTWeatherData alloc] init];
    
    WTCity *city = [[WTCity alloc] init];
    city.id = [jsonDict valueForKeyPath:@"city.id"];
    city.name = [jsonDict valueForKeyPath:@"city.name"];
    city.latitude = [[jsonDict valueForKeyPath:@"city.coord.lat"] floatValue];
    city.longitude = [[jsonDict valueForKeyPath:@"city.coord.lon"] floatValue];
    city.country = [jsonDict valueForKeyPath:@"city.country"];
    
    weatherData.city = city;
    
    NSUInteger numForecasts = [[jsonDict valueForKey:@"cnt"] integerValue];
    if(numForecasts < 1) {
        return nil;
    }
    
    NSMutableArray *forecasts = [NSMutableArray arrayWithCapacity:numForecasts];
    
    NSArray *list = [jsonDict objectForKey:@"list"];
    
    for(int i = 0; i < numForecasts; ++i) {
        
        WTWeatherConditions *weatherConditions = [[WTWeatherConditions alloc] init];
        
        NSDictionary *dictConditions = list[i];
        
        weatherConditions.time = [[dictConditions valueForKey:@"dt"] integerValue];
        weatherConditions.time_txt = [dictConditions valueForKey:@"dt_txt"];
        
        weatherConditions.temp = [[dictConditions valueForKeyPath:@"main.temp"] floatValue];
        weatherConditions.temp_min = [[dictConditions valueForKeyPath:@"main.temp_min"] floatValue];
        weatherConditions.temp_max = [[dictConditions valueForKeyPath:@"main.temp_max"] floatValue];
        
        weatherConditions.pressure = [[dictConditions valueForKeyPath:@"main.pressure"] floatValue];
        weatherConditions.humidity = [[dictConditions valueForKeyPath:@"main.humidity"] floatValue];
        
        weatherConditions.descr = [[[dictConditions valueForKey:@"weather"] firstObject] valueForKey:@"main"];
        weatherConditions.details = [[[dictConditions valueForKey:@"weather"] firstObject] valueForKey:@"description"];
        
        [forecasts addObject:weatherConditions];
    }
    
    weatherData.forecasts = [forecasts copy];
    
    return weatherData;
    
}

@end
