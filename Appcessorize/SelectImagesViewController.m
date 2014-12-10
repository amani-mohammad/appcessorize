//
//  SelectImagesViewController.m
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "SelectImagesViewController.h"


@interface SelectImagesViewController ()

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;

@end


@implementation SelectImagesViewController {
    InfoDialogViewController *infoDialog;
    FPPopoverController *popover;
    
    NSInteger swipeSelectedIndex;
    
    int selectedImageTag;
    
    CaseManager* caseManager;
    
    UIBarButtonItem* saveButton;
}

@synthesize templatesManager;


#pragma mark - Life cycle
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @try {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:SELECT_IMAGES_VIEW] bundle:nibBundleOrNil];
        
        return self;
    }
    @catch (NSException *exception) {
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IS_IPHONE) {
        self.scrollView.contentSize = CGSizeMake(320, 700);
    } else {
        self.scrollView.contentSize = CGSizeMake(768, 1500);
    }
    
    [self.infoButton setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"SelectDevice_screen_help_icon"]] forState:UIControlStateNormal ];

    [self configureSwipe];
    
    [self initTemplateView];
    
    // for first time open the tab
    caseManager = [CaseManager getInstance];
    if ([caseManager swipeImages] == nil) {
        [self launchSpecialController];
    }
    
    self.scrollView.userInteractionEnabled = YES;
    
    // Register view as a drop zone that will be handled by its controller
    [self configureOBDragDrop];
    [self setInfoDialogText];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCaseImage)
                                                 name:@"SaveCaseImage"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    @try {
        if ([caseManager selectedDevice]) {
            [self.selectedDeviceImage setImage:[UIImage imageNamed:[caseManager selectedDevice]]];
        } else {
            [[CaseManager getInstance] setSelectedDevice:[[Utility sharedInstance] appendBundleNameToString:@"common_screen_iphone_6_image"]];
            [[CaseManager getInstance] setSelectedDeviceCamera:[[Utility sharedInstance] appendBundleNameToString:@"iphone6_camera"]];
            [self.selectedDeviceImage setImage:[UIImage imageNamed:[caseManager selectedDevice]]];
        }
        
        [self reloadTemplateView];

        [self setSwipeViewData];
        
        [self setTemplateImages];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Template images
- (void)initTemplateView
{
    templatesManager = [TemplatesManager getInstance];
    if (!templatesManager.selectedTemplate) {
        //load default template for the first view load
        templatesManager.selectedTemplate = [[Template alloc] init];
        templatesManager.selectedTemplate.templateName = TEMPLATE_1_VIEW;
        templatesManager.selectedTemplate.numberOfImages = TEMPLATE_1_IMAGES_NUMBER;
    }
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:TEMPLATE_1_VIEW] owner:self options:nil];
    
    TemplateView* myView = [nibViews objectAtIndex:0];
    [myView setTag:TEMPLATE_VIEW_TAG];
    [myView setUserInteractionEnabled:YES];
    
    //Add tap gesture recognizers to the template images
    for (int i = 1; i <= TEMPLATE_1_IMAGES_NUMBER; i ++) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(templateImageClicked:)];
        [singleTap setNumberOfTapsRequired:1];
        UIView* borderView = [myView.bordersView viewWithTag:TEMPLATE_BORDERS_BASE_TAG+i];
        [borderView addGestureRecognizer:singleTap];
    }
    
    [self.previewTemplate addSubview:myView];
}

