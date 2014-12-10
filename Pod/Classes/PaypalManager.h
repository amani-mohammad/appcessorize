//
//  PaypalManager.h
//  test
//
//  Created by Shimaa Essam on 12/2/14.
//  Copyright (c) 2014 Shimaa Essam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PaypalManagerDelegate;

@interface PaypalManager : NSObject

@property (nonatomic, strong) id<PaypalManagerDelegate> delegate;
- (void) paypalCheckout:(NSString *) credit withExpireMonth:(NSInteger) month andExpireYear:(NSInteger) year  andWithCVC:(NSString *) cvc;

@end

@protocol PaypalManagerDelegate <NSObject>

@required
- (void) paymentSucceed;
- (void) paypalRequestFailWithError:(NSString *)message;

@end