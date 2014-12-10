
//
//  Created by Yasser Mabrouk.
//  Copyright (c) 2014 nWeave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Template.h"


@interface CaseManager : NSObject

+ (CaseManager*)getInstance;

@property(nonatomic, strong) NSString* selectedDevice;
@property(nonatomic, strong) NSString* selectedDeviceCamera;

@property(nonatomic, strong) Template* selectedTemplate;

@property(nonatomic, strong) NSString* caseName;
@property(nonatomic, strong) UIImage* caseImageWithTemplate;
@property(nonatomic, strong) UIImage* caseImageWithoutTemplate;

@property(nonatomic, strong) NSMutableDictionary* templateImages;
@property(nonatomic, strong) NSMutableArray *swipeImages;

- (void)setImage:(UIImage*)image forImageViewWithTag:(NSInteger)tag;
- (void)resetData;

@end
