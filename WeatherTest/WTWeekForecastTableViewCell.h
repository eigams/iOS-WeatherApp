//
//  WTWeekForecastTableViewCell.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTWeekForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wekkDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;

@end
