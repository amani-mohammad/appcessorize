//
//  Utility.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@implementation Utility

static Utility *sharedUtility = nil;
static NSDictionary *intervalTypesDictionary;

+ (Utility*)sharedInstance
{
    @try {
        @synchronized(self) {
            if (sharedUtility == nil) {
                sharedUtility = [[Utility alloc] init];
            }
        }
        return sharedUtility;
    }
    @catch (NSException *exception) {
    }
}


#pragma mark - create button with image
- (UIButton*)createButtonWithImageName:(NSString*)imageName {
    @try {
        UIImage *buttonIcon = [UIImage imageNamed:imageName];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, buttonIcon.size.width, buttonIcon.size.height );
        [button setImage:buttonIcon forState:UIControlStateNormal];
        
        return button;
    }
    @catch (NSException *exception) {
        
    }
}

- (void)backButtonClicked:(UINavigationController*)navigationController {
    NSLog(@"%@",[NSString stringWithUTF8String: __func__]);
    @try {
        [navigationController popViewControllerAnimated:YES];
    }
    @catch (NSException *exception) {
    }
}


#pragma mark - Append budle name to resource name
- (NSString*)appendBundleNameToString:(NSString*)resourceName {
    NSLog(@"%@",[NSString stringWithUTF8String: __func__]);
    @try {
        NSString *bundleName = BUNDLE_NAME;
        return [bundleName stringByAppendingString:resourceName];
    }
    @catch (NSException *exception) {
    }
}


@end
