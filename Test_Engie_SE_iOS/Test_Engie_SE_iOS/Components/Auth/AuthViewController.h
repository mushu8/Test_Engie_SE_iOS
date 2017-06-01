//
//  AuthViewController.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuthViewControllerDelegate <NSObject>

- (void)displaySignupChildViewController;
- (void)displayVisitWebSiteChildViewController;

@end

@interface AuthViewController : UIViewController <AuthViewControllerDelegate>

@end
