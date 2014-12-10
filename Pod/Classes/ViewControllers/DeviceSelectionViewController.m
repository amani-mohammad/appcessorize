//
//  DeviceSelectionViewController.m
//  Appcessorize
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "DeviceSelectionViewController.h"
#import "UIViewController+NavigationBar.h"
#import "TemplatesManager.h"

@interface DeviceSelectionViewController ()

@property NSArray *devicesName;
@property NSArray *devicesIcons;
@property NSArray *devicesImages;
@property NSArray *devicesCameras;

@end


@implementation DeviceSelectionViewController
{
    InfoDialogViewController *infoDialog;
    NSMutableArray *devicesData;
    NSString *deviceIconViewNibName;
    NSInteger lastselectedSwipeIndex;
}

@synthesize popover;
@synthesize devicesName;
@synthesize devicesIcons;
@synthesize devicesImages;
@synthesize devicesCameras;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @try {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:DEVICE_SELECTION_VIEW_CONTROLLER] bundle:nibBundleOrNil];
        
        deviceIconViewNibName = DEVICE_ICON_VIEW;
        
        return self;
    }
    @catch (NSException *exception) {
      NSLog(@"Exception %@" ,[exception description]);
    }
}

- (void)viewDidLoad
{
    @try {
        [super viewDidLoad];
        
        [self.infoButton setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"SelectDevice_screen_help_icon"]] forState:UIControlStateNormal];
        
        [self setNavigationBarButton];
        
        if (IS_IPHONE) {
            self.scrollView.contentSize = CGSizeMake(320, 700);
        } else {
            self.scrollView.contentSize = CGSizeMake(768, 1500);
        }
        
        lastselectedSwipeIndex = 0;
        
        [self setSwipeViewData];
        [self configureSwipe];
        
        [self swipeView:_swipeView didSelectItemAtIndex:0];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@" ,[exception description]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)backButtonClicked
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        [[TemplatesManager getInstance] resetData];
        [[Utility sharedInstance] backButtonClicked:self.navigationController];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - Info Dialog
- (IBAction)infoButtonClicked:(id)sender
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        if (!infoDialog) {
            infoDialog = [[InfoDialogViewController alloc]
                          initWithNibName:[[Utility sharedInstance] appendBundleNameToString:INFO_DIALOG_VIEW]
                          bundle:nil];
            infoDialog.delegate = self;
            popover = [[FPPopoverController alloc] initWithViewController:infoDialog];
            popover.contentSize = CGSizeMake(4*infoDialog.view.frame.size.width/5, 2*infoDialog.view.frame.size.height/5);
            popover.border = NO;
            popover.tint = FPPopoverNoArrow;
            popover.alpha = 1;
        }
        
        UIView *targetView = ((UIButton*)sender);
        [infoDialog setInfoText:NSLocalizedString(@"Select device image from the swipe view below to use it as your case base.", nil)];
        [popover presentPopoverFromView:targetView];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - popup dialog deleget
- (void)dismissInfoButtonClicked:(id)sender
{
    [popover dismissPopoverAnimated:YES];
}


#pragma mark - Swipe view data
- (void)setSwipeViewData
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        devicesName = [NSArray arrayWithObjects:@"IPHONE 6", @"IPHONE 5", @"IPHONE 4/4s", @"IPOD TOUCH 5", nil];
        devicesIcons = [NSArray arrayWithObjects:@"common_screen_iphone_6_icon",
                        @"common_screen_iphone_5_icon",
                        @"common_screen_iphone_4_icon",
                        @"common_screen_iphone_5_icon",
                        nil];
        NSArray *devicesIconsPressed = [NSArray arrayWithObjects:@"common_screen_iphone_6_icon_pressed",
                                        @"common_screen_iphone_5_icon_pressed",
                                        @"common_screen_iphone_4_icon_pressed",
                                        @"common_screen_iphone_5_icon_pressed",
                                        nil];
        devicesImages = [NSArray arrayWithObjects:
                         @"common_screen_iphone_6_image",
                         @"common_screen_iphone_5_image",
                         @"common_screen_iphone_4_image",
                         @"common_screen_ipod_5_image", nil];
        
        devicesCameras = [NSArray arrayWithObjects:
                          @"iphone6_camera",
                          @"ipod_5_camera",
                          @"iphone4s_camera",
                          @"ipod_5_camera", nil];
        
        devicesData = [[NSMutableArray alloc] init];
        DeviceData *device;
        for (int i = 0; i < [devicesName count]; i++) {
            device = [[DeviceData alloc] init];
            [device setDeviceName:[devicesName objectAtIndex:i]];
            [device setIconName:[[Utility sharedInstance] appendBundleNameToString:[devicesIcons objectAtIndex:i]]];
            [device setImageName:[[Utility sharedInstance] appendBundleNameToString:[devicesImages objectAtIndex:i]]];
            [device setSelectedIconName:[[Utility sharedInstance] appendBundleNameToString:[devicesIconsPressed objectAtIndex:i]]];
            [device setDeviceCamera:[[Utility sharedInstance] appendBundleNameToString:[devicesCameras objectAtIndex:i]]];
            [devicesData addObject:device];
        }
        
        self.deviceImageView.image = [UIImage imageNamed:[[devicesData objectAtIndex:0] imageName]];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@" ,[exception description]);
    }
}
#pragma mark -
#pragma mark - swipe view
- (void) configureSwipe
{
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
}


#pragma mark - Swipe View
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    return [devicesData count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        if (!view) {
            view = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:deviceIconViewNibName] owner:self options:nil][0];
        }
        
        if (index == lastselectedSwipeIndex) {
            [[((DeviceIconView *)view) icon] setImage:[UIImage imageNamed:[[devicesData objectAtIndex:index] selectedIconName]]];
        } else {
            [[((DeviceIconView *)view) icon] setImage:[UIImage imageNamed:[[devicesData objectAtIndex:index] iconName]]];
        }
        
        [[((DeviceIconView *)view) deviceNameLabel] setText:[[devicesData objectAtIndex:index] deviceName]];
        
        return view;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@" ,[exception description]);
    }
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    @try {
        // change last selected icon to normal icon
        UIView *lastSelected = [_swipeView itemViewAtIndex:lastselectedSwipeIndex];
        [[((DeviceIconView *)lastSelected) icon] setImage:[UIImage imageNamed:[[devicesData objectAtIndex:lastselectedSwipeIndex] iconName]]];
        
        // change last selected icon
        lastselectedSwipeIndex = index;
        
        // highlight selected icon
        UIView *view = [_swipeView itemViewAtIndex:index];
        [[((DeviceIconView *)view) icon] setImage:[UIImage imageNamed:[[devicesData objectAtIndex:index] selectedIconName]]];
        
        // Show device select
        self.deviceImageView.image = [UIImage imageNamed:[[devicesData objectAtIndex:index] imageName]];
        
        // Set CaseManager data
        [[CaseManager getInstance] setSelectedDevice:[[devicesData objectAtIndex:index] imageName]];
        [[CaseManager getInstance] setSelectedDeviceCamera:[[devicesData objectAtIndex:index] deviceCamera]];
    }
    @catch (NSException *exception) {
         NSLog(@"Exception %@" ,[exception description]);
    }
}


@end
