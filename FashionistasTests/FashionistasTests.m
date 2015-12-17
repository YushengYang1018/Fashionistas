//
//  FashionistasTests.m
//  FashionistasTests
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MapKit/MapKit.h>
#import "SalonServiceModel.h"
#import "Config.h"

@interface FashionistasTests : XCTestCase

@end

@implementation FashionistasTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *address = @"347 E Main St, Collegeville, PA 19426";
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address
                 completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                    NSLog(@"placemarks-->%lu",[placemarks count]);
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            CLLocation *newLocation = placemark.location;
            NSLog(@"latitude->%f", newLocation.coordinate.latitude);
            NSLog(@"longitude->%f", newLocation.coordinate.longitude);
        }
    }];
}

- (void)testWomenHairDictionary
{
    SalonServiceModel *model = [SalonServiceModel sharedSalonServiceModel];
    NSLog(@"women hair--->%@",[model womenHair]);
}


@end
