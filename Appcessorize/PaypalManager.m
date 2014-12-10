//
//  PaypalManager.m
//  test
//
//  Created by Shimaa Essam on 12/2/14.
//  Copyright (c) 2014 Shimaa Essam. All rights reserved.
//

#import "PaypalManager.h"


#define PAYPAL_CLIENT_ID @"AdptXRCWl0ln7ePDMis1AWjwfIogMVn_4T6Z6SAMgwYn9Ynzk6O_fLGUi5f0"
#define PAYPAL_CLIENT_SECRET @"EDAfOxC-yxsdjZ2O2jW7G7xa1UQLCLfFcQm1wVFthaDzYbUgE7ECmPqUW3SR"
#define PAYPAL_BASE_URL @"https://api.sandbox.paypal.com"
#define OAuth_request_url @"/v1/oauth2/token"
#define Create_payment_url @"/v1/payments/payment"
@implementation PaypalManager
{
    NSString *creditCard;
    NSString *cardCvc;
    NSInteger expireMonth;
    NSInteger expireYear;
    NSString *totalPaid;
    NSString *currency;
}

- (void) paypalCheckout:(NSString *) credit withExpireMonth:(NSInteger )month andExpireYear:(NSInteger)year  andWithCVC:(NSString *) cvc{
    NSLog(@"%@",[NSString stringWithUTF8String:__func__]);

//    creditCard = credit;
//    cardCvc = cvc;
//    expireMonth = month;
//    expireYear = year;
//    totalPaid = @"7.47";
//    currency = @"USD";
    
    creditCard = @"4032035012786927";
    cardCvc = @"874";
    expireMonth = 11;
    expireYear = 2019;
    totalPaid = @"7.47";
    currency = @"USD";
    
    
    [self requestAccessToken];
}
- (void) requestAccessToken{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        NSDictionary *parameters = @{@"grant_type": @"client_credentials",
                                     @"response_type":@"token",
                                     //                                     @"redirect_uri" :@"REDIRECT_URI"
                                     
                                     //                                 ,
                                     //                                 @"client_id" : @"AdptXRCWl0ln7ePDMis1AWjwfIogMVn_4T6Z6SAMgwYn9Ynzk6O_fLGUi5f0",
                                     //                                 @"client_secret" : @"EDAfOxCyxsdjZ2O2jW7G7xa1UQLCLfFcQm1wVFthaDzYbUgE7ECmPqUW3SR"
                                     
                                     };
        
        NSMutableString *parameterString = [NSMutableString string];
        for (NSString *key in [parameters allKeys]) {
            if ([parameterString length]) {
                [parameterString appendString:@"&"];
            }
            [parameterString appendFormat:@"%@=%@", key, parameters[key]];
        }
        
        NSString *string = [PAYPAL_CLIENT_ID stringByAppendingFormat:@":%@", PAYPAL_CLIENT_SECRET];
        NSData * credential = [string  dataUsingEncoding:NSUTF8StringEncoding];
        NSString *credentialString = [credential base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",PAYPAL_BASE_URL, OAuth_request_url];
        
        NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request1 setHTTPMethod:@"POST"];
        [request1 setValue:[NSString stringWithFormat:@"Basic %@",credentialString] forHTTPHeaderField:@"Authorization"];
        
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request1 setValue:@"en_US" forHTTPHeaderField:@"Accept-Language"];
        [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request1 setHTTPBody:[parameterString dataUsingEncoding:NSUTF8StringEncoding]];
        NSError *error;
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response error:&error];
        
        NSString *accessToken;
        NSString *tokenType;
        
        NSLog(@"Access token request data %@", data);
        NSLog(@"Access token request error %@", error);

        if (!error) {
            if ([data length]) {
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                tokenType = [jsonResponse valueForKey:@"token_type"];
                accessToken = [jsonResponse valueForKey:@"access_token"];
                NSLog(@"%@", jsonResponse);
                if (accessToken) {
                    [self requestPaymentCredit:accessToken];
                    // call payment request
                }else{
                    [_delegate paypalRequestFailWithError:@"Can't complete payment process, retry again"];
                }
                
            }
        } else {
            NSLog(@"%@", error.description);
            if ([self.delegate respondsToSelector:@selector(paypalRequestFailWithError:)]) {
                [_delegate paypalRequestFailWithError:error.localizedDescription];
            }
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
}
#pragma mark - call credit payment request
- (void) requestPaymentCredit:(NSString *) accessToken{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        
        NSDictionary *creditCardDictionary = @{
                                               //                                               @"number": @"4032035012786927",
                                               @"number": creditCard,
                                               @"type": @"visa",
                                               //                                               @"expire_month": @(12),
                                               //                                               @"expire_year": @(2010),
//                                               @"cvv2": @"8888",
                                               @"expire_month": @((int)expireMonth),
                                               @"expire_year": @((int)expireYear),
                                               @"cvv2": cardCvc
                                               
                                               //                                               @"first_name": @"Betsy",
                                               //                                               @"last_name": @"Buyer"
                                               };
        
        
        NSDictionary *fundingInstrumentDictionary = @{
                                                      @"credit_card": creditCardDictionary
                                                      };
        
        NSDictionary *payerValueDictionary = @{@"payment_method": @"credit_card",
                                               @"funding_instruments": [NSArray arrayWithObjects:fundingInstrumentDictionary, nil]
                                               };
        
        NSDictionary *amountValuedictionary3 = @{
                                                 @"total" : totalPaid,
                                                 @"currency" : currency
                                                 };
        
        NSDictionary *transactionDictionary = @{ @"amount" : amountValuedictionary3,
                                                 @"description": @"This is the payment transaction description."
                                                 };
        
        NSDictionary *parameters = @{@"intent": @"sale",
                                     @"payer": payerValueDictionary,
                                     @"transactions" : [NSArray arrayWithObjects:transactionDictionary, nil ]
                                     };
        
        NSLog(@"Parameters %@", parameters);
        NSMutableString *parameterString = [NSMutableString string];
        for (NSString *key in [parameters allKeys]) {
            if ([parameterString length]) {
                [parameterString appendString:@"&"];
            }
            [parameterString appendFormat:@"%@=%@", key, parameters[key]];
        }
        
        NSString *urlString = [NSString stringWithFormat:@"%@%@",PAYPAL_BASE_URL, Create_payment_url];
        
        NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request1 setHTTPMethod:@"POST"];
        [request1 setValue:[NSString stringWithFormat:@"Bearer %@",accessToken] forHTTPHeaderField:@"Authorization"];
        
        
        [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSError *jsonError;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&jsonError];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", jsonError);
        } else {
            [request1 setHTTPBody:jsonData];
            //            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        
        NSError *error;
        NSURLResponse *response;
        NSData *data = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response error:&error];
        
        if (!error) {
            if ([data length]) {
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@" second call%@", jsonResponse);
                [self checkPaymentApprovalFromJsonResponse:jsonResponse];
                
                // TODO: Here check on state
                
            }
        } else {
            NSLog(@"second call error%@", error);
            if ([self.delegate respondsToSelector:@selector(paypalRequestFailWithError:)]) {
                [_delegate paypalRequestFailWithError:error.localizedDescription];
            }
            
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
}

