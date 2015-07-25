//
//  MainViewDataController.h
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTCity;
@interface MainViewDataController : NSObject

@property (nonatomic, strong) WTCity *currentCity;

- (BOOL)addFavourite;

@end