- (void)reloadTemplateView
{
    UIView* oldTemplateView = [self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG];
    [oldTemplateView removeFromSuperview];
    
    if (!templatesManager.selectedTemplate) {
        //load default template for the first view load
        templatesManager.selectedTemplate = [[Template alloc] init];
        templatesManager.selectedTemplate.templateName = TEMPLATE_1_VIEW;
        templatesManager.selectedTemplate.numberOfImages = TEMPLATE_1_IMAGES_NUMBER;
    }
    NSString *templateName = templatesManager.selectedTemplate.templateName;
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:templateName] owner:self options:nil];
    
    TemplateView* myView = [nibViews objectAtIndex:0];
    [myView setTag:TEMPLATE_VIEW_TAG];
    [myView setUserInteractionEnabled:YES];
    
    //Add tap gesture recognizers to the template images
    for (int i = 1; i <= templatesManager.selectedTemplate.numberOfImages; i ++) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(templateImageClicked:)];
        [singleTap setNumberOfTapsRequired:1];
        UIView* borderView = [myView.bordersView viewWithTag:TEMPLATE_BORDERS_BASE_TAG+i];
        [borderView addGestureRecognizer:singleTap];
        
        // add remove button action
        [(UIButton *)[borderView viewWithTag:BORDER_VIEW_REMOVE_BUTTON_TAG] addTarget:self action:@selector(borderViewRemoveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // set camera image
    [[myView cameraImageView] setImage:[UIImage imageNamed:[caseManager selectedDeviceCamera]]];
    
    [self.previewTemplate addSubview:myView];
}

- (void)setTemplateImages
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // hide camera image
        [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:YES];

        NSMutableDictionary *dictionary = [[CaseManager getInstance] templateImages];
        if (dictionary) {
            for (NSNumber* key in dictionary) {
                // get imageView
                UIImageView* imageView = (UIImageView*)[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) viewWithTag:[key integerValue]];
                
                id value = [dictionary objectForKey:key];
                
                if (value == [NSNull null]) {
                    [imageView setImage:nil];
                }else{
                    [imageView setImage:(UIImage *)value];
                    
                    // show the remove button
                    [self setRemoveButtonForTemplateImage:[key integerValue] andHidden:NO];
                }
        
                // camera image
                if ( ([key integerValue] - TEMPLATE_IMAGES_VIEWS_BASE_TAG) == 1) {
                    if (value != [NSNull null]) {
                        // set camera image;
                        [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:NO];
                    }
                }
            }
        }
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark - Swipe view data
- (void)setSwipeViewData
{
    @try {
        [[self swipeView] reloadData];
    }
    @catch (NSException *exception) {
        
    }
}

#pragma mark - image picker
- (void)launchSpecialController
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.specialLibrary = library;
    NSMutableArray *groups = [NSMutableArray array];
    [_specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [groups addObject:group];
        } else {
            // this is the end
            [self displayPickerForGroup:[groups objectAtIndex:0]];
        }
    } failureBlock:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Album Error: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"A problem occured %@", [error description]);
        // an error here means that the asset groups were inaccessable.
        // Maybe the user or system preferences refused access.
    }];
}

- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    CustomAssetTablePicker *tablePicker = [[CustomAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    
    elcPicker.maximumImagesCount = 10;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}


#pragma mark - ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    if ([caseManager swipeImages] == nil) {
        [caseManager setSwipeImages:[NSMutableArray arrayWithCapacity:[info count]]];
    }
    
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]) {
                UIImage* image = [dict objectForKey:UIImagePickerControllerOriginalImage];
                [[caseManager swipeImages] addObject:image];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
    }
    
    [_swipeView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return [[caseManager swipeImages] count] + 1;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    @try {
        if (!view) {
            view = [[NSBundle mainBundle] loadNibNamed:[[Utility sharedInstance] appendBundleNameToString:IMAGE_SWIPE_VIEW] owner:self options:nil][0];
        }
        
        if (index == 0) {
            ImageSwipeView* imageSwipeView = (ImageSwipeView *)view;
//            UIImageView* addImage = (UIImageView*)[[imageSwipeView addImageView] viewWithTag:2];
//            [addImage setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:IMAGES_PLUS_ICON]]];
            [[imageSwipeView addImageView] setHidden:NO];
            [[imageSwipeView addImageIcon] setHidden:NO];
            [[imageSwipeView imageView] setImage:nil];
            imageSwipeView.delegate = self;
            imageSwipeView.deleteButton.hidden = YES;
            
            // remove createLongPressDragDropGestureRecognizer
            for (UIGestureRecognizer *gesture in [view gestureRecognizers]) {
                [view removeGestureRecognizer:gesture];
            }
        } else {
            ImageSwipeView* imageSwipeView = (ImageSwipeView *)view;
            imageSwipeView.delegate = self;
            imageSwipeView.deleteButton.hidden = NO;
            [[imageSwipeView addImageView] setHidden:YES];
            [[imageSwipeView imageView] setImage:[[caseManager swipeImages] objectAtIndex:index - 1]];
            
            if ([[view gestureRecognizers] count] == 0) {
                UILongPressGestureRecognizer *dragDropRecognizer = [[OBDragDropManager sharedManager] createLongPressDragDropGestureRecognizerWithSource:self];
                [view addGestureRecognizer:dragDropRecognizer];
            }
        }
        
        [view setTag:index];
        
        return view;
    }
    @catch (NSException *exception) {
        
    }
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    @try{
        if (index == 0) { //Add button
            [self launchSpecialController];
        } else {
            swipeSelectedIndex = index;
        }
    }
    @catch (NSException *exception) {
    }
}


