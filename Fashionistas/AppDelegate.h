//
//  AppDelegate.h
//  Fashionistas
//
//  Created by YangYusheng on 12/7/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MMDrawerController/MMDrawerController.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Google/SignIn.h>
#import "Config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,strong) MMDrawerController * drawerController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)setDrawerCenterWindow;


@end

