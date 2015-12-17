//
//  SalonServiceTableViewController.h
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "SalonServiceModel.h"

@interface SalonWomenHairServiceTableViewController: UITableViewController <XLPagerTabStripChildItem>

@property (strong,nonatomic)NSArray *serviceNames;
@property (strong,nonatomic)NSDictionary *services;

@end
