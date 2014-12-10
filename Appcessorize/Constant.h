//
//  Constant.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/4/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

//----------------------------- General ------------------------------------
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define BUNDLE_NAME @"Appcessorize.bundle/";
#define TITLE @"Appcessorize"


//---------------------------- Colors --------------------------------------
#define APP_YELLOW_COLOR [[UIColor alloc] initWithRed:(231/255.0) green:(156/255.0) blue:(37/255.0) alpha:1]
#define NAVIGATIONBAR_BACKGROUND_COLOR [[UIColor alloc] initWithRed:(224/255.0) green:(63/255.0) blue:(55/255.0) alpha:1]
#define APP_OUTER_BOARDER [[UIColor alloc] initWithRed:(142/255.0) green:(194/255.0) blue:(241/255.0) alpha:1]

#define SAVE_BUTTON_BACKGROUND_COLOR [[UIColor alloc] initWithRed:(198/255.0) green:(55/255.0) blue:(47/255.0) alpha:1]


//---------------------------- Drag & Drop ---------------------------------
#define DRAG_FROM_SWIPEVIEW 0
#define DRAG_FROM_TEMPLATE 1


//---------------------------- Images --------------------------------------
#define COMMON_SCREEN_CANCEL_IMAGE @"common_screen_cancel_image"
#define COMMON_SCREEN_SELECTED_BUTTON_PATTERN @"common_screen_selected_button_pattern"
#define COMMON_SCREEN_BACK_ICON @"common_screen_back_icon"
#define COMMON_SCREEN_DEVICE_ICON @"common_screen_device_icon"
#define COMMON_SCREEN_IMAGE_ICON @"common_screen_image_icon"
#define COMMON_SCREEN_TEMPLATE_ICON @"common_screen_template_icon"
#define COMMON_SCREEN_LAYOUT_ICON @"common_screen_lay_out_icon"
#define WELCOME_SCREEN_CAMERA_ICON @"welcome_screen_camera_icon"
#define WELCOME_SCREEN_BACKGROUND @"welcome_screen_background"
#define IMAGES_PLUS_ICON @"selectImages_screen_plus_icon"


//---------------------------- Views ----------------------------------------
#define DEVICE_SELECTION_VIEW_CONTROLLER (IS_IPHONE? @"DeviceSelectionViewController":@"DeviceSelectionViewController_iPad")
#define DEVICE_ICON_VIEW (IS_IPHONE? @"DeviceIconView":@"DeviceIconView_ipad")
#define INFO_DIALOG_VIEW (IS_IPHONE? @"InfoDialogViewController":@"InfoDialogViewController_ipad")
#define HOME_VIEW (IS_IPHONE? @"HomeViewController":@"HomeViewController_iPad")
#define BOTTOM_VIEW (IS_IPHONE? @"BottomConfirmView":@"BottomConfirmView_iPad")
#define SELECT_IMAGES_VIEW (IS_IPHONE? @"SelectImagesViewController":@"SelectImagesViewController_iPad")
#define IMAGE_SWIPE_VIEW (IS_IPHONE? @"ImageSwipeView":@"ImageSwipeView_iPad")
#define TEMPLATE_VIEW (IS_IPHONE? @"TemplateViewController":@"TemplateViewController_iPad")
#define TEMPLATE_SWIPE_VIEW (IS_IPHONE? @"TemplateSwipeView":@"TemplateSwipeView_iPad")


//----------- Templates ----------------
#define COERNER_RADIUS (IS_IPHONE? 25.0:50.0)
#define BORDER_WIDTH (IS_IPHONE? 2.0:4.0)

#define REMOVE_BUTTON_FRAME (IS_IPHONE? CGRectMake(5, 5, 25, 25):CGRectMake(8, 8, 35, 35))

#define TEMPLATE_VIEW_TAG 1000

#define NUMBER_OF_AVAILABLE_TEMPLATES 4

#define TEMPLATE_IMAGES_VIEW_TAG 1
#define TEMPLATE_CAMERA_IMAGE_TAG 2
#define TEMPLATE_BORDERS_VIEW_TAG 3

#define TEMPLATE_IMAGES_SUBVIEWS_BASE_TAG 10
#define TEMPLATE_IMAGES_VIEWS_BASE_TAG 50
#define TEMPLATE_BORDERS_BASE_TAG 100
#define BORDER_VIEW_REMOVE_BUTTON_TAG 4

#define TEMPLATE_1_VIEW (IS_IPHONE? @"Template_1_View":@"Template_1_View_iPad")
#define TEMPLATE_2_VIEW (IS_IPHONE? @"Template_2_View":@"Template_2_View_iPad")
#define TEMPLATE_3_VIEW (IS_IPHONE? @"Template_3_View":@"Template_3_View_iPad")
#define TEMPLATE_4_VIEW (IS_IPHONE? @"Template_4_View":@"Template_4_View_iPad")

#define TEMPLATE_1_GRID @"common_screen_template_grid_1"
#define TEMPLATE_2_GRID @"common_screen_template_grid_2"
#define TEMPLATE_3_GRID @"common_screen_template_grid_3"
#define TEMPLATE_4_GRID @"common_screen_template_grid_4"

#define TEMPLATE_1_GRID_PRESSED @"common_screen_template_grid_1_pressed"
#define TEMPLATE_2_GRID_PRESSED @"common_screen_template_grid_2_pressed"
#define TEMPLATE_3_GRID_PRESSED @"common_screen_template_grid_3_pressed"
#define TEMPLATE_4_GRID_PRESSED @"common_screen_template_grid_4_pressed"

#define TEMPLATE_1_IMAGES_NUMBER 1
#define TEMPLATE_2_IMAGES_NUMBER 3
#define TEMPLATE_3_IMAGES_NUMBER 4
#define TEMPLATE_4_IMAGES_NUMBER 6


//----------------------------- Web side -----------------------
#define KEY_DESIGN_NAME   @"KEY_DESIGN_NAME"

#define kBaseURL @"https://instagram.com/"
#define kInstagramAPIBaseURL @"https://api.instagram.com"
#define kAuthenticationURL @"oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token&scope=likes+comments+basic"  // comments
#define kClientID @"173da78d74924c27a20663b0c2e92fb5"
#define kRedirectURI @"http://www.nweave.com"

@end