#pragma mark - Save case image
- (void)saveCaseImage
{
//    UIView* view = ((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]);
//    UIView* imagesView = [view viewWithTag:TEMPLATE_IMAGES_VIEW_TAG];
//    
//    [self changeScaleforView:imagesView scale:2];
//    
//    UIGraphicsBeginImageContextWithOptions(imagesView.bounds.size, NO, 2);
//    
//    [imagesView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
//    
//    [self changeScaleforView:imagesView scale:1];
    
    
    //hide close buttons
    for (int i = 1; i <= self.templatesManager.selectedTemplate.numberOfImages; i ++) {
        UIView *imageBorderView = [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) bordersView] viewWithTag:TEMPLATE_BORDERS_BASE_TAG + i];
        UIButton* closeButton = (UIButton *)[imageBorderView viewWithTag:BORDER_VIEW_REMOVE_BUTTON_TAG];
        [closeButton setHidden:YES];
    }
    
    //save image with template
    UIView* view = self.previewTemplate;
    
    [self changeScaleforView:view scale:2];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 2);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    caseManager.caseImageWithTemplate = img;
    
    [self changeScaleforView:view scale:1];
    
    //show close buttons
    for (int i = 1; i < self.templatesManager.selectedTemplate.numberOfImages; i ++) {
        UIView *imageBorderView = [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) bordersView] viewWithTag:TEMPLATE_BORDERS_BASE_TAG + i];
        UIButton* closeButton = (UIButton *)[imageBorderView viewWithTag:BORDER_VIEW_REMOVE_BUTTON_TAG];
        [closeButton setHidden:NO];
    }
    
    //save image without template
    UIView* view2 = ((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]);
    UIView* imagesView = [view2 viewWithTag:TEMPLATE_IMAGES_VIEW_TAG];

    [self changeScaleforView:imagesView scale:2];

    UIGraphicsBeginImageContextWithOptions(imagesView.bounds.size, NO, 2);

    [imagesView.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *img2 = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    caseManager.caseImageWithoutTemplate = img2;

    [self changeScaleforView:imagesView scale:1];
}

- (float)screenScale
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES) {
        return [[UIScreen mainScreen] scale];
    }
    return 1;
}

- (void)changeScaleforView:(UIView *)aView scale:(CGFloat)scale
{
    [aView.subviews enumerateObjectsUsingBlock:^void(UIView *v, NSUInteger idx, BOOL *stop)
     {
         if ([v isKindOfClass:[UILabel class]]) {
             v.layer.contentsScale = scale;
         } else {
             if([v isKindOfClass:[UIImageView class]]) {
                 // labels and images
                 v.layer.contentsScale = scale; //won't work
                 
                 // if the image is not "@2x", you could subclass UIImageView and set the name of the @2x
                 // on it as a property, then here you would set this imageNamed as the image, then undo it later
             } else {
                 if([v isMemberOfClass:[UIView class]]) {
                     // container view
                     [self changeScaleforView:v scale:scale];
                 }
             }
         }
     } ];
}


#pragma mark - Edit template images
- (void)templateImageClicked:(id)sender
{
    UIView* tappedView = ((UIGestureRecognizer*)sender).view;
    int imageViewTag = (int)(tappedView.tag - TEMPLATE_IMAGES_VIEWS_BASE_TAG);
    UIImageView* imageView = (UIImageView*)[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) viewWithTag:imageViewTag];
    UIImage* image = imageView.image;
    if (image) {
        selectedImageTag = imageViewTag;
        [self showEditImageView:image];
    }
}

- (void)showEditImageView:(UIImage*)image
{
    ImageCropViewController *controller = [[ImageCropViewController alloc] initWithImage:image];
    controller.delegate = self;
    controller.blurredBackground = YES;
    [self.view addSubview:controller.view];
    self.swipeView.hidden = YES;
    
    saveButton = self.tabBarController.navigationItem.rightBarButtonItem;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


#pragma mark - Image crop delegate
- (void)ImageCropViewController:(ImageCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    self.tabBarController.navigationItem.rightBarButtonItem = saveButton;
    self.swipeView.hidden = NO;
    UIImageView* imageView = (UIImageView*)[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) viewWithTag:selectedImageTag];
    imageView.image = croppedImage;
}

- (void)ImageCropViewControllerDidCancel:(ImageCropViewController *)controller
{
    self.tabBarController.navigationItem.rightBarButtonItem = saveButton;
    self.swipeView.hidden = NO;
}


