//
//  ShareViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "ShareViewController.h"
#import "UIViewController+NavigationBar.h"
#import "Reachability.h"
#import "CaseManager.h"
#import "TemplatesManager.h"
#import "CheckOutViewController.h"
#import "AppcessorizeTabBarController.h"
//#import <FacebookSDK/FacebookSDK.h>


#define SHARE_BUTTON_BOARDER_WIDTH ( IS_IPHONE ? 2.0 : 4.0 )
#define SHARE_MESSAGE        @"Initial Text!"
#define SHARE_ALERT_TITLE    @"Sorry"
#define SHARE_ERROR_TITLE    @"Error"
#define SHARE_ERROR_MESSAGE  @"You can't send a %@ right now, make sure you have at least one %@ account setup."
#define SHARE_ERROR_BUTTON_TITLE   @"OK"
#define SHARE_MAIL_SUBJECT         @"My Design"
#define SHARE_MAIL_BODY            @"This is my design!"
#define INTERNET_CONNECTION_TITLE      @"No Internet Connection!"
#define INTERNET_CONNECTION_MESSAGE    @"Make sure your device can connect to the internet and try again."


@implementation ShareViewController {
    CaseManager* caseManager;
    TemplatesManager* templatesManager;
}

@synthesize facebookButton,twitterButton,instagramButton,emailButton,makeAnotherCaseButton,addToCartButton;
@synthesize caseName;
@synthesize casePreview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPHONE) {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"ShareViewController"] bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"ShareViewController_iPad"] bundle:nibBundleOrNil];
    }
    if (self) {
        self.title = @"Share";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.background.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_background_image.png"]];
    self.facebookIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_facebook_icon.png"]];
    self.twitterIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_twitter_icon.png"]];
    self.instagramIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_instgram_icon.png"]];
    self.emailIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_email_icon.png"]];
    self.storeIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"share_screen_store_icon.png"]];
    
    CALayer *facebookLayer = facebookButton.layer;
    facebookLayer.borderColor = [[UIColor whiteColor] CGColor];
    facebookLayer.cornerRadius = 4.0f;
    
    CALayer *twitterLayer = twitterButton.layer;
    twitterLayer.borderColor = [[UIColor whiteColor] CGColor];
    twitterLayer.cornerRadius = 4.0f;
    
    CALayer *instagramLayer = instagramButton.layer;
    instagramLayer.borderColor = [[UIColor whiteColor] CGColor];
    instagramLayer.cornerRadius = 4.0f;
    
    CALayer *emailLayer = emailButton.layer;
    emailLayer.borderColor = [[UIColor whiteColor] CGColor];
    emailLayer.cornerRadius = 4.0f;
    
    CALayer *makeCaseLayer = makeAnotherCaseButton.layer;
    makeCaseLayer.borderColor = [[UIColor whiteColor] CGColor];
    makeCaseLayer.cornerRadius = 4.0f;
    
    CALayer *addToCartLayer = addToCartButton.layer;
    addToCartLayer.cornerRadius = 4.0f;
    
    
    facebookLayer.borderWidth = SHARE_BUTTON_BOARDER_WIDTH;
    twitterLayer.borderWidth = SHARE_BUTTON_BOARDER_WIDTH;
    instagramLayer.borderWidth = SHARE_BUTTON_BOARDER_WIDTH;
    emailLayer.borderWidth = SHARE_BUTTON_BOARDER_WIDTH;
    makeCaseLayer.borderWidth = SHARE_BUTTON_BOARDER_WIDTH;

    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    caseName.text = [userDefaults stringForKey:KEY_DESIGN_NAME];
    
    caseManager = [CaseManager getInstance];
    caseName.text = caseManager.caseName;
    casePreview.image = caseManager.caseImageWithoutTemplate;
    
    templatesManager = [TemplatesManager getInstance];
    
    [self setNavigationBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)facebookButtonClicked:(id)sender {
    // TODO : You should check internet connection individual . Because you will inform user that you already have checked it . In reality you didn't do it any more.
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:INTERNET_CONNECTION_TITLE
                                  message:INTERNET_CONNECTION_MESSAGE
                                  delegate:nil
                                  cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            // TODO you should set general message in constant file , So you can simply change it for 3 types of sharing.
            [fbSheet setInitialText:SHARE_MESSAGE];
            
            [fbSheet addImage:[UIImage imageNamed:@"common_screen_iphone_4_image.png"]];
            
            [self presentViewController:fbSheet animated:YES completion:nil];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:SHARE_ALERT_TITLE
                                      message:[NSString stringWithFormat:SHARE_ERROR_MESSAGE,@"post",@"Facebook"]
                                      delegate:nil
                                      cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (IBAction)twitterButtonClicked:(id)sender {
    // TODO : You should check internet connection individual . Because you will inform user that you already have checked it . In reality you didn't do it any more.
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:INTERNET_CONNECTION_TITLE
                                  message:INTERNET_CONNECTION_MESSAGE
                                  delegate:nil
                                  cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            // TODO you should set geneal message in constant file , So you can simply change it for 3 types of sharing.
            [fbSheet setInitialText:SHARE_MESSAGE];
            
            [fbSheet addImage:[UIImage imageNamed:@"common_screen_iphone_4_image.png"]];
            
            [self presentViewController:fbSheet animated:YES completion:nil];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:SHARE_ALERT_TITLE
                                      message:[NSString stringWithFormat:SHARE_ERROR_MESSAGE,@"tweet",@"Twitter"]
                                      delegate:nil
                                      cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (IBAction)instagramButtonClicked:(id)sender {
    // TODO : You should check internet connection individual . Because you will inform user that you already have checked it . In reality you didn't do it any more.
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:INTERNET_CONNECTION_TITLE
                                  message:INTERNET_CONNECTION_MESSAGE
                                  delegate:nil
                                  cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        NSURL *instagramURL = [NSURL URLWithString:@"instagram://"];
        if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
        {
            NSData* imageData = UIImagePNGRepresentation([UIImage imageNamed:@"common_screen_iphone_4_image.png"]);
            
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* imagePath = [paths objectAtIndex:0];
            imagePath = [imagePath stringByAppendingFormat:@"/image.igo"];
            [imageData writeToFile:imagePath atomically:NO];
            
            NSURL* fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"file://%@",imagePath]];
            
            self.docFile = [self setupControllerWithURL:fileURL usingDelegate:self];
            self.docFile.annotation = [NSDictionary dictionaryWithObject:SHARE_MESSAGE
                                                                  forKey:@"InstagramCaption"];
            self.docFile.UTI = @"com.instagram.photo";
            
            // OPEN THE HOOK
            [self.docFile presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:SHARE_ERROR_TITLE
                                      message:@"Instagram not installed in this device!\nTo share image please install instagram."
                                      delegate:nil
                                      cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

#pragma mark -- UIDocumentInteractionController delegate

- (UIDocumentInteractionController *) setupControllerWithURL:(NSURL*)fileURL
                                               usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate
{
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    
    return interactionController;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}

- (IBAction)emailButtonClicked:(id)sender {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:INTERNET_CONNECTION_TITLE
                                  message:INTERNET_CONNECTION_MESSAGE
                                  delegate:nil
                                  cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            // TODO you should set geneal message in constant file , So you can simply change it
            NSString* emailBody = SHARE_MAIL_BODY;
            [controller setSubject:SHARE_MAIL_SUBJECT];
            [controller setMessageBody:emailBody isHTML:NO];
            
            // Attach an image to the email
            NSData *myData = UIImagePNGRepresentation([UIImage imageNamed:@"common_screen_iphone_4_image.png"]);
            [controller addAttachmentData:myData mimeType:@"image/png" fileName:@"design.png"];
            
            [self presentViewController:controller animated:YES completion:nil];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:SHARE_ERROR_TITLE
                                      message:@"Please check your mail configuration and try again!"
                                      delegate:nil
                                      cancelButtonTitle:SHARE_ERROR_BUTTON_TITLE
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)makeAnotherCaseButtonClicked:(id)sender {
    [caseManager resetData];
    [templatesManager resetData];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AppcessorizeTabBarController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (IBAction)addToCartButtonClicked:(id)sender {
    CheckOutViewController* checkOutViewController = [[CheckOutViewController alloc] init];
    [self.navigationController pushViewController:checkOutViewController animated:YES];
}


@end
