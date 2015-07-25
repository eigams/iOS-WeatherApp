//
//  WTWeatherConditionsTests.m
//  WeatherTest
//
//  Created by Stefan Buretea on 7/25/15.
//  Copyright (c) 2015 Stefan Buretea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "WTWeatherConditions.h"

@interface WTWeatherConditionsTests : XCTestCase

@end

@implementation WTWeatherConditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testClassMembers {
    
    WTWeatherConditions *conditions = [[WTWeatherConditions alloc] init];
    
    XCTAssertTrue([conditions respondsToSelector:@selector(time)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(time_txt)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(temp)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(temp_min)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(temp_max)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(pressure)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(humidity)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(descr)]);
    XCTAssertTrue([conditions respondsToSelector:@selector(details)]);
}


@end
