//
//  DoneViewController.m
//  AppcessorizeDemo
//
//  Created by Maha Ghoneim on 11/9/14.
//  Copyright (c) 2014 nWeave LLC. All rights reserved.
//

#import "DoneViewController.h"
#import "UIViewController+NavigationBar.h"
#import "CaseManager.h"
#import "ShareViewController.h"


@implementation DoneViewController {
    CaseManager* caseManager;
}

@synthesize designNameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPHONE) {
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"DoneViewController"] bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:[[Utility sharedInstance] appendBundleNameToString:@"DoneViewController_iPad"] bundle:nibBundleOrNil];
    }
    
    if (self) {
        self.title = TITLE;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    caseManager = [CaseManager getInstance];
    self.casePreview.image = [caseManager caseImageWithTemplate];
    
    designNameTextField.delegate = self;
    
    [self.submitButton setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"editing_name_screen_confirm_button"]] forState:UIControlStateNormal];
    [self.discardButton setImage:[UIImage imageNamed:[[Utility sharedInstance] appendBundleNameToString:@"editing_name_screen_close_button"]] forState:UIControlStateNormal];
    
    [self setNavigationBarButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (IBAction)submitButtonClicked:(id)sender {
    if (designNameTextField.text.length <= 0) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Empty name!!", nil) message:@"You can't submit empty desing name!!" delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles:nil] show];
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"design name: %@", [userDefaults stringForKey:KEY_DESIGN_NAME]);
        
        [userDefaults setObject:designNameTextField.text forKey:KEY_DESIGN_NAME];
        [userDefaults synchronize];
        
        [designNameTextField resignFirstResponder];
        
        caseManager.caseName = designNameTextField.text;
        
        [self goToShareView];
    }
}

- (void)goToShareView {
    ShareViewController* shareViewController = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:shareViewController animated:YES];
}

- (IBAction)discardButtonClicked:(id)sender {
    designNameTextField.text = @"";
    [designNameTextField resignFirstResponder];
}


#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    NSLog(@"textFieldShouldReturn");
    return YES;
}

-(void)dismissKeyboard {
    [designNameTextField resignFirstResponder];
}

//
//- (void)dealloc {
//    [_discardButton release];
//    [_submitButton release];
//    [super dealloc];
//}
@end
