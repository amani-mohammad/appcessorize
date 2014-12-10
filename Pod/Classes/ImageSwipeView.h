//
//  ImageSwipeView.h
//  AppcessorizeDemo
//
//  Created by Shimaa Essam on 11/9/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageSwipeViewDelegate <NSObject>

- (void)deleteImage:(id)sender;

@end


@interface ImageSwipeView : UIView

@property (strong, nonatomic) id<ImageSwipeViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *addImageView;
@property (strong, nonatomic) IBOutlet UIImageView *addImageIcon;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)deleteImage:(id)sender;

@end
