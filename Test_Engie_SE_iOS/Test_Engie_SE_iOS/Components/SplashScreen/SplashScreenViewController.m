//
//  SplashScreenViewController.m
//  Test_Engie_SE_iOS
//
//  Created by Alexandre Sagette on 31/05/2017.
//  Copyright © 2017 Alexandre Sagette. All rights reserved.
//

#import "SplashScreenViewController.h"
#import <NVActivityIndicatorView/NVActivityIndicatorView-umbrella.h>


@interface SplashScreenViewController ()

@property (weak, nonatomic) IBOutlet NVActivityIndicatorView *activityIndicatorView;

@end


@implementation SplashScreenViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self supplementUIInit];

    [self startSettingUpAppMetaData];
}


#pragma mark - Business

- (void)startSettingUpAppMetaData {
    // here would be downloaded some fresh app configuration metadata with a fix < 10 sec timeout duration.
    // in case of download failure, the configuration metadata would be loaded from locally
    // since it would have been shipped with the fresh/updated app, or previously doiwnloaded.

    // mocking up the configuration metadata setting up
    [self performSelector:@selector(settingUpAppMetaDataFinished) withObject:nil afterDelay:3.0];
}

- (void)settingUpAppMetaDataFinished {

    [self.activityIndicatorView stopAnimating];

    // got to the home authentification controller
    [self showHomeAuthViewController];
}

#pragma mark - Navigation

#define TO_HOME_SEGUE_IDENTIFIER @"SplashToHomeAuthSegueIdentifier"

- (void)showHomeAuthViewController {
    [self performSegueWithIdentifier:TO_HOME_SEGUE_IDENTIFIER sender:self];
}

#pragma mark - UI

- (void)supplementUIInit {
    // setup the custom activity view
    [NVActivityIndicatorView setDEFAULT_COLOR:[UIColor whiteColor]];
    [NVActivityIndicatorView setDEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME:200];

    [self.activityIndicatorView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
