//
//  CustomButtonWithBorder.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/13/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "CustomButtonWithBorder.h"

@implementation CustomButtonWithBorder

- (id)initWithCoder:(NSCoder *)coder {
    @try {
        self = [super initWithCoder:coder];
        if (self) {
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

            self.layer.cornerRadius = 5;
            self.layer.borderWidth = 1;
            self.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        return self;
    }
    @catch (NSException *exception) {
        
    }
}


@end
