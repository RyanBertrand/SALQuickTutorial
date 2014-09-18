//
//  SALViewController.m
//  SALQuickTutorialExample
//
//  Created by Natan Rolnik on 8/12/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALViewController.h"
#import "SALQuickTutorialViewController.h"
#import <MZFormSheetController/MZFormSheetController.h>

static NSString *const SALProvidedBySAQuickTutorialKey = @"SALProvidedBySAQuickTutorialKey";

@interface SALViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITextField *dismissTextField;
@property (weak, nonatomic) IBOutlet UITextField *uniqueKeyTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *completionSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *dismissSegmentedControl;

- (IBAction)showQuickTutorial:(id)sender;

- (IBAction)showHardCodedTutorial:(id)sender;

@end

@implementation SALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.titleTextField becomeFirstResponder];
}

- (IBAction)showQuickTutorial:(id)sender
{
    if (![self validateTextFields]) {
        [[[UIAlertView alloc] initWithTitle:@"All text fields need to be filled" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];

        return;
    }
    
    [self showIfNeededForKey:self.uniqueKeyTextField.text title:self.titleTextField.text message:self.messageTextField.text image:[UIImage imageNamed:@"QuickTutorialExampleImage"] dismiss:[self.dismissTextField text]];
}

- (IBAction)showHardCodedTutorial:(id)sender
{
    [self showIfNeededForKey:SALProvidedBySAQuickTutorialKey title:@"SALQuickTutorialViewController" message:@"Provided by the Seeking Alpha iOS team. Enjoy! Pull requests are welcome" image:[UIImage imageNamed:@"QuickTutorialExampleImage"] dismiss:nil];
}

- (void)showIfNeededForKey:(NSString *)uniqueKey title:(NSString *)title message:(NSString *)message image:(UIImage *)image dismiss:(NSString *)dismiss
{
    [self.view endEditing:YES];
    
    BOOL needsToShow;
    
    if (self.dismissSegmentedControl.selectedSegmentIndex == 0 && self.completionSegmentedControl.selectedSegmentIndex == 0) {
        //if you want to enable tapping on background, just use the convenience method
        needsToShow = [SALQuickTutorialViewController showIfNeededForKey:uniqueKey title:title message:message image:image];
    }
    else {
        //if you want more customization, like completion block, transition, or setting to dismiss with the button, do it "manually"
        needsToShow = [SALQuickTutorialViewController needsToShowForKey:uniqueKey];
        if (needsToShow) {
            SALQuickTutorialViewController *quickTutorialViewController = [[SALQuickTutorialViewController alloc] initWithKey:uniqueKey title:title message:message image:image];
            
            if ([dismiss length])
            {
                quickTutorialViewController = [[SALQuickTutorialViewController alloc] initWithKey:uniqueKey title:title message:message image:image dismiss:dismiss];
            }
            
            if (self.dismissSegmentedControl.selectedSegmentIndex == 1) {
                quickTutorialViewController.dismissesWithButton = YES;
            }
            
            if (self.completionSegmentedControl.selectedSegmentIndex == 1) {
                [quickTutorialViewController setDidDismissCompletionHandler:^{
                    [[[UIAlertView alloc] initWithTitle:@"SALQuickTutorialViewController supports completion block" message:[NSString stringWithFormat:@"Quick tutorial with key %@ was dismissed", uniqueKey] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                }];
            }
            
            [quickTutorialViewController show];
        }
    }
    
    if (!needsToShow) {
        [self alreadyShownWithUniqueKey:SALProvidedBySAQuickTutorialKey];
    }
}

- (void)alreadyShownWithUniqueKey:(NSString *)uniqueKey
{
    [[[UIAlertView alloc] initWithTitle:@"SALQuickTutorialViewController shows only once per key!" message:[NSString stringWithFormat:@"The key %@ was already used before", uniqueKey] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

- (BOOL)validateTextFields
{
    for (UITextField *textField in @[self.titleTextField, self.uniqueKeyTextField]) {
        if ([textField.text length] == 0) {
            return NO;
        }
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

@end
