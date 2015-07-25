//
//  WTTodayForecastCollectionViewDataController.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "WTTodayForecastCollectionViewDataController.h"
#import "WTTodayForecastCollectionViewCell.h"

#import "WTWeatherConditions.h"

@implementation WTTodayForecastCollectionViewDataController

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.todayForecasts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TodayForecastCell";
    WTTodayForecastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //configure cell
    
    WTWeatherConditions *weatherConditions = [self.todayForecasts objectAtIndex:indexPath.row];
    cell.timeLabel.text = [self formatTimeFromDate:weatherConditions.time];
    cell.tempLabel.text = [NSString stringWithFormat:@"%.f%@", (weatherConditions.temp - 273.15), @"\u00B0"];
    
    return cell;
}

- (NSString *)formatTimeFromDate:(NSUInteger)dateInterval {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateInterval];
    
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    });
    
    date = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    
    [dateFormatter setDateFormat:@"h a"];
    
    return [dateFormatter stringFromDate:date];
}

@end
