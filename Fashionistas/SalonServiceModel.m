//
//  SalonServiceModel.m
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "SalonServiceModel.h"

@implementation SalonServiceModel

+ (instancetype)sharedSalonServiceModel
{
    static SalonServiceModel *salonServiceModel=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        salonServiceModel = [[self alloc]init];
    });
    return salonServiceModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"salon" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _salonService = [[NSDictionary alloc]initWithDictionary:json];
    }
    return self;
}

- (NSDictionary *)womenHair
{
    if (!_womenHair) {
        _womenHair = [[NSDictionary alloc]initWithDictionary:self.salonService[@"women hair"]];
    }
    return _womenHair;
}

- (NSDictionary *)menHair
{
    if (!_menHair) {
        _menHair = [[NSDictionary alloc]initWithDictionary:self.salonService[@"men hair"]];
    }
    return _menHair;
}

- (NSDictionary *)nails
{
    if (!_nails) {
        _nails = [[NSDictionary alloc]initWithDictionary:self.salonService[@"nails"]];
    }
    return _nails;
}
- (NSDictionary *)waxing
{
    if (!_waxing) {
        _waxing = [[NSDictionary alloc]initWithDictionary:self.salonService[@"waxing"]];
    }
    return _waxing;
}
- (NSDictionary *)makeup
{
    if (!_makeup) {
        _makeup = [[NSDictionary alloc]initWithDictionary:self.salonService[@"make-up"]];
    }
    return _makeup;
}

@end
















