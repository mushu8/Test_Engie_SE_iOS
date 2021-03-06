//
//  EmailValidator.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "EmailValidator.h"

NSString  *const EmailValidatorDomain = @"EmailValidator";

@implementation EmailValidator

#pragma mark - Singleton pattern

static EmailValidator *_sharedInstance = nil;

+ (instancetype)sharedInstance {
    if (_sharedInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    return _sharedInstance;
}

- (BOOL)validateEmail:(NSString *)checkString withError:(NSError **)error {

    if (checkString.length == 0) {
        *error = [NSError errorWithDomain:EmailValidatorDomain code:EmailValidatorErrorCodeEmptyEmail userInfo:nil];
        return NO;
    }

    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    BOOL result = [emailTest evaluateWithObject:checkString];
    if (result == NO) {
        *error = [NSError errorWithDomain:EmailValidatorDomain code:EmailValidatorErrorCodeNotAnEmail userInfo:nil];
    }

    return result;
}

@end
