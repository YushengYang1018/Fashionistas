//
//  LeftDrawerController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "LeftDrawerController.h"
#import "Config.h"
#import "SignInViewController.h"

@interface LeftDrawerController ()
@property (strong, nonatomic) IBOutlet UILabel *userName;


@end

@implementation LeftDrawerController

- (void)viewDidLoad
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ([Config isLogedIn]) {
        self.userName.text = [settings objectForKey:@"username"];
    } else {
        self.userName.text = @"Guest";
    }
}
- (IBAction)logoutButtonClick:(id)sender
{
    [Config logout];
}

- (IBAction)signinButtonClick:(id)sender
{
    if (![Config isLogedIn]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        SignInViewController *firstVC = (SignInViewController *)storyBoard.instantiateInitialViewController;
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:firstVC];
    }
}


@end
