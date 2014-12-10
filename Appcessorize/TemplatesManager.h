//
//  TemplatesManager.h
//  Appcessorize
//
//  Created by Amani Mohammad on 11/18/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Template.h"

@interface TemplatesManager : NSObject

+ (TemplatesManager*)getInstance;

@property (nonatomic, strong) NSArray* allTemplatesGrids;
@property (nonatomic, strong) Template* selectedTemplate;

- (void)resetData;

@end
