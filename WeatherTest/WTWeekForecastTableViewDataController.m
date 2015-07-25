//
//  WTWeekForecastTableViewDataController.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "WTWeekForecastTableViewDataController.h"
#import "WTWeekForecastTableViewCell.h"

#import "WTWeatherConditions.h"
#import "NSDate+WTWeatherTest.h"

@implementation WTWeekForecastTableViewDataController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.weeklyForecasts) {
        [self sortWeeklyForecasts];
    }
    
    return [self.weeklyForecasts count];
}

- (void)sortWeeklyForecasts {
    
    static const int increment = 8; //because we increment over 24 hours (the array holds data each 3h, hence the 8)
    static const int MAX_FORECASTS = 7; //hold data just a week
    
    NSMutableArray *sink = [NSMutableArray arrayWithCapacity:MAX_FORECASTS];
    
    for (int i = 0; i < [self.weeklyForecasts count]; i += increment) {
        if(i >= [self.weeklyForecasts count]) {
            [sink addObject:[self.weeklyForecasts lastObject]];
            
            break;
        }
        
        [sink addObject:[self.weeklyForecasts objectAtIndex:i]];
    }
    
    self.weeklyForecasts = [sink copy];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"WeekForecastCell";
    WTWeekForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    WTWeatherConditions *weatherConditions = [self.weeklyForecasts objectAtIndex:indexPath.row];
    
    //configure cell
    cell.wekkDayLabel.text = [[NSDate dateWithTimeIntervalSince1970:weatherConditions.time] stringWithDateFormat:@"EEEE"];
    cell.maxTempLabel.text = [NSString stringWithFormat:@"%.f", weatherConditions.temp_max - 273.15];
    cell.minTempLabel.text = [NSString stringWithFormat:@"%.f", weatherConditions.temp_min - 273.15];
    
    return cell;
}

@end
