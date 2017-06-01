//
//  UIView+AutoLayout.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)setupConstraintsForEncapsulatingInParentView:(UIView*)aParentView
{
    if ([aParentView.subviews containsObject:self] == NO) {
        // this prevents set some constraints on two views that are not
        // related in the views hierarchy (and consequently prevents crash the app… bouh!!) :(
        return;
    }

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSDictionary *views = NSDictionaryOfVariableBindings(self);

    [aParentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|"
                                             options:0
                                             metrics:nil
                                               views:views]];

    [aParentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
}

@end
