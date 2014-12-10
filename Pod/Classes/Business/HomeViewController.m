//
//  AppcessorizeViewController.m
//  Appcessorize
//
//  Created by Yasser Mabrouk on 11/3/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    UINavigationController *navigationBarController;
    UINavigationBar *navigationBa;
}
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPHONE) {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"HomeViewController" ] bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"HomeViewController_iPad"] bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        self.title = @"appcessorize";
    }
    return self;
}

- (void)viewDidLoad
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    [super viewDidLoad];
    [self setNavigationBarButton];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f) {
        [self set5SResources];
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeYourCaseButtonClicked:(id)sender {
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {

        // reset case manager
        [[CaseManager getInstance] resetData];
        
        // Create tab bar
        // Added view controller to it
        
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
        [self.navigationController pushViewController:tabBarController animated:YES];
    }
    @catch (NSException *exception) {
        NSLog(@"Exceptoion %@", exception);
    }
}

#pragma mark - Navigation bar buttons
- (void) setNavigationBarButton{
     NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        self.navigationController.navigationBar.hidden = NO;
        UIButton *menuButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:@"common_screen_back_icon"]];
        [menuButton addTarget:self action:@selector(backButtopnClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = buttonItem;

    }
    @catch (NSException *exception) {
        NSLog(@"Exceptoion %@", exception);
    }
}
#pragma mark - Navigation bar button action
- (void) backButtopnClicked{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
          [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Exceptoion %@", exception);
    }
}

#pragma mark - 5 s resources
- (void) set5SResources{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        
        UIImage *backgroundImage = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"welcome_screen_background_568h"]];
//             self.backgroundImage.frame = cgrect
        self.backgroundImage.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"welcome_screen_background_568h"]];
    }
    @catch (NSException *exception) {
        
    }
}

@end
