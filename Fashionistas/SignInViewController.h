//
//  SignInViewController.h
//  GapVideo
//
//  Created by YangYusheng on 11/23/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import <Google/SignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SignInViewController : UIViewController <GIDSignInUIDelegate, FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbSignInButton;

@end
