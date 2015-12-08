//
//  HomeViewController.h
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewBaseController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HomeViewController : CenterViewBaseController <CLLocationManagerDelegate, MKMapViewDelegate>


@end
