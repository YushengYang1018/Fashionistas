//
//  LeftDrawerTableContentController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "LeftDrawerTableContentController.h"
#import "AppDelegate.h"
#import "MMNavigationController.h"

@interface LeftDrawerTableContentController ()

@property (strong,nonatomic)AppDelegate *myDelegate;
@property (strong,nonatomic)UINavigationController *homeViewController;
@property (strong,nonatomic)UINavigationController *serviceViewController;

@end

@implementation LeftDrawerTableContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDelegate = [[UIApplication sharedApplication] delegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            [[self.myDelegate drawerController] setCenterViewController:self.homeViewController];
            [[self.myDelegate drawerController]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        case 1:
            [[self.myDelegate drawerController]setCenterViewController:self.serviceViewController];
            [[self.myDelegate drawerController]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        default:
            break;
    }
}




/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - lazy init
- (UINavigationController *)homeViewController
{
    if (!_homeViewController) {
        UIViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        _homeViewController = [[MMNavigationController alloc]initWithRootViewController:homeViewController];
    }
    return _homeViewController;
}

- (UINavigationController *)serviceViewController
{
    if (!_serviceViewController) {
        UIViewController *serViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceViewController"];
        _serviceViewController = [[MMNavigationController alloc]initWithRootViewController:serViewController];
    }
    return _serviceViewController;
}


@end
