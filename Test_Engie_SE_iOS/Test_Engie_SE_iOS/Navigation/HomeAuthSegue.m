//
//  HomeAuthSegue.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "HomeAuthSegue.h"
#import "AuthHomeChildViewController.h"

@implementation HomeAuthSegue

// peforming a shading transition between two child view controllers
- (void)perform {
    // Assign the source and destination views to local variables.
    UIView *firstVCView    = self.sourceViewController.view;
    UIView *secondVCView   = self.destinationViewController.view;

    secondVCView.frame = firstVCView.bounds;

//    UIWindow *window = [UIApplication sharedApplication ].keyWindow;
//    [window insertSubview:secondVCView aboveSubview:firstVCView];
//
//    firstVCView.alpha   = 0;
    secondVCView.alpha  = 0;
//    firstVCView.userInteractionEnabled  = NO;
    secondVCView.userInteractionEnabled = NO;

    // Animate the transition.
    [UIView animateWithDuration:0.4
                     animations:^{
                         secondVCView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [self.sourceViewController presentViewController:self.destinationViewController
                                                                 animated:NO
                                                               completion:^{
                                                                   secondVCView.userInteractionEnabled = YES;
                                                               }];
                     }];
}

@end
