//
//  PaymentDetailsViewController.m
//  AppcessorizeDemo
//
//  Created by Maha Ghoneim on 11/11/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "PaymentDetailsViewController.h"
#import "UIViewController+NavigationBar.h"
//#import <Parse/Parse.h>

#define EQUALIZE_STRING @"%@=%@"
#define JOIN_STRING @"&"
#define CONTENT_TYPE_VALUE @"application/json"
#define CONTENT_TYPE_HEADER @"Accept"

#define BOARDER_WIDTH ( IS_IPHONE ? 1.0 : 2.0 )
#define CORNER_RADIUS ( IS_IPHONE ? 4.0 : 8.0 )

@implementation PaymentDetailsViewController

@synthesize cartTotalPriceLabel;
@synthesize nameContainerView, emailContainerView, streetContainerView, zipContainerView, cityContainerView, unitedKingdomContainerView, cardNumberContainerView, expiryDateContainerView, cvcContainerView;
@synthesize continueButton;
@synthesize nameTextField, emailTextField, streetTextField, zipTextField, cityTextField, cardNumberTextField, expiryDateTextField, cvcTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPHONE) {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"PaymentDetailsViewController"] bundle:nibBundleOrNil];
    }else{
             self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"PaymentDetailsViewController"] bundle:nibBundleOrNil];
//        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"PaymentDetailsViewController_iPad"] bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        self.title = @"CHECKOUT";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CALayer *nameContainerViewLayer = nameContainerView.layer;
    nameContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *emailContainerViewLayer = emailContainerView.layer;
    emailContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *streetContainerViewLayer = streetContainerView.layer;
    streetContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *zipContainerViewLayer = zipContainerView.layer;
    zipContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *cityContainerViewLayer = cityContainerView.layer;
    cityContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *unitedKingdomContainerViewLayer = unitedKingdomContainerView.layer;
    unitedKingdomContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *cardNumberContainerViewLayer = cardNumberContainerView.layer;
    cardNumberContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *expiryDateContainerViewLayer = expiryDateContainerView.layer;
    expiryDateContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *cvcContainerViewLayer = cvcContainerView.layer;
    cvcContainerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *continueLayer = continueButton.layer;
    continueLayer.cornerRadius = CORNER_RADIUS;
    
    nameContainerViewLayer.borderWidth = BOARDER_WIDTH;
    emailContainerViewLayer.borderWidth = BOARDER_WIDTH;
    streetContainerViewLayer.borderWidth = BOARDER_WIDTH;
    zipContainerViewLayer.borderWidth = BOARDER_WIDTH;
    cityContainerViewLayer.borderWidth = BOARDER_WIDTH;
    unitedKingdomContainerViewLayer.borderWidth = BOARDER_WIDTH;
    cardNumberContainerViewLayer.borderWidth = BOARDER_WIDTH;
    expiryDateContainerViewLayer.borderWidth = BOARDER_WIDTH;
    cvcContainerViewLayer.borderWidth = BOARDER_WIDTH;
    
    [self setNavigationBarButton];
    
    self.cardNumberIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_card_number_icon.png"]];
    self.lockIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_lock_icon.png"]];
    self.emailIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_email_icon.png"]];
    self.calendarIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_calender_icon.png"]];
    self.userIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_user_icon.png"]];
    self.streetIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_street_icon.png"]];
    
    
    // Register our Parse Application.
//    [Parse setApplicationId:@"3BbS7dgbgMKKA7oQXnah5BCJP2OTbUJKyRi3UQhG" clientKey:@"VkAO83xkP99Rp7Bqn8R5OXV1yjYTDoUEaSWL3GEr"];
    
//    PFUser *user = [PFUser user];
//    user.username = @"my name";
//    user.password = @"my pass";
//    user.email = @"email@example.com";
//    
//    // other fields can be set if you want to save more information
//    user[@"phone"] = @"650-555-0000";
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            NSString *errorString = [error userInfo][@"error"];
//            // Show the errorString somewhere and let the user try again.
//        }
//    }];
}