#pragma mark - Drag & drop
- (void)configureOBDragDrop
{
    @try {
        OBDragDropManager *dragDropManager = [OBDragDropManager sharedManager];
        [dragDropManager prepareOverlayWindowUsingMainWindow:[[UIApplication sharedApplication] keyWindow]];
        // Set preview template as drop zone handeler
        self.previewTemplate.dropZoneHandler = self;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - OBDragDrop source delegate
- (OBOvum *)createOvumFromView:(UIView*)sourceView
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        OBOvum *ovum = [[OBOvum alloc] init];
        DraggableObjectData *data = [[DraggableObjectData alloc] init];
        if ([sourceView isKindOfClass:[ImageSwipeView class]]) {
            data.tag = [_swipeView indexOfItemView:sourceView];
            data.dragFlag = DRAG_FROM_SWIPEVIEW;
        }
        else{
            // drag from template
            // make sure not to drag nil image
            // image tag = border tag - border base tag + image bas tag
            NSInteger imageViewTag = [sourceView tag] - TEMPLATE_BORDERS_BASE_TAG + TEMPLATE_IMAGES_VIEWS_BASE_TAG;
            UIImageView *imageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:imageViewTag];
            if (imageView.image) {
                //        ovum.dataObject = [NSNumber numberWithInteger:[sourceView tag]] ;
                data.tag = imageViewTag;
                data.dragFlag = DRAG_FROM_TEMPLATE;
            } else {
                return nil;
            }
        }
        ovum.dataObject = data;
        return ovum;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

-(UIView *)createDragRepresentationOfSourceView:(UIView *)sourceView inWindow:(UIWindow*)window
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // Create the drag representation image view
        CGRect frame = [sourceView convertRect:sourceView.bounds toView:sourceView.window];
        frame = [window convertRect:frame fromWindow:sourceView.window];
        
        UIImageView *dragView = [[UIImageView alloc] initWithFrame:frame];
        dragView.backgroundColor = sourceView.backgroundColor;
        dragView.layer.cornerRadius = 5.0;
        dragView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
        dragView.layer.borderWidth = 1.0;
        dragView.layer.masksToBounds = YES;
        
        // set the image
        if ([sourceView isKindOfClass:[ImageSwipeView class]]) {
            dragView.image = [[((ImageSwipeView*)sourceView) imageView] image];
        } else {
            // has the tag of top view
            // top view has the same tag Or (link them)
            
            // get imageview that map to top view
            NSInteger imageViewTag = [sourceView tag] - TEMPLATE_BORDERS_BASE_TAG + TEMPLATE_IMAGES_VIEWS_BASE_TAG;
            UIImageView *imageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:imageViewTag];
            if (imageView.image) {
                dragView.image = imageView.image;
            } else {
                return nil;
            }
        }
        return dragView;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - OBDropZone delegate
- (OBDropAction)ovumEntered:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    if (!ovum) {
        return OBDropActionNone;
    }
    return OBDropActionCopy;    // Return OBDropActionNone if view is not currently accepting this ovum
}

- (void)ovumExited:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
}

- (void)ovumDropped:(OBOvum*)ovum inView:(UIView*)view atLocation:(CGPoint)location
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    // Handle the drop action
    @try {
        // get index of image view of dropped place in template
        NSInteger imageViewTag = [self getImageViewIndexForLocation:location];
        
        DraggableObjectData *data = ovum.dataObject;
        if (data.dragFlag == DRAG_FROM_SWIPEVIEW) {  // drag from swipe view
            UIImageView *imageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:imageViewTag];
            if ([imageView image]) {
                // case manager to has image shared
                [[caseManager swipeImages] addObject:[imageView image]];
            }
            
            NSInteger droppedImageIndex = [data tag] - 1; // (-1) for add image in swipe view
            
            UIImage *image = [[caseManager swipeImages] objectAtIndex:droppedImageIndex];  // -1 to as swipeview first item = add item
            [imageView setImage:image];
            // save image to template imagedictionary
            [caseManager setImage:image forImageViewWithTag:imageView.tag];
            
            // TODO: Make this camera part more general
            // OR adjust it's fram in nib from the begining
            // set camera to template if no imagesselected
            if ((imageViewTag - TEMPLATE_IMAGES_VIEWS_BASE_TAG) == 1 && [[((TemplateView*)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] isHidden] ) {
                [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:NO];
            }
            
            // show remove button
            [self setRemoveButtonForTemplateImage:imageViewTag andHidden:NO];
            
            [[caseManager swipeImages] removeObjectAtIndex:droppedImageIndex];
            
            [_swipeView reloadData];
        } else {
            // drag from template
            
            // 1. get dargged image
            UIImageView *imageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:[data tag]];
            UIImage *image = imageView.image;
            
            // 2. get dropped place image
            // swap 2 image if there is image in droped place
            UIImageView *secondImageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:imageViewTag];
            UIImage *image2 = [secondImageView image];
            [imageView setImage:image2];
            [secondImageView setImage:image];
            
            // Adjust camera image
            UIImageView *topImageView = (UIImageView *)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag:TEMPLATE_IMAGES_VIEWS_BASE_TAG + 1];
            if (topImageView.image == nil) {
                [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:YES];
            } else if ([[((TemplateView*)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] isHidden]) {
                [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:NO];
            }
            
            // remove button
            // if view contain image , show remove button
            // if view doesn't contain button , hide remove button
            [self setRemoveButtonForTemplateImage:imageView.tag andHidden:(imageView.image == nil)? YES : NO];
            [self setRemoveButtonForTemplateImage:secondImageView.tag andHidden:(secondImageView.image == nil)? YES : NO];
            
            // save image to template imagedictionary
            [caseManager setImage:image forImageViewWithTag:secondImageView.tag];
            [caseManager setImage:image2 forImageViewWithTag:imageView.tag];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}

