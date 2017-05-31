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

    // screen width and height.
    CGFloat screenWidth     = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight    = [UIScreen mainScreen].bounds.size.height;

    // Specify the initial position of the destination view.
    secondVCView.frame = CGRectMake(0.0, 0.0, screenWidth, screenHeight);

    UIWindow *window = [UIApplication sharedApplication ].keyWindow;
    [window insertSubview:secondVCView belowSubview:firstVCView];

    // Animate the transition.
    [UIView animateWithDuration:0.4
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
