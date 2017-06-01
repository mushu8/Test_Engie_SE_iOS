//
//  EmailValidator.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const EmailValidatorDomain;

typedef NS_ENUM(NSInteger, EmailValidatorErrorCode) {
    EmailValidatorErrorCodeEmptyEmail = 0,
    EmailValidatorErrorCodeNotAnEmail = 1
};

@interface EmailValidator : NSObject

+ (instancetype)sharedInstance;

- (BOOL)validateEmail:(NSString *)checkString withError:(NSError **)error;

@end
