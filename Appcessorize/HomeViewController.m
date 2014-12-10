//
//  AppcessorizeViewController.m
//  Appcessorize
//
//  Created by Yasser Mabrouk on 11/3/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "HomeViewController.h"
#import "DeviceSelectionViewController.h"
#import "UIViewController+NavigationBar.h"

@interface HomeViewController ()
{
    UINavigationController *navigationBarController;
    UINavigationBar *navigationBa;
}
@end


@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:HOME_VIEW] bundle:nibBundleOrNil];
    if (self) {
        self.title = TITLE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setNavigationBarButton];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
        [self set5SResources];
    }
    
    self.backgroundImage.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:WELCOME_SCREEN_BACKGROUND]];
    self.appIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"welcome_screen_app_icon"]];
    self.cameraImageView.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:WELCOME_SCREEN_CAMERA_ICON]];
    
    self.makeYourCaseButton.layer.cornerRadius = 5;
    self.makeYourCaseButton.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)makeYourCaseButtonClicked:(id)sender
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // reset case manager
        [[CaseManager getInstance] resetData];
        
        // Create tab bar
        // Add view controller to it
        
        AppcessorizeTabBarController *tabBarController = [[AppcessorizeTabBarController alloc] init];
        DeviceSelectionViewController *deviceSelection = [[DeviceSelectionViewController alloc] init];
        SelectImagesViewController *selectImagesViewController = [[SelectImagesViewController alloc] init];
        TemplateViewController *templateViewController = [[TemplateViewController alloc] init];
        TemplateManipulationViewController *templateManipulationViewController = [[TemplateManipulationViewController alloc] init];
        
        tabBarController.viewControllers = [NSArray arrayWithObjects:
                                            deviceSelection,
                                            selectImagesViewController,
                                            templateViewController,
                                            templateManipulationViewController,
                                            nil];
        
        deviceSelection.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_DEVICE_ICON]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_DEVICE_ICON]]];
        
        selectImagesViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_IMAGE_ICON]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_IMAGE_ICON]]];
        
        templateViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_TEMPLATE_ICON]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_TEMPLATE_ICON]]];
        
        templateManipulationViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_LAYOUT_ICON]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_LAYOUT_ICON]]];
        
        [self setTabBarBackButton:tabBarController];

        [self.navigationController pushViewController:tabBarController animated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - Navigation bar buttons
- (void)setNavigationBarButton {
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    
    @try {
        self.navigationController.navigationBar.hidden = NO;
        UIButton *backButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_BACK_ICON]];
        [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - Navigation bar button action
- (void)backButtonClicked
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - 5 s resources
- (void)set5SResources
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        self.backgroundImage.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"welcome_screen_background_568h"]];
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark - tabbar back button
- (void) setTabBarBackButton: (UITabBarController *) tabBar {
    @try {
        UIButton *backButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_BACK_ICON]];
        [backButton addTarget:tabBar.selectedViewController action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        tabBar.navigationItem.leftBarButtonItem = buttonItem;
    }
    @catch (NSException *exception) {
        
    }
}


@end
