//
//  CheckOutViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "CheckOutViewController.h"
#import "UIViewController+NavigationBar.h"
#import "PaymentDetailsViewController.h"
#import "Constant.h"

@implementation CheckOutViewController

@synthesize containerView, standardShippingPriceLabel, loremIpsumShippingPriceLabel, expressipsumShippingPriceLabel;
@synthesize itemTotalPriceLabel, shippingPriceLabel, totalPriceLabel;
@synthesize checkoutButton, paypalButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPHONE) {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"CheckOutViewController"] bundle:nibBundleOrNil];
    } else {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"CheckOutViewController_iPad"] bundle:nibBundleOrNil];
    }
    if (self) {
        self.title = @"CHECKOUT";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CALayer *containerViewLayer = containerView.layer;
    containerViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CALayer *checkoutLayer = checkoutButton.layer;
    CALayer *paypalLayer = paypalButton.layer;
    
    if (IS_IPHONE) {
        containerViewLayer.borderWidth = 2.0f;
        containerViewLayer.cornerRadius = 4.0f;
        checkoutLayer.cornerRadius = 4.0f;
        paypalLayer.cornerRadius = 4.0f;
    }else{
        containerViewLayer.borderWidth = 4.0f;
        containerViewLayer.cornerRadius = 8.0f;
        checkoutLayer.cornerRadius = 8.0f;
        paypalLayer.cornerRadius = 8.0f;
    }
    
    [self setNavigationBarButton];
    
    self.maestroIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_maestro_card_icon.png"]];
    self.masterIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_master_card_icon.png"]];
    self.visaElectronIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_visa_elctron_card_icon.png"]];
    self.visaIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_visa_card_icon.png"]];
    self.paypalIcon.image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"check_out_screen_pay_pal_card_icon.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)checkoutButtonClicked:(id)sender
{
    PaymentDetailsViewController* paymentViewController = [[PaymentDetailsViewController alloc] init];
    //    DoneViewController* doneViewController = [[DoneViewController alloc] init];
    //    ShareViewController* doneViewController = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

- (IBAction)paypalButtonClicked:(id)sender
{
    
}


@end
