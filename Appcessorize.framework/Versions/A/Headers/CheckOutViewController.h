//
//  CheckOutViewController.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UILabel *standardShippingPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *loremIpsumShippingPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *expressipsumShippingPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemTotalPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *shippingPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *checkoutButton;
@property (strong, nonatomic) IBOutlet UIButton *paypalButton;

@property (weak, nonatomic) IBOutlet UIImageView *maestroIcon;
@property (weak, nonatomic) IBOutlet UIImageView *masterIcon;
@property (weak, nonatomic) IBOutlet UIImageView *visaElectronIcon;
@property (weak, nonatomic) IBOutlet UIImageView *visaIcon;
@property (weak, nonatomic) IBOutlet UIImageView *paypalIcon;


- (IBAction)checkoutButtonClicked:(id)sender;
- (IBAction)paypalButtonClicked:(id)sender;

@end
