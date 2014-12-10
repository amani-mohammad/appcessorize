//
//  DeviceSelectionViewController.h
//  Appcessorize
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationBundle.h"
#import "InfoDialogViewController.h"
#import "FPPopoverController.h"
#import "SwipeView.h"
#import "DeviceData.h"
#import "DeviceIconView.h"
#import "CaseManager.h"

@interface DeviceSelectionViewController : UIViewController <PopupDelegate, SwipeViewDataSource, SwipeViewDelegate, SwipeViewDataSource>


@property (strong, nonatomic) FPPopoverController *popover;

@property (strong, nonatomic) IBOutlet SwipeView *swipeView;

@property (strong, nonatomic) IBOutlet UIImageView *deviceIcon;
@property (strong, nonatomic) IBOutlet UILabel *deviceName;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

- (IBAction)infoButtonClicked:(id)sender;

@end
