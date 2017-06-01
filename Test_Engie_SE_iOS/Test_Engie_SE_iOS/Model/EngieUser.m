//
//  EngieUser.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "EngieUser.h"

@implementation EngieUser

+ (instancetype)userWithName:(NSString *)name
                       email:(NSString *)email
              isAutheticated:(BOOL)authenticated {
    EngieUser *user = [EngieUser new];
    user.name               = name;
    user.email              = email;
    user.authenticated      = authenticated;

    return user;
}

@end
