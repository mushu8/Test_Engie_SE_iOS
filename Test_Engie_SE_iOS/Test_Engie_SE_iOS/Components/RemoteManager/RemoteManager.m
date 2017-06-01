//
//  RemoteManager.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "RemoteManager.h"
#import <AFNetworking/AFNetworking.h>

NSString *const RemoteManagerSigninWillDoNotification   = @"RemoteManagerSigninWillDoNotification";
NSString *const RemoteManagerSigninFinishedNotification = @"RemoteManagerSigninFinishedNotification";
NSString *const RemoteManagerSigninFailedNotification   = @"RemoteManagerSigninFailedNotification";

@interface RemoteManager()
@property (nonatomic, strong) NSURLConnection *signinConnection;
@end


@implementation RemoteManager

#pragma mark - Singleton pattern

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

- (void)doSigninWithEmail:(NSString *)email andName:(NSString *)name {

    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninWillDoNotification object:self];

    NSString *URLString = @"http://jsonplaceholder.typicode.com/users";
    NSDictionary *parameters = @{@"user": @{@"email": email, @"name": name}};

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    request.timeoutInterval = 10;

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    self.signinConnection = connection;

    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninFinishedNotification object:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection == self.signinConnection) {
        //singin failure handler
        [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninFailedNotification object:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    if (connection == self.signinConnection) {
        //singin success handler

        //TODO: parse response and persist data

        [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSigninFinishedNotification object:self];
    }

}

@end
