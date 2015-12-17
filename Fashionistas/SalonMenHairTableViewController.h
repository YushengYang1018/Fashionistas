//
//  SalonMenHairTableViewController.h
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "SalonServiceModel.h"
#import "SalonServiceTableViewCell.h"

@interface SalonMenHairTableViewController : UITableViewController <XLPagerTabStripChildItem>

@property (strong,nonatomic)NSArray *serviceNames;
@property (strong,nonatomic)NSDictionary *services;


@end
