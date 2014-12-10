//
//  TemplateView.m
//  Appcessorize
//
//  Created by Amani Mohammad on 11/18/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "TemplateView.h"
#import "Constant.h"
#import "Utility.h"


@implementation TemplateView

- (void)addOuterBordertoView:(UIView*)view
{
    UIColor *customColor = APP_OUTER_BOARDER;
    view.frame = CGRectInset(self.frame, -BORDER_WIDTH, -BORDER_WIDTH);
    view.layer.borderColor = customColor.CGColor;
    view.layer.borderWidth = BORDER_WIDTH;
}

- (void)roundedTopCorners:(UIRectCorner)corners forView:(UIView*)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners                                                        cornerRadii:CGSizeMake(COERNER_RADIUS, COERNER_RADIUS)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    [view.layer setMasksToBounds:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.templateObject = [[Template alloc] init];
    self.templateObject.numberOfImages = (int)[[self.imagesView subviews] count];
    
    switch ([[self.imagesView subviews] count]) {
        case 1:
            self.templateObject.templateName = TEMPLATE_1_VIEW;
            break;
        case 2:
            self.templateObject.templateName = TEMPLATE_2_VIEW;
            break;
            
        case 3:
            self.templateObject.templateName = TEMPLATE_3_VIEW;
            break;
            
        case 4:
            self.templateObject.templateName = TEMPLATE_4_VIEW;
            break;
            
            default:
            break;
    }
    
    //add borders to top views
    for (int i = 1; i <= self.templateObject.numberOfImages; i ++) {
        UIView* subView = (UIView*)[self.bordersView viewWithTag:TEMPLATE_BORDERS_BASE_TAG+i];
        [self addOuterBordertoView:subView];
    }
    
    //add rounded corners to the images view
    [self roundedTopCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight forView:self.imagesView];
    
    // Set view tag
    [self setTag:TEMPLATE_VIEW_TAG];
    
    [self addRemoveButtonToBorderViews];
}


#pragma mark - Add remove button
- (void)addRemoveButtonToBorderViews
{
    @try {
        for (int i = 1; i <= self.templateObject.numberOfImages; i ++) {
            UIView* subView = (UIView*)[self.bordersView viewWithTag:TEMPLATE_BORDERS_BASE_TAG+i];
            [subView addSubview:[self removeButton]];
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (UIButton*)removeButton
{
    @try {
        UIImage *image = [UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:COMMON_SCREEN_CANCEL_IMAGE]];
        UIButton *button = [[UIButton alloc] init];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = REMOVE_BUTTON_FRAME;
        [button setTag:BORDER_VIEW_REMOVE_BUTTON_TAG];
        [button setHidden:YES];
        return button;
    }
    @catch (NSException *exception) {
        
    }
}


@end
