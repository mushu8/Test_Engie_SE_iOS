//
//  RemoteManager.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "RemoteManager.h"
#import <AFNetworking/AFNetworking.h>
#import "EngieUser+Parser.h"

NSString *const RemoteManagerSignupWillDoNotification   = @"RemoteManagerSignupWillDoNotification";
NSString *const RemoteManagerSignupFinishedNotification = @"RemoteManagerSignupFinishedNotification";
NSString *const RemoteManagerSignupFailedNotification   = @"RemoteManagerSignupFailedNotification";


@interface RemoteManager()

@property (nonatomic, strong) NSURLConnection *signupConnection;
@property (nonatomic, strong) NSMutableData *responseData;

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

- (instancetype)init {
    if (self = [super init]) {
        _responseData = [NSMutableData new];
    }
    return self;
}

#pragma mark - Signup service

- (void)doSignupWithEmail:(NSString *)email andName:(NSString *)name {

    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupWillDoNotification object:self];

    NSString *URLString = @"http://jsonplaceholder.typicode.com/users";
    NSDictionary *parameters = @{@"user": @{@"email": email, @"name": name}};

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    request.timeoutInterval = 10;

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

    self.signupConnection = connection;

    [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupFinishedNotification object:self];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (connection == self.signupConnection) {
        //singin failure handler
        [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupFailedNotification object:self];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    if (connection == self.signupConnection) {
        // singin success handler
        // parse response and persist data

        NSError *jsonDataParsingError = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:self.responseData options:kNilOptions error:&jsonDataParsingError];

        if (jsonDataParsingError != nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupFailedNotification object:self];
        }
        else {
            NSError *jsonParsingError = nil;
            BOOL jsonParsingSuccess = [EngieUser parseObject:jsonArray error:&jsonParsingError];

            if (jsonParsingSuccess) {
                //TODO: securely persist authetication data
                [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupFinishedNotification object:self];
            }
            else {
                [[NSNotificationCenter defaultCenter] postNotificationName:RemoteManagerSignupFailedNotification object:self];
            }
        }
    }

}

@end
