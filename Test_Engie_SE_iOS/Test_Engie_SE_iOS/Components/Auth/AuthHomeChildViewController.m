//
//  AuthHomeChildViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "AuthHomeChildViewController.h"

@interface AuthHomeChildViewController ()

@end

@implementation AuthHomeChildViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - IBActions

- (IBAction)signinAction:(id)sender {
    [self.authHomeDelegate displaySigninChildViewController];
}

- (IBAction)signupAction:(id)sender {
    [self.authHomeDelegate displaySignupChildViewController];
}

@end
