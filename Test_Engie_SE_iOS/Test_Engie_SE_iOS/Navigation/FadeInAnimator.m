//
//  FadeInAnimator.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FadeInAnimator.h"

@implementation FadeInAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 40;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toViewController.view.frame = fromViewController.view.bounds;
    [containerView addSubview:toViewController.view];
    toViewController.view.alpha = 0.0;

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // Animate the transition.
    [UIView animateWithDuration:duration
                     animations:^{
                         toViewController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         BOOL cancelled = [transitionContext transitionWasCancelled];
                         [transitionContext completeTransition:cancelled];
                     }];
}

@end
