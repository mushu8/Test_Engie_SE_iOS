//
//  AuthViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//


#import "AuthViewController.h"
#import "AuthHomeChildViewController.h"
#import "AuthSignupChildViewController.h"
#import "UIView+AutoLayout.h"



@interface AuthViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;

// child view controllers
@property (strong, nonatomic) UIViewController *currentDisplayedChildViewController;
@property (strong, nonatomic) AuthHomeChildViewController *authHomeChildViewController;
@property (strong, nonatomic) AuthSignupChildViewController *authSignupChildViewController;

@end

@implementation AuthViewController

#pragma mark - View life cycle

static void * AuthViewControllerContext = &AuthViewControllerContext;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(currentDisplayedChildViewController)) options:NSKeyValueObservingOptionInitial context:AuthViewControllerContext];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self showHomeAuthViewController];
}

#pragma mark - IBAction

- (IBAction)contactAgentAction:(id)sender {
    [self makeCallToAgent];
}

- (IBAction)backAction:(id)sender {
    [self transitionToAuthHomeChildViewController];
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

// setting up the authHomeViewController as a child view controller
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
                             self.currentDisplayedChildViewController = self.authHomeChildViewController;
                             contentViewController.view.userInteractionEnabled = YES;
                         }
                     }];

    [contentViewController didMoveToParentViewController:self];
}

// child view controller transition to the authHomeViewController
- (void)transitionToAuthHomeChildViewController {
    UIViewController *oldVC = self.currentDisplayedChildViewController;
    UIViewController *newVC = self.authHomeChildViewController;

    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];

    newVC.view.frame = self.contentView.bounds;


    oldVC.view.userInteractionEnabled = NO;
    newVC.view.alpha = 0;
    newVC.view.userInteractionEnabled = NO;

    [self transitionFromViewController:oldVC toViewController:newVC
                              duration: 0.3 options:0
                            animations:^{
                                oldVC.view.alpha = 0;
                                newVC.view.alpha = 1;
                            }
                            completion:^(BOOL finished) {
                                [oldVC removeFromParentViewController];
                                [newVC.view setupConstraintsForEncapsulatingInParentView:self.contentView];
                                [newVC didMoveToParentViewController:self];

                                self.currentDisplayedChildViewController = newVC;
                                newVC.view.userInteractionEnabled = YES;
                            }];
}

// child view controller transition to the authSignupViewController
- (void)transitionToSignupChildViewController {

    UIViewController *oldVC = self.authHomeChildViewController;
    UIViewController *newVC = self.authSignupChildViewController;

    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];

    newVC.view.frame = self.contentView.bounds;

    oldVC.view.userInteractionEnabled = NO;
    newVC.view.alpha = 0;
    newVC.view.userInteractionEnabled = NO;

    [self transitionFromViewController:oldVC toViewController:newVC
                              duration: 0.3 options:0
                            animations:^{
                                oldVC.view.alpha = 0;
                                newVC.view.alpha = 1;
                            }
                            completion:^(BOOL finished) {
                                [oldVC removeFromParentViewController];
                                [newVC.view setupConstraintsForEncapsulatingInParentView:self.contentView];
                                [newVC didMoveToParentViewController:self];

                                self.currentDisplayedChildViewController = newVC;
                                newVC.view.userInteractionEnabled = YES;
                            }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == AuthViewControllerContext &&
        [keyPath isEqualToString:NSStringFromSelector(@selector(currentDisplayedChildViewController))])
    {
        self.backButton.hidden  = (self.currentDisplayedChildViewController == self.authHomeChildViewController || self.currentDisplayedChildViewController == nil);
    }
}

#pragma mark - Lazy loaders

- (AuthHomeChildViewController *)authHomeChildViewController {
    if (_authHomeChildViewController == nil) {
        _authHomeChildViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthHomeChildViewController"];
    }
    return _authHomeChildViewController;
}
- (AuthSignupChildViewController *)authSignupChildViewController {
    if (_authSignupChildViewController == nil) {
        _authSignupChildViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthSignupChildViewController"];
    }
    return _authSignupChildViewController;
}

#pragma mark - AuthViewControllerDelegate

- (void)displaySignupChildViewController {
    [self transitionToSignupChildViewController];
}


#define INFO_PLIST_ENGIE_URL @"INFO_PLIST_ENGIE_URL"

- (void)displayVisitWebSiteChildViewController {
    NSString *urlString = [[NSBundle mainBundle] objectForInfoDictionaryKey:INFO_PLIST_ENGIE_URL];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
