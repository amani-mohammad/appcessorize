//
//  TemplateViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "TemplateViewController.h"
#import "CaseManager.h"
#import "TemplateSwipeView.h"
#import "TemplatesManager.h"
#import "TemplateView.h"
#import "Template.h"


@interface TemplateViewController () {
    CaseManager* caseManager;
    TemplatesManager* templatesManager;
    NSInteger swipeSelectedIndex;
    InfoDialogViewController *infoDialog;
    FPPopoverController *popover;
}

@end


@implementation TemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @try {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:TEMPLATE_VIEW] bundle:nibBundleOrNil];
        
        return self;
    }
    @catch (NSException *exception) {
         NSLog(@"Exception %@" ,[exception description]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.infoButton setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"SelectDevice_screen_help_icon"]] forState:UIControlStateNormal];
    
    if (IS_IPHONE) {
        self.scrollView.contentSize = CGSizeMake(320, 700);
    } else {
        self.scrollView.contentSize = CGSizeMake(768, 1500);
    }
    
    [self configureSwipe];
    
    caseManager = [CaseManager getInstance];
    
    [self initTemplateView];
    
    self.scrollView.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    @try {
        if ([caseManager selectedDevice]) {
            [self.selectedDeviceImage setImage:[UIImage imageNamed:[caseManager selectedDevice]]];
        } else {
            [[CaseManager getInstance] setSelectedDevice:[[Utility sharedInstance] appendBundleNameToString:@"common_screen_iphone_6_image"]];
            [[CaseManager getInstance] setSelectedDeviceCamera:[[Utility sharedInstance] appendBundleNameToString:@"iphone6_camera"]];
            [self.selectedDeviceImage setImage:[UIImage imageNamed:[caseManager selectedDevice]]];
        }
        
        if (templatesManager.selectedTemplate) {
            NSRange range = [templatesManager.selectedTemplate.templateName rangeOfString:@"_"];
            NSString* templateNumberString = [templatesManager.selectedTemplate.templateName substringWithRange:NSMakeRange(range.location+1, 1)];
            swipeSelectedIndex = [templateNumberString intValue]-1;
        } else {
            swipeSelectedIndex = 0;
        }
        
        if (swipeSelectedIndex == 0) {
            [self initTemplateView];
        }
        
        [self setSwipeViewData];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initTemplateView
{
    templatesManager = [TemplatesManager getInstance];
    
    Template *selectedTemplate = templatesManager.selectedTemplate;
    
    if (!selectedTemplate) {
        selectedTemplate = [[Template alloc] init];
        selectedTemplate.templateName = TEMPLATE_1_VIEW;
        selectedTemplate.numberOfImages = TEMPLATE_1_IMAGES_NUMBER;
    }
    
    NSString *templateName = selectedTemplate.templateName;
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:templateName] owner:self options:nil];
    
    TemplateView* myView = [nibViews objectAtIndex:0];
    [myView setTag:TEMPLATE_VIEW_TAG];
    [self.previewTemplate addSubview:myView];
}


#pragma mark - Template images
- (void)changeTemplate
{
    Template *selectedTemplate = [[Template alloc] init];
    switch (swipeSelectedIndex) {
        case 0:
            selectedTemplate.templateName = TEMPLATE_1_VIEW;
            selectedTemplate.numberOfImages = TEMPLATE_1_IMAGES_NUMBER;
            break;
            
        case 1:
            selectedTemplate.templateName = TEMPLATE_2_VIEW;
            selectedTemplate.numberOfImages = TEMPLATE_2_IMAGES_NUMBER;
            break;
            
        case 2:
            selectedTemplate.templateName = TEMPLATE_3_VIEW;
            selectedTemplate.numberOfImages = TEMPLATE_3_IMAGES_NUMBER;
            break;
            
        case 3:
            selectedTemplate.templateName = TEMPLATE_4_VIEW;
            selectedTemplate.numberOfImages = TEMPLATE_4_IMAGES_NUMBER;
            break;
            
            default:
            break;
    }
    
    templatesManager.selectedTemplate = selectedTemplate;
    [self reloadTemplateView];
}

