//
//  SelectImagesViewController.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"
#import "CustomAssetTablePicker.h"
#import "SwipeView.h"
#import "ImageSwipeView.h"
#import "CaseManager.h"
#import "OBDragDrop.h"
#import "DraggableObjectData.h"
#import "ImageCropView.h"
#import "TemplateView.h"
#import "TemplatesManager.h"
#import "Template.h"
#import "InfoDialogViewController.h"
#import "FPPopoverController.h"


@interface SelectImagesViewController : UIViewController <ELCImagePickerControllerDelegate, SwipeViewDataSource, SwipeViewDelegate, OBOvumSource, OBDropZone, ImageCropViewControllerDelegate, ImageSwipeViewDelegate, PopupDelegate>

@property (strong, nonatomic) TemplatesManager* templatesManager;
@property (strong, nonatomic) NSString *infoDialogText;

@property (strong, nonatomic) IBOutlet UIView *previewTemplate;
@property (strong, nonatomic) IBOutlet SwipeView *swipeView;
@property (strong, nonatomic) IBOutlet UIImageView *selectedDeviceImage;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

- (IBAction)infoButtonClicked:(id)sender;
- (NSString*) setInfoDialogText;

@end
