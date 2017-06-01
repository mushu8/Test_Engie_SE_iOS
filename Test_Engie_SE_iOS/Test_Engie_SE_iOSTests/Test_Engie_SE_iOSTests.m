//
//  Test_Engie_SE_iOSTests.m
//  Test_Engie_SE_iOSTests
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EmailValidator.h"

@interface Test_Engie_SE_iOSTests : XCTestCase

@end

@implementation Test_Engie_SE_iOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEmailValidatorWithCorrectEmail {
    EmailValidator *emailValidator = [EmailValidator sharedInstance];
    NSString *emailToValidate = @"bob@gogole.fr";

    XCTAssertTrue([emailValidator validateEmail:emailToValidate], @"cannot validate a correct email");
}

- (void)testEmailValidatorWithInCorrectEmail {
    EmailValidator *emailValidator = [EmailValidator sharedInstance];
    NSString *emailToValidate = @"bobgogole.fr";

    XCTAssertFalse([emailValidator validateEmail:emailToValidate], @"email validator validates an incorrect email");
}

@end
