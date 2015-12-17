//
//  SalonMenHairTableViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "SalonMenHairTableViewController.h"

@interface SalonMenHairTableViewController ()

@end

NSString *const menHairCellIdentifier = @"menHairCellIdentifier";

@implementation SalonMenHairTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.services = [[NSDictionary alloc]initWithDictionary:[[SalonServiceModel sharedSalonServiceModel]menHair]];
        self.serviceNames = [[NSArray alloc]initWithArray:[self.services allKeys]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SalonServiceTableViewCell class] forCellReuseIdentifier:menHairCellIdentifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.serviceNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SalonServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menHairCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.serviceNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.services objectForKey:[self.serviceNames objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - XLPagerTabStripViewControllerDelegate
-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Men Hair";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor blackColor];
}


@end
