//
//  PlaceAnnotation.m
//  Fashionistas
//
//  Created by YangYusheng on 12/8/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "PlaceAnnotation.h"

@implementation PlaceAnnotation

- (instancetype)initAnnotationWith:(CLLocation *)location andTitle:(NSString *)title
{
    self = [self init];
    if (self) {
        self.title = title;
        self.coordinate = location.coordinate;
        return self;
    }
    return self;
}

@end
