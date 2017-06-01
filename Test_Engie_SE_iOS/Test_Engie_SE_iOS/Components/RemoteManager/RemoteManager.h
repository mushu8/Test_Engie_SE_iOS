//
//  RemoteManager.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const RemoteManagerSignupWillDoNotification;
extern NSString *const RemoteManagerSignupFinishedNotification;
extern NSString *const RemoteManagerSignupFailedNotification;

@interface RemoteManager : NSObject

+ (instancetype)sharedInstance;

- (void)doSignupWithEmail:(NSString *)email andName:(NSString *)name;

@end
