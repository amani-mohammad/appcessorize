//
//  CustomAssetTablePicker.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/9/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "CustomAssetTablePicker.h"
#import "ELCImagePickerController.h"
#import "Constant.h"

@interface CustomAssetTablePicker ()

@end

@implementation CustomAssetTablePicker

- (void)viewDidLoad
{
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setAllowsSelection:NO];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, IS_IPHONE? 72:98, 0)];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.elcAssets = tempArray;
    
    [self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    // Register for notifications when the photo library has changed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preparePhotos) name:ALAssetsLibraryChangedNotification object:nil];
}


#pragma mark - set navigation bar appearance
- (void)setNavigationBarAppearance
{
    NSLog(@"%@",[NSString stringWithUTF8String: __func__]);
    @try {
        NSDictionary *textAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [UIColor whiteColor], NSForegroundColorAttributeName
                                                  , nil];
        [self.navigationController.navigationBar setTitleTextAttributes: textAttributesDictionary];
        [self.navigationController.navigationBar setBarTintColor:NAVIGATIONBAR_BACKGROUND_COLOR];
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    @catch (NSException *exception) {
        
    }
}


#pragma mark - Navigation bar buttons
- (void)setNavigationBarButton
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        UIButton *menuButton = [[Utility sharedInstance] createButtonWithImageName:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_BACK_ICON]];
        [menuButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - Navigation bar button action
- (void)backButtonClicked
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

- (void)preparePhotos
{
    @autoreleasepool {
        [self.elcAssets removeAllObjects];
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if (result == nil) {
                return;
            }
            
            ELCAsset *elcAsset = [[ELCAsset alloc] initWithAsset:result];
            [elcAsset setParent:self];
            
            BOOL isAssetFiltered = NO;
            if (self.assetPickerFilterDelegate &&
                [self.assetPickerFilterDelegate respondsToSelector:@selector(assetTablePicker:isAssetFilteredOut:)])
            {
                isAssetFiltered = [self.assetPickerFilterDelegate assetTablePicker:self isAssetFilteredOut:(ELCAsset*)elcAsset];
            }
            
            if (!isAssetFiltered) {
                [self.elcAssets addObject:elcAsset];
            }
            
        }];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            // scroll to bottom
            long section = [self numberOfSectionsInTableView:self.tableView] - 1;
            long row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
            if (section >= 0 && row >= 0) {
                NSIndexPath *ip = [NSIndexPath indexPathForRow:row
                                                     inSection:section];
                [self.tableView scrollToRowAtIndexPath:ip
                                      atScrollPosition:UITableViewScrollPositionBottom
                                              animated:NO];
            }
            
            [self.navigationItem setTitle:self.singleSelection ? NSLocalizedString(@"SELECT IMAGE", nil) : NSLocalizedString(@"SELECT IMAGES", nil)];
            
            [self setNavigationBarAppearance];
            [self setNavigationBarButton];
            [self addConfirmView];
        });
    }
}


#pragma mark - Bottom view
- (void)addConfirmView
{
    @try {
        ELCImagePickerController* vc = (ELCImagePickerController*)self.parent;

        UIView *view = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:BOTTOM_VIEW] owner:self options:nil][0];
        view.frame = CGRectMake(0, vc.view.bounds.size.height - view.bounds.size.height, self.view.bounds.size.width, view.bounds.size.height);
        
        BottomConfirmView* bottomView = [[BottomConfirmView alloc] init];
        bottomView = (BottomConfirmView*)view;
        bottomView.delegate = self;
        [vc.view addSubview:bottomView];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)closeClicked
{
    @try {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)doneClicked
{
    @try {
         [self doneAction:nil];
    }
    @catch (NSException *exception) {
    }
}


@end
