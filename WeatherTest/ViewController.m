//
//  ViewController.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import "ViewController.h"

#import "WTLocationManager.h"
#import "WTRemoteClient.h"
#import "WTOpenWeatherMapDataManager.h"
#import "WTWeatherData.h"
#import "WTWeatherConditions.h"

#import "WTWeekForecastTableViewDataController.h"
#import "WTTodayForecastCollectionViewDataController.h"
#import "MainViewDataController.h"

#import "WTTodayForecastCollectionViewCell.h"
#import "WTWeekForecastTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *todayForecastCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *weeklyForecastTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet WTWeekForecastTableViewDataController *weekForecastDataController;
@property (strong, nonatomic) IBOutlet WTTodayForecastCollectionViewDataController *todayForecastDataController;
@property (strong, nonatomic) IBOutlet MainViewDataController *dataController;

@property (nonatomic, strong) WTLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self retrieveData];
}

- (IBAction)refreshButtonPressed:(id)sender {
    [self retrieveData];
}

- (void)retrieveData {
    self.locationManager = [[WTLocationManager alloc] init];
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
    
    __weak ViewController *weakSelf = self;
    
    [self.locationManager start:^(CLLocation *location, NSError *error) {
        
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.activityIndicator.hidden = YES;
        
        if(location) {
            [[WTRemoteClient sharedInstance] downloadWeatherData:location
                                                      completion:^(NSData *data, NSError *error) {
                                                          
                                                          if(nil != error) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                                                                                      message:[error localizedDescription]
                                                                                                                     delegate:nil
                                                                                                            cancelButtonTitle:@"OK"
                                                                                                            otherButtonTitles:nil];
                                                                  
                                                                  [alertView show];
                                                              });
                                                              
                                                              return ;
                                                          }
                                                          
                                                          WTWeatherData *weatherData = [WTOpenWeatherMapDataManager toWeatherData:data];
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              
                                                              weakSelf.dataController.currentCity = weatherData.city;
                                                              weakSelf.cityNameLabel.text = weatherData.city.name;
                                                              WTWeatherConditions *weatherConditions = [weatherData.forecasts firstObject];
                                                              weakSelf.temperatureLabel.text = [NSString stringWithFormat:@"%.f%@", (weatherConditions.temp - 273.15), @"\u00B0"];
                                                              weakSelf.weatherDescriptionLabel.text = weatherConditions.descr;
                                                              
                                                              weakSelf.todayForecastDataController.todayForecasts = [weatherData.forecasts subarrayWithRange:NSMakeRange(0, 8)];
                                                              weakSelf.weekForecastDataController.weeklyForecasts = [weatherData.forecasts subarrayWithRange:NSMakeRange(8, [weatherData.forecasts count] - 8)];
                                                              
                                                              [weakSelf.todayForecastCollectionView reloadData];
                                                              [weakSelf.weeklyForecastTableView reloadData];
                                                          });
                                                          
                                                      }];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                                    message:[error localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                
                [alertView show];
            });
        }
    }];
}
- (IBAction)markAsFavouriteButtonPressed:(id)sender {
    
    [self.dataController addFavourite];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