- (void)saveToServer {
    // Create PFObject with recipe information
  /*
    PFObject *detail  = [PFObject objectWithClassName:@"PaymentDetails"];
    [detail setObject:nameTextField.text forKey:@"Name"];
    [detail setObject:emailTextField.text forKey:@"Email"];
    
    NSString* address = [NSString stringWithFormat:@"%@, %@, United Kingdom",streetTextField.text,cityTextField.text];
    
    [detail setObject:address forKey:@"Address"];
    [detail setObject:@"normal" forKey:@"ShippingType"];
    [detail setObject:@"29.9" forKey:@"TotalPrice"];
    
    // Recipe image
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"common_screen_iphone_4_image.png"], 1.0);
    NSString *filename = [NSString stringWithFormat:@"designImage.png"];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [detail setObject:imageFile forKey:@"imageFile"];
    
//    // Show progress
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Uploading";
//    [hud show:YES];
    
    // Upload recipe to Parse
    [detail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        [hud hide:YES];
        
        if (!error) {
            
            NSLog(@"success");
            
            // Show success message
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the recipe" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
            
            // Notify table view to reload the recipes from Parse cloud
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
            // Dismiss the controller
//            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
             NSLog(@"faliure");
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
        }
    }];
   */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AXr94RCBCq7g0mvYqI6qVaqS7UdPghK4OIKtHY2bJB4YVqffcTEoqHi0Eeju",
//                                                           PayPalEnvironmentSandbox : @"AbF8ghBzAla4bRKotLPDIjWRW0-nk4a2O9r7k6pZYYaqtdJZXhALwBBf44Ul"}];
//    
//    // Set the environment:
//    // - For live charges, use PayPalEnvironmentProduction (default).
//    // - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
//    // - For testing, use PayPalEnvironmentNoNetwork.
//    
//    // Preconnect to PayPal early
//    // should be Production in real life
//    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
}

- (IBAction)continueButtonClicked:(id)sender {
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    if ([self chekUserDataValidation]) {
        // parse the expire date
        // call payment requests
        
        
//         check network reacability
        PaypalManager *paypalManager = [[PaypalManager alloc] init];
        paypalManager.delegate = self;
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        [paypalManager paypalCheckout:@"4032035012786927" withExpireMonth:11 andExpireYear:2019 andWithCVC:@"123"];
        // TODO:
        // create aypal manager delegate
        // set delegate to self
        // in paypal manager handle response error
    }
//    [self saveToServer];
//

}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    data = [NSMutableData data];
//    
//    [data setLength:0];
//    
//     NSLog(@"didReceiveResponse: %@",response.description);
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
//    [data appendData:d];
//    
////     NSLog(@"didReceiveData: %@",d);
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"error error %@",error.description);
//    
////    [[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
////                                 message:[error localizedDescription]
////                                delegate:nil
////                       cancelButtonTitle:NSLocalizedString(@"OK", @"")
////                       otherButtonTitles:nil] autorelease] show];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"connectionDidFinishLoading: %@",responseText);
//    
//    // Do anything you want with it
//    
////    [responseText release];
//}
//
//// Handle basic authentication challenge if needed
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//   
//    NSString *username = @"username";
//    NSString *password = @"password";
//    
//    NSLog(@"didReceiveAuthenticationChallenge");
//    
//    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
//                                                             password:password
//                                                          persistence:NSURLCredentialPersistenceForSession];
//    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
//}

//#pragma mark PayPalPaymentDelegate methods
//
//- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
//    NSLog(@"PayPal Payment Success!");
////    self.resultText = [completedPayment description];
////    [self showSuccess];
//    
//    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
//    NSLog(@"PayPal Payment Canceled");
////    self.resultText = nil;
////    self.successView.hidden = YES;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//#pragma mark Proof of payment validation
//
//- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
//    // TODO: Send completedPayment.confirmation to server
//    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
//}


#pragma mark - data fields check
- (BOOL) chekUserDataValidation{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        //
        //TODO: check on the remainingFields
        if ([cardNumberTextField.text isEqualToString:@""] || [cvcTextField.text isEqualToString:@""] || [expiryDateTextField.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"PaymentData fields can't be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
        return YES;
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark - paypal manager delegate

- (void)paypalRequestFailWithError:(NSString *)message{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // Do no thing
        // stop hud if exist
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    }
    @catch (NSException *exception) {
        
    }
}

- (void)paymentSucceed{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // stop hud if exist
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Payment Succeed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        [self saveToServer];
        // call mail service
        // navigate to home screen

    }
    @catch (NSException *exception) {
        
    }
}
@end
