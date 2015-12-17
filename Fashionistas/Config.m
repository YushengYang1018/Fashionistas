//
//  Config.m
//  GapVideo
//
//  Created by YangYusheng on 11/23/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "Config.h"
#import <Parse/Parse.h>
#import "SignInViewController.h"

@interface Config ()

@property (strong,nonatomic)NSString *objectiveId;

@end


@implementation Config

#pragma mark - username and password config
+ (SignInStateTypes)saveUserId:(NSString *)userId andUsername:(NSString *)username andEmail:(NSString *)email andPassword:(NSString *)pwd
{
        //store the username and password local
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        [settings removeObjectForKey:@"username"];
        [settings removeObjectForKey:@"email"];
        [settings removeObjectForKey:@"password"];
        [settings removeObjectForKey:@"userId"];
        
        [settings setObject:username forKey:@"username"];
        [settings setObject:email forKey:@"email"];
        [settings setObject:userId forKey:@"userId"];
        pwd = [AESCrypt encrypt:pwd password:@"password"];
        [settings setObject:pwd forKey:@"password"];
        
        [settings synchronize];
        
        //store the username and password to the server
    if (![self isExistUserId:userId]) {
        PFObject *userAccount = [PFObject objectWithClassName:@"UserAccount"];
        userAccount[@"username"] = username;
        userAccount[@"password"] = pwd;
        userAccount[@"email"] = email;
        userAccount[@"userId"] = userId;
        [userAccount save];
    }
    
        
    return SignInStateCorrect;
}

+ (BOOL)isExistUserId:(NSString *)userId
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserAccount"];
    [query whereKey:@"userId" equalTo:userId];
    NSArray *users = [query findObjects];
    if ([users count] != 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isExistUserEmail:(NSString *)email
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserAccount"];
    [query whereKey:@"email" equalTo:email];
    NSArray *users = [query findObjects];
    if ([users count] != 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (SignInStateTypes)verifyUserEmail:(NSString *)email andPassword:(NSString *)pwd
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserAccount"];
    [query whereKey:@"email" equalTo:email];
    
    NSArray *users = [query findObjects];
    if ([users count] == 0) {
        return SignInStateUserNotExist;
    } else {
        PFObject *tmpUser = [users firstObject];
        NSString *tmpPwd = [AESCrypt decrypt:tmpUser[@"password"] password:@"password"];
        NSLog(@"password-->%@",tmpPwd);
        if ([tmpPwd isEqualToString:pwd]) {
            return SignInStateCorrect;
        }else {
            return SignInStateWrongPassword;
        }
    }
}

+ (NSString *)getUserNameWithEmail:(NSString *)email
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserAccount"];
    [query whereKey:@"email" equalTo:email];
    NSArray *users = [query findObjects];
    PFObject *tmpUser = [users firstObject];
    return tmpUser[@"username"];
}

+ (BOOL)isLogedIn
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if ([settings objectForKey:@"username"] != nil && [settings objectForKey:@"password"] != nil) {
        return YES;
    }
    
    return NO;
}

+ (void)logout
{
    if ([self isLogedIn]) {
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        [settings removeObjectForKey:@"username"];
        [settings removeObjectForKey:@"email"];
        [settings removeObjectForKey:@"password"];
        [settings removeObjectForKey:@"userId"];
        
        [settings synchronize];
        
        NSLog(@"Logout");
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        SignInViewController *firstVC = (SignInViewController *)storyBoard.instantiateInitialViewController;
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:firstVC];
    }
}


@end
