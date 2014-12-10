//
//  DeviceData.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/6/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TemplateView.h"
#import "Constant.h"

@interface TemplateAView : TemplateView

@property (weak, nonatomic) IBOutlet UIView *imagesView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *leftMiddleView;
@property (weak, nonatomic) IBOutlet UIView *rightMiddleView;
@property (weak, nonatomic) IBOutlet UIView *BottomView;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftMiddleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightMiddleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;

@property (weak, nonatomic) IBOutlet UIView *bordersView;

@property (strong, nonatomic) NSMutableArray *templateImageViews;
@property (strong, nonatomic) NSMutableArray *templateTopViews;


@end
