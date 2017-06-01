//
//  AuthSigninViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "AuthSigninChildViewController.h"
#import "RemoteManager.h"
#import "EmailValidator.h"
#import "UIAlertController+Factory.h"


@interface AuthSigninChildViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *remoteActivityIndicator;

@end

@implementation AuthSigninChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

#pragma mark - IBActions

- (IBAction)signinAction:(id)sender {
    [self doSignin];
}

#pragma mark - Business

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSigninWillDo:) name:RemoteManagerSigninWillDoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSigninFinished:) name:RemoteManagerSigninFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSigninFailed:) name:RemoteManagerSigninFailedNotification object:nil];
}
- (void)doSignin {
    // validate fields
    NSString *email = self.emailTextField.text;

    if ([[EmailValidator sharedInstance] validateEmail:email]) {
        [[RemoteManager sharedInstance] doSigninWithEmail:email andName:self.nameTextField.text];
    }
    else {
        UIAlertController *alertController = [UIAlertController simpleAlertControllerWithTitle:@"Attention" andMessage:@"L'email saisi n'est pas valide"];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - UI

- (void)prepareUIForRemoteActivity:(BOOL)activated {
    self.view.userInteractionEnabled = !activated;
    self.remoteActivityIndicator.hidden = !activated;
}

#pragma mark - Notifications callback
- (void)remoteSigninWillDo:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:YES];
}

- (void)remoteSigninFinished:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:NO];
}

- (void)remoteSigninFailed:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:NO];

    UIAlertController *alertController = [UIAlertController simpleAlertControllerWithTitle:@"Attention" andMessage:@"L'authetification a échoué"];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
