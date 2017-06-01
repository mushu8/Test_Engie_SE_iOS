//
//  EmailValidator.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailValidator : NSObject

+ (instancetype)sharedInstance;

- (BOOL)validateEmail:(NSString *)checkString;

@end
