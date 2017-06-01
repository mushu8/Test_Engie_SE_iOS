//
//  RemoteManager.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "RemoteManager.h"


NSString *const RemoteManagerSigninWillDoNotification   = @"RemoteManagerSigninWillDoNotification";
NSString *const RemoteManagerSigninFinishedNotification = @"RemoteManagerSigninFinishedNotification";
NSString *const RemoteManagerSigninFailedNotification   = @"RemoteManagerSigninFailedNotification";

@implementation RemoteManager

#pragma mark singleton

static RemoteManager *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    if (_sharedInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    return _sharedInstance;
}

#pragma mark - Signin service

- (void)doSigninWithEmail:(NSString *)email {

    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninWillDoNotification object:self];


    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninFinishedNotification object:self];
}

@end
