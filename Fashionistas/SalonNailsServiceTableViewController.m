//
//  SalonNailsServiceTableViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "SalonNailsServiceTableViewController.h"

@interface SalonNailsServiceTableViewController ()

@end

NSString *const nailCellIdentifier = @"nailCellIdentifier";

@implementation SalonNailsServiceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.services = [[NSDictionary alloc]initWithDictionary:[[SalonServiceModel sharedSalonServiceModel]nails]];
        self.firstNailServiceNames = [[self.services objectForKey:@"standerd care"] allKeys];
        self.secondNailServiceNames = [[self.services objectForKey:@"acrylic nails"] allKeys];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SalonServiceTableViewCell class] forCellReuseIdentifier:nailCellIdentifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.firstNailServiceNames count];
    } else {
        return [self.secondNailServiceNames count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SalonServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nailCellIdentifier forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSDictionary *tmpDict = nil;
    if (section == 0) {
        tmpDict = [self.services objectForKey:@"standerd care"];
        cell.textLabel.text = [self.firstNailServiceNames objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [tmpDict objectForKey:[self.firstNailServiceNames objectAtIndex:row]];
    } else {
        tmpDict = [self.services objectForKey:@"acrylic nails"];
        cell.textLabel.text = [self.secondNailServiceNames objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [tmpDict objectForKey:[self.secondNailServiceNames objectAtIndex:row]];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"standerd care";
    } else {
        return @"acrylic nails";
    }
}

#pragma mark - XLPagerTabStripViewControllerDelegate
-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Nails";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor greenColor];
}


@end
