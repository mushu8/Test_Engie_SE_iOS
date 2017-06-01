//
//  RemoteManager.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const RemoteManagerSigninWillDoNotification;
extern NSString *const RemoteManagerSigninFinishedNotification;
extern NSString *const RemoteManagerSigninFailedNotification;

@interface RemoteManager : NSObject

+ (instancetype)sharedInstance;

- (void)doSigninWithEmail:(NSString *)email;

@end
