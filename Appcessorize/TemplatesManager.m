//
//  TemplatesManager.m
//  Appcessorize
//
//  Created by Amani Mohammad on 11/18/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "TemplatesManager.h"
#import "Constant.h"


static TemplatesManager* instance;

@implementation TemplatesManager

+ (TemplatesManager*)getInstance
{
    if (!instance) {
        instance = [[TemplatesManager alloc] init];
    }
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        [self loadTemplates];
    }
    return self;
}

- (void)loadTemplates
{
    NSArray* all_templates_names = @[TEMPLATE_1_GRID, TEMPLATE_2_GRID, TEMPLATE_3_GRID, TEMPLATE_4_GRID];
    NSArray* all_templates_names_pressed = @[TEMPLATE_1_GRID_PRESSED, TEMPLATE_2_GRID_PRESSED, TEMPLATE_3_GRID_PRESSED, TEMPLATE_4_GRID_PRESSED];
    
    NSArray* templates_num_of_images = @[@TEMPLATE_1_IMAGES_NUMBER, @TEMPLATE_2_IMAGES_NUMBER, @TEMPLATE_3_IMAGES_NUMBER, @TEMPLATE_4_IMAGES_NUMBER];
    
    NSMutableArray* templates = [[NSMutableArray alloc] init];
    for (int i = 0; i < NUMBER_OF_AVAILABLE_TEMPLATES; i ++) {
        Template* t = [[Template alloc] init];
        t.templateName = all_templates_names[i];
        t.templateNamePressed = all_templates_names_pressed[i];
        t.numberOfImages = (int)templates_num_of_images[i];
        [templates addObject:t];
    }
    self.allTemplatesGrids = [[NSArray alloc] init];
    self.allTemplatesGrids = templates;
}

- (void)resetData
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        self.selectedTemplate = nil;
    }
    @catch (NSException *exception) {
        
    }
}


@end
