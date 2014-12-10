
//
//  Created by Yasser Mabrouk.
//  Copyright (c) 2014 nWeave. All rights reserved.
//

#import "CaseManager.h"

static CaseManager* instance;

@implementation CaseManager


+ (CaseManager*)getInstance
{
    if (!instance) {
        instance = [[CaseManager alloc] init];
    }
    return instance;
}

- (void)setImage:(UIImage*)image forImageViewWithTag:(NSInteger)tag
{
    @try {
        if (!self.templateImages) {
            self.templateImages = [[NSMutableDictionary alloc] init];
        }
        
        if (!image) {
            [self.templateImages setObject:[NSNull null] forKey:[NSNumber numberWithInteger:tag]];
        }
        [self.templateImages setObject:image forKey:[NSNumber numberWithInteger:tag]];
    }
    @catch (NSException *exception) {
        
    }
}

- (void)resetData
{
    NSLog(@"%@", [NSString stringWithUTF8String:__func__]);
    @try {
        self.selectedTemplate = nil;
        self.selectedDevice = nil;
        self.templateImages = nil;
        self.swipeImages = nil;
        self.selectedDeviceCamera = nil;
        self.caseImageWithTemplate = nil;
        self.caseImageWithoutTemplate = nil;
    }
    @catch (NSException *exception) {
        
    }
}


@end