#pragma void - Check payment approval
- (void) checkPaymentApprovalFromJsonResponse:(NSDictionary *) jsonResponse{
    NSLog(@"%@",[NSString stringWithUTF8String:__func__]);
    @try {
        // if has status field
        // if state value = approved
        // call succeed delegate
        // else state != approved
        // call failure
        if ([jsonResponse valueForKey:@"state"]) {
            NSString *statusValue = [jsonResponse valueForKey:@"state"];
            if ([statusValue isEqualToString:@"approved"]) {
                [_delegate paymentSucceed];
            }else{
                [_delegate paypalRequestFailWithError:@"Paymanet didn't approved"];
            }
        }else{
            
            NSString *errorMessage;
            // if no state
            // validation error respons
            // append message with details value
            if ([jsonResponse valueForKey:@"name"]) {
                errorMessage = [NSString stringWithFormat:@"%@ /n",[jsonResponse valueForKey:@"name"]];
                //                if ([jsonResponse valueForKey:@"message"]) {
                //                   errorMessage =  [errorMessage stringByAppendingString:]
                //                }
                
                if ([jsonResponse valueForKey:@"details"]) {
                    NSDictionary *detailDictionary = [jsonResponse valueForKey:@"details"];
                    if ([detailDictionary valueForKey:@"issue"]) {
                        errorMessage =  [errorMessage stringByAppendingString:[detailDictionary valueForKey:@"issue"]];
                    }
                }
            }
            [_delegate paypalRequestFailWithError:errorMessage];
        }
    }
    @catch (NSException *exception) {
        
    }
}
@end
