//
//  InfoViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/5/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "InfoDialogViewController.h"

@interface InfoDialogViewController ()

@end

@implementation InfoDialogViewController

@synthesize infoTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:[[Utility sharedInstance]appendBundleNameToString:INFO_DIALOG_VIEW] bundle:nibBundleOrNil];
    
    if (self) {
        float windowWidth = [[UIScreen mainScreen] bounds].size.width;
        float windowHeight = [[UIScreen mainScreen] bounds].size.height;
        self.view.bounds = CGRectMake(0, 0, windowWidth, windowHeight);
        self.view.frame = CGRectMake(0, 0, windowWidth, windowHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        [super viewDidLoad];
        
        UIColor *customColor = APP_YELLOW_COLOR;
        [_closeButton setBackgroundColor:customColor];
        [_closeButton setTitle:@"Close" forState:(UIControlStateNormal)];
        self.infoTextView.editable = NO;
        [self.infoTextView scrollRangeToVisible:NSMakeRange(0, 0)];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)closeButtonClicked:(id)sender
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        if ([self.delegate respondsToSelector:@selector(dismissInfoButtonClicked:)]) {
            [self.delegate dismissInfoButtonClicked:nil];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)setInfoText:(NSString*)info
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        infoTextView.text = info;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}


@end
