//
//  ApplicationBundle.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/5/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "ApplicationBundle.h"

@implementation ApplicationBundle

static dispatch_once_t onceToken;
static NSBundle *resourcesBundle = nil;

+ (NSBundle*)resourcesBundle
{
    dispatch_once(&onceToken, ^{
        resourcesBundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"Appcessorize" withExtension:@"bundle"]];
    });
    return resourcesBundle;
}

@end
