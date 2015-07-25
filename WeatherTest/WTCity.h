//
//  WTCity.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCity : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, copy) NSString *country;

@end
