//
//  MainViewDataController.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "MainViewDataController.h"

#import "WTCity.h"

@interface MainViewDataController()

@property (nonatomic, strong) NSMutableArray *favourites;

@end

static NSString *const FAVOURITES_FILE = @"favourites.dat";

@implementation MainViewDataController

- (id)init {
    self = [super init];
    
    if(self) {
        [self loadFavourites];
    }
    
    return self;
}

- (void)loadFavourites {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    if ([paths count] > 0) {

        // Path to load favourites
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:FAVOURITES_FILE];
        
        // Write dictionary
        self.favourites = [[NSArray arrayWithContentsOfFile:path] mutableCopy];
    }
}

- (void)saveFavourites {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    
    if ([paths count] > 0) {
        
        // Path to save favourites
        NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:FAVOURITES_FILE];
        
        // Write array
        [self.favourites writeToFile:path atomically:YES];
    }
}

- (NSDictionary *)cityAsDictionary {
    
    return @{@"id": self.currentCity.id,
             @"name": self.currentCity.name,
             @"lat": [NSNumber numberWithFloat:self.currentCity.latitude],
             @"lon": [NSNumber numberWithFloat:self.currentCity.longitude],
             @"country": self.currentCity.country};
}

- (BOOL)addFavourite {
    
    if (nil != self.currentCity) {
        
        NSDictionary *cityDict = [self cityAsDictionary];
        if ([self doesFavouriteExist:cityDict]) {
            [self.favourites addObject:cityDict];
            
            [self saveFavourites];
            
            return YES;
        }
        else {
            [self.favourites removeObject:cityDict];
            
            [self saveFavourites];
            
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)doesFavouriteExist:(NSDictionary *)favourite {
    
    for (NSDictionary *item in self.favourites) {
        if([[favourite valueForKey:@"id"] isEqualToValue:[item valueForKey:@"id"]]) {
            return YES;
        }
        
    }

    return NO;
}

@end
