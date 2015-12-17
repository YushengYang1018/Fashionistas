//
//  Config.h
//  GapVideo
//
//  Created by YangYusheng on 11/23/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AESCrypt.h"

typedef NS_ENUM(NSInteger, SignInStateTypes)
{
    SignInStateCorrect = 1,
    SignInStateUserNotExist = 2,
    SignInStateWrongPassword = 4
};

@interface Config : NSObject

+ (SignInStateTypes)saveUserId:(NSString *)userId andUsername:(NSString *)username andEmail:(NSString *)email andPassword:(NSString *)pwd;
+ (BOOL)isExistUserId:(NSString *)userId;
+ (BOOL)isExistUserEmail:(NSString *)email;
+ (SignInStateTypes)verifyUserEmail:(NSString *)email andPassword:(NSString *)pwd;
+ (BOOL)isLogedIn;
+ (NSString *)getUserNameWithEmail:(NSString *)email;

+ (void)logout;
@end
