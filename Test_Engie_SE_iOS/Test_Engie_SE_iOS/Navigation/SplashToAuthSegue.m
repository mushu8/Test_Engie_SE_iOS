//
//  SplashToAuthSegue.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "SplashToAuthSegue.h"

@implementation SplashToAuthSegue

// peforming a shading transition
- (void)perform {
    // Assign the source and destination views to local variables.
    UIView *firstVCView    = self.sourceViewController.view;
    UIView *secondVCView   = self.destinationViewController.view;

    // Specify the initial position of the destination view.
    secondVCView.frame = firstVCView.bounds;

    UIWindow *window = [UIApplication sharedApplication ].keyWindow;
    [window insertSubview:secondVCView belowSubview:firstVCView];

    // Animate the transition.
    [UIView animateWithDuration:0.3
                     animations:^{
                         firstVCView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.sourceViewController presentViewController:self.destinationViewController
                                                                 animated:NO
                                                               completion:nil];
                     }];
}

@end
