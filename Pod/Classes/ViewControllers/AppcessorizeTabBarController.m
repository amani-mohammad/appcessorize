//
//  AppcessorizeTabBarViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/11/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "AppcessorizeTabBarController.h"
#import "DoneViewController.h"
#import "DeviceSelectionViewController.h"
#import "SelectImagesViewController.h"
#import "ImageCropView.h"
#import "CaseManager.h"
#import "TemplatesManager.h"

@interface AppcessorizeTabBarController ()

@end


@implementation AppcessorizeTabBarController

- (void)viewDidLoad
{
    NSLog(@"%@",[NSString stringWithUTF8String:__func__]);
    
    [super viewDidLoad];
    
    [self setTabBarAppearance];
    [self setTabBarBackButton];
    [self setTabBarSaveButton];
    
    self.delegate = self;
    
//    self.title = TITLE;
    self.title = NSLocalizedString(@"Select Device", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIImage*)imageWithColor
{
    @try {
        CGFloat tabWidth = (self.tabBar.frame.size.width/4) + 1;
        CGSize imageSize;
        if (IS_IPHONE) {
            imageSize = CGSizeMake(tabWidth, self.tabBar.frame.size.height);
        } else {
            imageSize = CGSizeMake(100, self.tabBar.frame.size.height);
        }
        
        UIColor *customColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_SELECTED_BUTTON_PATTERN]]];
        
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [customColor setFill];
        CGContextFillRect(context, CGRectMake(0, 0, imageSize.width, imageSize.height));
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

#pragma mark - TabBar appearance
- (void)setTabBarAppearance
{
    NSLog(@"%@",[NSString stringWithUTF8String:__func__]);
    @try {
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
        self.tabBar.selectionIndicatorImage = [self imageWithColor];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}


#pragma mark - tabbar back button
- (void)setTabBarBackButton
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        UIButton *backButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_BACK_ICON]];
        [backButton addTarget:self action:@selector(tabBarBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)setTabBarSaveButton
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        UIButton* saveButtonCustom = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 30)];
        saveButtonCustom.backgroundColor = SAVE_BUTTON_BACKGROUND_COLOR;
        [saveButtonCustom setTitle:@"Save" forState:UIControlStateNormal];
        saveButtonCustom.titleLabel.textColor = [UIColor whiteColor];
        saveButtonCustom.titleLabel.font = [UIFont systemFontOfSize:14];
        saveButtonCustom.titleEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 10);
        saveButtonCustom.layer.cornerRadius = 5;
        saveButtonCustom.clipsToBounds = YES;
        [saveButtonCustom addTarget:self action:@selector(tabBarSaveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithCustomView:saveButtonCustom];
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}


#pragma mark - Navigation bar button action
- (void)tabBarBackButtonClicked
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        [[TemplatesManager getInstance] resetData];
        [[Utility sharedInstance] backButtonClicked:self.selectedViewController.navigationController];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

- (void)tabBarSaveButtonClicked
{
    CaseManager* caseManager = [CaseManager getInstance];
    TemplatesManager* templatesManager = [TemplatesManager getInstance];
    if ([[TemplatesManager getInstance] selectedTemplate] == nil) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Invalid case!!", nil) message:@"Template should be selected first!!" delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil] show];
    } else if ([[caseManager templateImages] count] < [[templatesManager selectedTemplate] numberOfImages]) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Invalid case!!", nil) message:@"All template images should be set!!" delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil] show];
    } else {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"SaveCaseImage" object:nil]];
        
        DoneViewController* doneViewController = [[DoneViewController alloc] init];
        [self.navigationController pushViewController:doneViewController animated:YES];
    }
}


#pragma mark - tab bar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[DeviceSelectionViewController class]]) {
        self.navigationItem.title = NSLocalizedString(@"Select Device", nil);
    } else {
        self.navigationItem.title = TITLE;
    }
    
    if (self.navigationItem.rightBarButtonItem == nil && ![viewController isKindOfClass:[ImageCropViewController class]]) {
        [self setTabBarSaveButton];
    }
}


@end
