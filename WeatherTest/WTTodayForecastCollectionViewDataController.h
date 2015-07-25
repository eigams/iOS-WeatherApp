//
//  WTTodayForecastCollectionViewDataController.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTodayForecastCollectionViewDataController : NSObject<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *todayForecasts;

@end
