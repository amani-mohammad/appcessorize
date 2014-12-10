//
//  DoneViewController.h
//  AppcessorizeDemo
//
//  Created by Maha Ghoneim on 11/9/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneViewController : UIViewController <UITextFieldDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *casePreview;

@property (strong, nonatomic) IBOutlet UITextField *designNameTextField;

@property (retain, nonatomic) IBOutlet UIButton *discardButton;
@property (retain, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)discardButtonClicked:(id)sender;

@end