- (void)reloadTemplateView
{
    UIView* oldTemplateView = [self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG];
    [oldTemplateView removeFromSuperview];
    
    NSString *templateName = templatesManager.selectedTemplate.templateName;
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:templateName] owner:self options:nil];
    
    TemplateView* myView = [nibViews objectAtIndex:0];
    [myView setTag:TEMPLATE_VIEW_TAG];
    [self.previewTemplate addSubview:myView];
    
    [self changeTemplateImages];
}

- (void)changeTemplateImages
{
        NSMutableDictionary* savedImages = [[NSMutableDictionary alloc] init];
        for (int i = 1; i <= templatesManager.selectedTemplate.numberOfImages; i ++) {
            UIImage* image = [[caseManager templateImages] objectForKey:[NSNumber numberWithInteger:TEMPLATE_IMAGES_VIEWS_BASE_TAG+i]];
            if (image) {
                [savedImages setObject:image forKey:[NSNumber numberWithInteger:TEMPLATE_IMAGES_VIEWS_BASE_TAG+i]];
                [caseManager.templateImages removeObjectForKey:[NSNumber numberWithInteger:TEMPLATE_IMAGES_VIEWS_BASE_TAG+i]];
            }
        }
    
        for (NSNumber* key in caseManager.templateImages) {
            UIImage* image = [caseManager.templateImages objectForKey:key];
            [caseManager.swipeImages addObject:image];
        }
        
        [caseManager.templateImages removeAllObjects];
        
        caseManager.templateImages = savedImages;
}


#pragma mark - Swipe view data
- (void)setSwipeViewData
{
    @try {
        self.templates = [[NSArray alloc] init];
        self.templates = templatesManager.allTemplatesGrids;
        [[self swipeView] reloadData];
    }
    @catch (NSException *exception) {
        
    }
}


#pragma mark - Swipe View
- (void)configureSwipe
{
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    return [self.templates count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    @try{
        if (!view) {
            view = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:TEMPLATE_SWIPE_VIEW] owner:self options:nil][0];
        }
        
        Template* t = self.templates[index];
        NSString* templateName;
        if (swipeSelectedIndex == index) {
            templateName = t.templateNamePressed;
        } else {
            templateName = t.templateName;
        }
        
        UIImage* template_image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:templateName]];
        
        [[((TemplateSwipeView *)view) templateImageView] setImage:template_image];
        [view setTag:index];
        
        return view;
    }
    @catch (NSException *exception) {
        
    }
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    @try {
        swipeSelectedIndex = index;
        [self changeTemplate];
        [swipeView reloadData];
    }
    @catch (NSException *exception) {
        
    }
}


#pragma mark - Info Dialog
- (IBAction)infoButtonClicked:(id)sender
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try{
        if(!infoDialog) {
            infoDialog = [[InfoDialogViewController alloc]
                          initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"InfoDialogViewController"]
                          bundle:nil];
            infoDialog.delegate = self;
            popover = [[FPPopoverController alloc] initWithViewController:infoDialog];
            popover.contentSize = CGSizeMake(4*infoDialog.view.frame.size.width/5,2*infoDialog.view.frame.size.height/5);//infoDialog.view.frame.size;
            popover.border = NO;
            popover.tint = FPPopoverNoArrow;
            popover.alpha = 1;
        }
        
        UIView *targetView = ((UIButton*)sender);
        [infoDialog setInfoText:NSLocalizedString(@"Select template from the templates in the swipe view below and it will be shown in the preview.", nil)];
        [popover presentPopoverFromView:targetView];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - popup dialog deleget
- (void)dismissInfoButtonClicked:(id)sender
{
    [popover dismissPopoverAnimated:YES];
}


@end
