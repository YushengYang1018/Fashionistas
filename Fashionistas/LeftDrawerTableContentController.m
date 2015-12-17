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
#import "DrawerTableViewCell.h"

@interface LeftDrawerTableContentController ()

@property (strong,nonatomic)AppDelegate *myDelegate;
@property (strong,nonatomic)UINavigationController *homeViewController;
@property (strong,nonatomic)UINavigationController *serviceViewController;
@property (strong,nonatomic)UINavigationController *galleryViewController;
@property (strong,nonatomic)UINavigationController *promotionsViewController;
@property (strong,nonatomic)UINavigationController *aboutViewController;

@property (strong,nonatomic)NSArray *contentArray;

@end


@implementation LeftDrawerTableContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.contentArray = @[@"Home", @"Service",@"Gallery",@"Promotion",@"About"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DrawerTableViewCell" bundle:nil] forCellReuseIdentifier:@"DrawerTableViewCell"];
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
        case 2:
            [[self.myDelegate drawerController]setCenterViewController:self.galleryViewController];
            [[self.myDelegate drawerController]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        case 3:
            [[self.myDelegate drawerController]setCenterViewController:self.promotionsViewController];
            [[self.myDelegate drawerController]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        case 4:
            [[self.myDelegate drawerController]setCenterViewController:self.aboutViewController];
            [[self.myDelegate drawerController]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *simpleTableIdentifier = @"DrawerTableViewCell";
     DrawerTableViewCell *cell = (DrawerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     if (!cell) {
         cell = [[DrawerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
     }
     cell.ImageView.image = [UIImage imageNamed:self.contentArray[indexPath.row]];
     cell.nameLabel.text = self.contentArray[indexPath.row];
 
     return cell;
 }


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
             
- (UINavigationController *)galleryViewController
{
    if(!_galleryViewController){
        UICollectionViewController *galleryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GalleryCollectionViewController"];
        _galleryViewController = [[MMNavigationController alloc]initWithRootViewController:galleryViewController];
    }
    return _galleryViewController;
                 
}

- (UINavigationController *)promotionsViewController
{
    if (!_promotionsViewController) {
        UIViewController *promotion = [self.storyboard instantiateViewControllerWithIdentifier:@"PromotionsViewController"];
        _promotionsViewController = [[MMNavigationController alloc]initWithRootViewController:promotion];
    }
    
    return _promotionsViewController;
}

- (UINavigationController *)aboutViewController
{
    if (!_aboutViewController) {
        UIViewController *about = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        _aboutViewController = [[MMNavigationController alloc]initWithRootViewController:about];
    }
    
    return _aboutViewController;
}

@end









