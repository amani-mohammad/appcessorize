//
//  TemplateViewController.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "SwipeView.h"
#import "InfoDialogViewController.h"
#import "FPPopoverController.h"


@interface TemplateViewController : UIViewController <SwipeViewDataSource, SwipeViewDelegate, PopupDelegate>

@property (strong, nonatomic) IBOutlet UIView *previewTemplate;
@property (strong, nonatomic) IBOutlet SwipeView *swipeView;
@property (strong, nonatomic) IBOutlet UIImageView *selectedDeviceImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) NSArray *templates;
@property (strong, nonatomic) NSMutableArray *images;

- (IBAction)infoButtonClicked:(id)sender;

@end
