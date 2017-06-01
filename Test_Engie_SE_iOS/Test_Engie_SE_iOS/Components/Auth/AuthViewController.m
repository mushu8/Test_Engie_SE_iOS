//
//  AuthViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//


#import "AuthViewController.h"
#import "AuthHomeChildViewController.h"
#import "AuthSigninChildViewController.h"
#import "UIView+AutoLayout.h"



@interface AuthViewController ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
// child view controllers
@property (strong, nonatomic) AuthHomeChildViewController *authHomeChildViewController;
@property (strong, nonatomic) AuthSigninChildViewController *authSigninChildViewController;

@end

@implementation AuthViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self addChildViewController:self.authHomeChildViewController];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self showHomeAuthViewController];
}

#pragma mark - IBAction

- (IBAction)contactAgentAction:(id)sender {
    [self makeCallToAgent];
}

#pragma mark - Business

- (void)makeCallToAgent {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"HomeAuthVC.contactAgent.tel", nil)]];
}

#pragma mark - Navigation

- (void)showHomeAuthViewController {
    // as this view had to be presented only one time, we check this
    if (self.authHomeChildViewController.view.superview == nil) {
        self.authHomeChildViewController.authHomeDelegate = self;
        [self displayHomeAuthController:self.authHomeChildViewController];
    }
}

- (void)displayHomeAuthController: (UIViewController*)contentViewController {

    // preparing UI
    contentViewController.view.alpha = 0;
    contentViewController.view.userInteractionEnabled = NO;

    // setting up UI
    [contentViewController willMoveToParentViewController:self];
    [self addChildViewController:contentViewController];
    contentViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:contentViewController.view];
    [contentViewController.view setupConstraintsForEncapsulatingInParentView:self.contentView];

    // transitioning UI
    [UIView animateWithDuration:0.3
                     animations:^{
                         contentViewController.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             contentViewController.view.userInteractionEnabled = YES;
                         }
                     }];

    [contentViewController didMoveToParentViewController:self];
}

- (void)transitionToSigninChildViewController {

    UIViewController *oldVC = self.authHomeChildViewController;
    UIViewController *newVC = self.signinAuthChildViewController;

    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];

    newVC.view.frame = oldVC.view.bounds;

    oldVC.view.alpha = 0;
    oldVC.view.userInteractionEnabled = NO;
    newVC.view.alpha = 0;
    newVC.view.userInteractionEnabled = NO;

    [self transitionFromViewController:oldVC toViewController:newVC
                              duration: 0.25 options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.alpha = 1;
                            }
                            completion:^(BOOL finished) {
                                [oldVC removeFromParentViewController];
                                [newVC.view setupConstraintsForEncapsulatingInParentView:self.contentView];
                                [newVC didMoveToParentViewController:self];
                                newVC.view.userInteractionEnabled = YES;
                            }];
}

//- (void)transitionToSignupChildViewController {
//
//    UIViewController *oldVC = self.homeAuthChildViewController;
//    UIViewController *newVC = self.signinAuthChildViewController;
//
//    [oldVC willMoveToParentViewController:nil];
//    [self addChildViewController:newVC];
//
//    newVC.view.frame = oldVC.view.bounds;
//
//    oldVC.view.alpha = 0;
//    oldVC.view.userInteractionEnabled = NO;
//    newVC.view.alpha = 0;
//    newVC.view.userInteractionEnabled = NO;
//
//    [self transitionFromViewController:oldVC toViewController:newVC
//                              duration: 0.25 options:0
//                            animations:^{
//                                // Animate the views to their final positions.
//                                newVC.view.alpha = 1;
//                            }
//                            completion:^(BOOL finished) {
//                                [oldVC removeFromParentViewController];
//                                [newVC didMoveToParentViewController:self];
//                                newVC.view.userInteractionEnabled = YES;
//                            }];
//}

#pragma mark - Lazy loaders

- (AuthHomeChildViewController *)authHomeChildViewController {
    if (_authHomeChildViewController == nil) {
        _authHomeChildViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthHomeChildViewController"];
    }
    return _authHomeChildViewController;
}
- (AuthSigninChildViewController *)signinAuthChildViewController {
    if (_authSigninChildViewController == nil) {
        _authSigninChildViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthSigninChildViewController"];
    }
    return _authSigninChildViewController;
}

#pragma mark - AuthViewControllerDelegate

- (void)displaySigninChildViewController {
    [self transitionToSigninChildViewController];
}

- (void)displaySignupChildViewController {
    
}

@end
