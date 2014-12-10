//
//  AppcessorizeViewController.m
//  Appcessorize
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "AppcessorizeNavigationController.h"


@interface AppcessorizeNavigationController ()

@end


@implementation AppcessorizeNavigationController

- (instancetype)init
{
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    return  [super initWithRootViewController:homeViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarAppearance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark - set navigation bar appearance
- (void)setNavigationBarAppearance
{
    NSLog(@"%@",[NSString stringWithUTF8String: __func__]);
    @try {
        NSDictionary *textAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        [[self navigationBar] setTitleTextAttributes:textAttributesDictionary];
        [[self navigationBar] setBarTintColor:NAVIGATIONBAR_BACKGROUND_COLOR];
        [[self navigationBar] setTranslucent:NO];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@" ,[exception description]);
    }
}


@end
