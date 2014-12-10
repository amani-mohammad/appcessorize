//
//  Utility.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (Utility*)sharedInstance;

- (UIButton*)createButtonWithImageName:(NSString*)imageName;
- (NSString*)appendBundleNameToString:(NSString*)resourceName;

- (void)backButtonClicked:(UINavigationController*)navigationController;

@end
