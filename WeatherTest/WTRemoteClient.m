//
//  WTRemoteClient.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/24/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "WTRemoteClient.h"

@implementation WTRemoteClient

+ (id)sharedInstance {
    
    static WTRemoteClient *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WTRemoteClient alloc] init];
    });
    
    return instance;
}

+ (id)requestWithURL:(NSString *)url cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeout:(NSTimeInterval)timeout {
    
    NSString *loginURL = [NSString stringWithFormat:@"%@", url];
    if(nil == loginURL || [loginURL length] < 1) {
        NSLog(@"ERROR: failed to format the login URL");
        
        return nil;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginURL] cachePolicy:cachePolicy timeoutInterval:timeout];
    request.HTTPMethod = @"GET";
    
    return request;
}


static const float REQUEST_TIMEOUT = 120;
static NSString *OPEN_WEATHER_MAP_DATA_URL = @"http://api.openweathermap.org/data/2.5/forecast?lat=%.2f&lon=%.2f&APP=%@";
static NSString *APPID = @"ff287173dfc02d8de3aad212143202e1";
- (void)downloadWeatherData:(CLLocation *)location completion:(WTRemoteClientCompletion_t)completion {
        
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *url = [NSString stringWithFormat:OPEN_WEATHER_MAP_DATA_URL, location.coordinate.latitude, location.coordinate.longitude, APPID];
    
    NSURLRequest *request = [[self class] requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                 timeout:REQUEST_TIMEOUT];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (error == nil && data.length > 0) {
                                                completion(data, nil);
                                            }
                                            else {
                                                completion(nil, error);
                                            }
                                        }
                              ];
    
    [task resume];
}

@end
