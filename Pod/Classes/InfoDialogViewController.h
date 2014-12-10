//
//  InfoViewController.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/5/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Utility.h"

@protocol PopupDelegate;

@interface InfoDialogViewController : UIViewController

- (IBAction)closeButtonClicked:(id)sender;
- (void)setInfoText:(NSString*) info;

@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
@property (strong, nonatomic) id <PopupDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@end

@protocol PopupDelegate <NSObject>
- (void)dismissInfoButtonClicked:(id)sender;
@end
