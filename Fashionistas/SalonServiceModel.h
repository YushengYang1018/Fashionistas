//
//  SalonServiceModel.h
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalonServiceModel : NSObject

@property (strong,nonatomic)NSDictionary *salonService;
@property (strong,nonatomic)NSDictionary *womenHair;
@property (strong,nonatomic)NSDictionary *menHair;
@property (strong,nonatomic)NSDictionary *nails;
@property (strong,nonatomic)NSDictionary *waxing;
@property (strong,nonatomic)NSDictionary *makeup;

+ (instancetype)sharedSalonServiceModel;

- (NSDictionary *)salonService;
- (NSDictionary *)womenHair;
- (NSDictionary *)menHair;
- (NSDictionary *)nails;
- (NSDictionary *)waxing;
- (NSDictionary *)makeup;

@end