-(NSInteger)getImageViewIndexForLocation:(CGPoint)location
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    NSInteger insertionIndex = 0;
    @try {
        for (int i = 1; i <= templatesManager.selectedTemplate.numberOfImages; i ++) {
            UIImageView* imageView = (UIImageView*)[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) viewWithTag:TEMPLATE_IMAGES_VIEWS_BASE_TAG+i];
            if (CGRectContainsPoint([imageView.superview frame], location)) {
                return TEMPLATE_IMAGES_VIEWS_BASE_TAG + i;
            }
        }
        return insertionIndex;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
    return insertionIndex;
}


#pragma mark - Remove button action
- (void)borderViewRemoveButtonClicked:(id)sender
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        // 1. get image
        // 2. return image to swipe view
        // 3. clear view image
        
        NSInteger borderViewTag = [[(UIButton *)sender superview] tag];
        UIImageView *imageView = (UIImageView*)[[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) imagesView] viewWithTag: borderViewTag - TEMPLATE_IMAGES_VIEWS_BASE_TAG];
        if (imageView.image) {
            [[[CaseManager getInstance] swipeImages] addObject:imageView.image];
            [[[CaseManager getInstance] templateImages] removeObjectForKey:[NSNumber numberWithInteger:imageView.tag]];
            imageView.image = nil;
            [_swipeView reloadData];
        }
        
        // notify case manager with image remove
//        [caseManager setImage:nil forImageViewWithTag:imageView.tag];

        // hide remove button
        [(UIButton *)sender setHidden:YES];
        
        // hide camera
        if ((borderViewTag - TEMPLATE_BORDERS_BASE_TAG) == 1 && ![[((TemplateView*)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] isHidden]) {
            [[((TemplateView*)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) cameraImageView] setHidden:YES];
        }
    }
    @catch (NSException *exception) {
        
    }
}


#pragma mark - Show remove button
- (void)setRemoveButtonForTemplateImage:(NSInteger)imageViewTag andHidden:(BOOL)hidden
{
    @try {
        UIView *imageBorderView = [[((TemplateView *)[self.previewTemplate viewWithTag:TEMPLATE_VIEW_TAG]) bordersView] viewWithTag:TEMPLATE_BORDERS_BASE_TAG + imageViewTag - TEMPLATE_IMAGES_VIEWS_BASE_TAG];
        [[(UIButton *)imageBorderView viewWithTag:BORDER_VIEW_REMOVE_BUTTON_TAG] setHidden:hidden];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - ImageSwipeViewDelegate
- (void)deleteImage:(id)sender
{
    ImageSwipeView* imageSwipeView = (ImageSwipeView*)[sender superview];
    UIImageView* imageView = imageSwipeView.imageView;
    UIImage* image = imageView.image;
    [[caseManager swipeImages] removeObject:image];
    
    [imageSwipeView removeFromSuperview];
    
    [self.swipeView reloadData];
}


#pragma mark - Info Dialog
- (IBAction)infoButtonClicked:(id)sender {
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try{
        if(! infoDialog){
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
        [infoDialog setInfoText:[self setInfoDialogText]];
        [popover presentPopoverFromView:targetView];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
}


#pragma mark - popup dialog delegate
- (void)dismissInfoButtonClicked:(id)sender
{
    [popover dismissPopoverAnimated:YES];
}

- (NSString*)setInfoDialogText {
    return  NSLocalizedString(@"Press + button to select images. You can add image to the template, remove any image from the template or remove an image from the swipe view", nil);
}


@end
