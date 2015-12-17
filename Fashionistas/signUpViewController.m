//
//  signUpViewController.m
//  GapVideo
//
//  Created by YangYusheng on 11/23/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "signUpViewController.h"
#import "AppDelegate.h"
#import "AESCrypt.h"

@interface signUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainLabel;


@end

@implementation signUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Sign Up";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonClick:(id)sender
{
    NSString *username = self.usernameLabel.text;
    NSString *password = self.passwordLabel.text;
    NSString *email = self.emailLabel.text;
    NSString *passwordAgain = self.passwordAgainLabel.text;
    if (![password isEqualToString:passwordAgain]) {
        [self showAlertWithTitle:@"Warning" andMessage:@"password should be the same"];
    } else {
        if ([Config isExistUserEmail:email]) {
            [self showAlertWithTitle:@"Warning" andMessage:@"Email Exist, Please login"];
        } else {
            [Config saveUserId:[AESCrypt encrypt:email password:password] andUsername:username andEmail:email andPassword:password];
            AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myDelegate setDrawerCenterWindow];
        }
    }
}


- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
