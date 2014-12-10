//
//  TemplateManipulationViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "TemplateManipulationViewController.h"

@interface TemplateManipulationViewController ()

@end


@implementation TemplateManipulationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @try {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        
        return self;
    }
    @catch (NSException *exception) {
         NSLog(@"Exception %@" ,[exception description]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureTemplateDragDrop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Template drag and drop
- (void)configureTemplateDragDrop
{
    @try {
        TemplateView* myView = (TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG];
       
        for (int i = 1; i <= self.templatesManager.selectedTemplate.numberOfImages; i ++) {
            UIView* borderView = [myView.bordersView viewWithTag:TEMPLATE_BORDERS_BASE_TAG+i];
            UILongPressGestureRecognizer *dragDropRecognizer = [[OBDragDropManager sharedManager] createLongPressDragDropGestureRecognizerWithSource:self];
            [borderView addGestureRecognizer:dragDropRecognizer];
        }
    }
    @catch (NSException *exception) {
      NSLog(@"Exception %@" ,[exception description]);
    }
}

- (NSString *)setInfoDialogText {
   return NSLocalizedString( @"Drag and drop images between the template frames and add/remove them", nil);
}


@end
