//
//  BottomConfirmView.m
//  Appcessorize
//
//  Created by Amani Mohammad on 11/17/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "BottomConfirmView.h"

@implementation BottomConfirmView

- (IBAction)closeButtonClicked:(id)sender {
    [self.delegate closeClicked];
}

- (IBAction)doneButtonClicked:(id)sender {
    [self.delegate doneClicked];
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"selectImages_screen_cancel_image"]] forState:UIControlStateNormal];
}


@end
