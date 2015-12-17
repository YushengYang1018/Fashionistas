//
//  SignInViewController.m
//  GapVideo
//
//  Created by YangYusheng on 11/23/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"

@interface SignInViewController ()

@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet GIDSignInButton *ggSignInButton;



@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Sign In";
    //google
    [GIDSignIn sharedInstance].uiDelegate = self;
    //facebook
    self.fbSignInButton.delegate = self;
    self.fbSignInButton = (FBSDKLoginButton *)[[FBSDKLoginButton alloc]init];
    [self.fbSignInButton setReadPermissions:@[@"email"]];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - signin
- (IBAction)signInButtonClick:(id)sender
{
    NSString *password = self.passwordField.text;
    NSString *email = self.emailField.text;
    if ([email isEqualToString:@""] || [password isEqualToString:@""]) {
        [self showAlertWithTitle:@"Warning" andMessage:@"Please enter the username and password"];
    } else {
        SignInStateTypes signInState =[Config verifyUserEmail:email andPassword:password];
        if (signInState & SignInStateCorrect) {
            NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
            [settings removeObjectForKey:@"email"];
            [settings removeObjectForKey:@"password"];
            [settings setObject:email forKey:@"email"];
            [settings setObject:[Config getUserNameWithEmail:email] forKey:@"username"];
            password = [AESCrypt encrypt:password password:@"password"];
            [settings setObject:password forKey:@"password"];
            [settings synchronize];
            
            AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myDelegate setDrawerCenterWindow];
        } else if(signInState & SignInStateUserNotExist){
            [self showAlertWithTitle:@"Warning" andMessage:@"Cannot find Username"];
        } else {
            [self showAlertWithTitle:@"Warning" andMessage:@"Wrong Passwod"];
        }
    }
}

- (IBAction)signUpButtonClick:(id)sender
{
    //[self performSegueWithIdentifier:@"SignUpSegueIdentifier" sender:sender];
}


- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)skipLoginButtonClick:(id)sender
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate setDrawerCenterWindow];
}

#pragma mark - facebook login button delegate
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

-(void)profileUpdated:(NSNotification *) notification{
    if ([FBSDKAccessToken currentAccessToken]) {
        __block NSString *email = nil;
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 email = result[@"email"];
             }
         }];
//        NSLog(@"User name: %@",[FBSDKProfile currentProfile].name);
//        NSLog(@"User ID: %@",[FBSDKProfile currentProfile].userID);
        [Config saveUserId:[FBSDKProfile currentProfile].userID andUsername:[FBSDKProfile currentProfile].name andEmail:(email==nil ? @"":email) andPassword:@""];
        
        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myDelegate setDrawerCenterWindow];
    }
}


@end
