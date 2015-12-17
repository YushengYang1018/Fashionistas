//
//  ServiceViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "ServiceViewController.h"
#import "XLButtonBarViewCell.h"
#import "SalonMenHairTableViewController.h"
#import "SalonWomenHairServiceTableViewController.h"
#import "SalonNailsServiceTableViewController.h"
#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>

@interface ServiceViewController ()

@end

@implementation ServiceViewController{
    BOOL _isReload;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    // Do any additional setup after loading the view.
    
    [self.buttonBarView setBackgroundColor:[UIColor paperColorBlueGray600]];
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar addSubview:self.buttonBarView];
    
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
            [newCell.label setTextColor:[UIColor whiteColor]];
            
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                     oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                 }
                                 completion:nil];
            }
            else{
                newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }
        }
    };
}


#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    SalonWomenHairServiceTableViewController * child_1 = [[SalonWomenHairServiceTableViewController alloc] initWithStyle:UITableViewStylePlain];
     SalonMenHairTableViewController *child_2 = [[SalonMenHairTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SalonNailsServiceTableViewController *child_3 = [[SalonNailsServiceTableViewController alloc]initWithStyle:UITableViewStyleGrouped];

    if (!_isReload){
        return @[child_1, child_2, child_3];
    }
    
    NSArray * childViewControllers = [NSArray arrayWithObjects:child_1, child_2,child_3, nil];
    return childViewControllers;
}

-(void)reloadPagerTabStripView
{
    _isReload = YES;
    self.isProgressiveIndicator = (rand() % 2 == 0);
    self.isElasticIndicatorLimit = (rand() % 2 == 0);
    [super reloadPagerTabStripView];
}

@end
