//
//  AuthSignupChildViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "AuthSignupChildViewController.h"
#import "RemoteManager.h"
#import "EmailValidator.h"
#import "UIAlertController+Factory.h"


@interface AuthSignupChildViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *remoteActivityIndicator;

@end

@implementation AuthSignupChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

#pragma mark - IBActions

- (IBAction)signupAction:(id)sender {
    [self doSignup];
}

#pragma mark - Business

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSignupWillDo:) name:RemoteManagerSignupWillDoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSignupFinished:) name:RemoteManagerSignupFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remoteSignupFailed:) name:RemoteManagerSignupFailedNotification object:nil];
}
- (void)doSignup {
    // validate fields
    NSString *email = self.emailTextField.text;
    NSError *emailValidationError = nil;

    // form validation
    BOOL formValidationResult = [[EmailValidator sharedInstance] validateEmail:email withError:&emailValidationError];

    if (formValidationResult == YES) {
        // sending the request
        [[RemoteManager sharedInstance] doSignupWithEmail:email andName:self.nameTextField.text];
    }
    else {
        NSString *errorMessage = [self messageForError:emailValidationError];
        UIAlertController *alertController = [UIAlertController simpleAlertControllerWithTitle:@"Attention" andMessage:errorMessage];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (NSString *)messageForError:(NSError *)error {
    NSString *errorMessage = nil;

    switch(error.code) {
        case EmailValidatorErrorCodeEmptyEmail:
            errorMessage = @"Veuillez remplir un email pour vous authentifier";
            break;

        case  EmailValidatorErrorCodeNotAnEmail:
            errorMessage = @"L'email saisi n'est pas valide";
            break;

        default:
            errorMessage = @"erreur inconnue";
            break;
    }
    return errorMessage;
}

#pragma mark - UI

- (void)prepareUIForRemoteActivity:(BOOL)activated {
    self.view.userInteractionEnabled = !activated;
    self.remoteActivityIndicator.hidden = !activated;
}

#pragma mark - Notifications callback
- (void)remoteSignupWillDo:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:YES];
}

- (void)remoteSignupFinished:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:NO];
}

- (void)remoteSignupFailed:(NSNotification *)notification {
    [self prepareUIForRemoteActivity:NO];

    UIAlertController *alertController = [UIAlertController simpleAlertControllerWithTitle:@"Attention" andMessage:@"L'authetification a échoué"];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
