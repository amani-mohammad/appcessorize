//
//  ShareViewController.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface ShareViewController : UIViewController <MFMailComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;

@property (strong, nonatomic) IBOutlet UILabel *caseName;
@property (retain, nonatomic) IBOutlet UIImageView *casePreview;

@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIImageView *facebookIcon;

@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIImageView *twitterIcon;

@property (strong, nonatomic) IBOutlet UIButton *instagramButton;
@property (weak, nonatomic) IBOutlet UIImageView *instagramIcon;

@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIImageView *emailIcon;

@property (strong, nonatomic) IBOutlet UIButton *makeAnotherCaseButton;

@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;

@property(nonatomic,retain) UIDocumentInteractionController *docFile;

- (IBAction)facebookButtonClicked:(id)sender;
- (IBAction)twitterButtonClicked:(id)sender;
- (IBAction)instagramButtonClicked:(id)sender;
- (IBAction)emailButtonClicked:(id)sender;
- (IBAction)makeAnotherCaseButtonClicked:(id)sender;
- (IBAction)addToCartButtonClicked:(id)sender;

@end
