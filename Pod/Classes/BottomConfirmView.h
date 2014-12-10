//
//  BottomConfirmView.h
//  Appcessorize
//
//  Created by Amani Mohammad on 11/17/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"


@protocol BottomConfirmViewDelegate <NSObject>

@required
- (void)closeClicked;
- (void)doneClicked;
@end


@interface BottomConfirmView : UIView

@property (strong, nonatomic) id<BottomConfirmViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)closeButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;


@end
