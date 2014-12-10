//
//  UIViewController+NavigationBar.m
//  AppcessorizeDemo
//
//  Created by Maha Ghoneim on 11/11/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "UIViewController+NavigationBar.h"

@implementation UIViewController (NavigationBar)

#pragma mark - Navigation bar buttons

- (void) setNavigationBarButton {
    @try {
        self.navigationController.navigationBar.hidden = NO;
        UIButton *menuButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_BACK_ICON]];
        [menuButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

- (void)backButtonClicked {
    @try {
        [self.navigationController popViewControllerAnimated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

@end
