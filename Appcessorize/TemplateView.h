//
//  TemplateView.h
//  Appcessorize
//
//  Created by Amani Mohammad on 11/18/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Template.h"

@interface TemplateView : UIView

@property (nonatomic, strong) Template* templateObject;

@property (strong, nonatomic) IBOutlet UIView *imagesView;
@property (strong, nonatomic) IBOutlet UIImageView *cameraImageView;
@property (strong, nonatomic) IBOutlet UIView *bordersView;

@end
