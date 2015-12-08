//
//  HomeViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "HomeViewController.h"
#import "Parameters.h"
#import "PlaceAnnotation.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic)CLLocationManager *locationManager;
@property (strong,nonatomic)CLLocation *currentLocation;
@property (assign,nonatomic)CLLocationDistance distanceToSalon;
@property (strong, nonatomic)CLLocation *salonLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Home"];
    
    //location configuration
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.delegate = self;
    self.mapView.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
    }
    
    //place the salon place on the map
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:SalonAddressString completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            self.salonLocation = [[CLLocation alloc]initWithLatitude:placemark.location.coordinate.latitude longitude:placemark.location.coordinate.longitude];
            [self performSelectorOnMainThread:@selector(placeAnnotation:) withObject:self.salonLocation waitUntilDone:YES];
        }
    }];
}

- (void)placeAnnotation:(CLLocation *)location
{
    PlaceAnnotation *annotation = [[PlaceAnnotation alloc]initAnnotationWith:location andTitle:SalonAddressString];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    [self.mapView addAnnotation:annotation];
    [self.mapView setRegion:region animated:YES];
}


- (IBAction)getDirectionToSalon:(id)sender
{
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: self.salonLocation.coordinate addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = SalonAddressString;
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}

#pragma mark - CLLocatinManagerDelegate methods
- (void)displayRegionCenteredOnMapItem:(MKMapItem*)from {
CLLocation* fromLocation = from.placemark.location;

// Create a region centered on the starting point with a 10km span
MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(fromLocation.coordinate, 10000, 10000);

// Open the item in Maps, specifying the map region to display.
[MKMapItem openMapsWithItems:[NSArray arrayWithObject:from]
               launchOptions:[NSDictionary dictionaryWithObjectsAndKeys:
                              [NSValue valueWithMKCoordinate:region.center], MKLaunchOptionsMapCenterKey,
                              [NSValue valueWithMKCoordinateSpan:region.span], MKLaunchOptionsMapSpanKey, nil]];
}

#pragma mark - MKMapViewDelegate





@end
