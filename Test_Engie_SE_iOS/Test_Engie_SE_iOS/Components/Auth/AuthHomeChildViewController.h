//
//  AuthHomeChildViewController.h
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 01/06/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthViewController.h"

@interface AuthHomeChildViewController : UIViewController

@property (nonatomic) id<AuthViewControllerDelegate> authHomeDelegate;

@end
