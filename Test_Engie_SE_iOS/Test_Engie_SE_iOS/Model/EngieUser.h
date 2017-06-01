//
//  EngieUser.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EngieUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, getter=isAutheticated) BOOL authenticated;

+ (instancetype)userWithName:(NSString *)name
                       email:(NSString *)email
              isAutheticated:(BOOL)authenticated;

@end
