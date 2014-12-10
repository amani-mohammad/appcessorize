//
//  ImageSwipeView.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/9/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "ImageSwipeView.h"
#import "Utility.h"
#import "Constant.h"


@implementation ImageSwipeView

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self.addImageIcon setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:IMAGES_PLUS_ICON]]];
    
    UIImage *image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_CANCEL_IMAGE]];
    [self.deleteButton setImage:image forState:UIControlStateNormal];
    [self.deleteButton setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
}

- (IBAction)deleteImage:(id)sender
{
    [self.delegate deleteImage:sender];
}


@end
