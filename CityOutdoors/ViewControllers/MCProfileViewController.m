//
//  MCProfileViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCProfileViewController.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCAlertHelper.h"
#import "MCStyling.h"
#import "MBProgressHUD.h"
#import "MCCityOutdoorsAPIClient.h"

@interface MCProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) MBProgressHUD *hud;
-(IBAction)logIn:(id)sender;
-(IBAction)createAccount:(id)sender;
-(IBAction)forgottenPassword:(id)sender;

@end

@implementation MCProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self styleAllButtons];
	self.emailTextField.delegate = self;
	self.passwordTextField.delegate = self;
	self.title = @"Account";
	[self addCloseButton];
}


- (void)viewDidUnload {
	[self setLoginButton:nil];
	[self setCreateAccountButton:nil];
	[self setForgottenPasswordButton:nil];
	[self setEmailTextField:nil];
	[self setPasswordTextField:nil];
	[super viewDidUnload];
}

#pragma mark - button actions

-(IBAction)logIn:(id)sender {
	[self.view endEditing:YES];
	[self setupAndShowHUD];
	[[MCCityOutdoorsAPIClient sharedClient] loginWithEmail:_emailTextField.text
												andPassword:_passwordTextField.text completion:^(BOOL success, NSError *error) {
													if (success) {
														[self cleanupAfterSuccessfulLogin];
													}else {
														[self cleanupAfterFailedLogin];
													}
												}];

}

-(IBAction)createAccount:(id)sender {
	NSURL *createAccountURL = [[MCCityOutdoorsAPIClient sharedClient] createAccountURL];
	[self openURLInBrowser:createAccountURL];
}

-(IBAction)forgottenPassword:(id)sender {
	NSURL *forgottenPasswordURL = [[MCCityOutdoorsAPIClient sharedClient] forgottenPasswordURL];
	[self openURLInBrowser:forgottenPasswordURL];
}
#pragma mark - UITextFieldDelegate 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == _emailTextField) {
		[_emailTextField resignFirstResponder];
		[_passwordTextField becomeFirstResponder];
	}else {
		[_passwordTextField resignFirstResponder];
		[self logIn:nil];
	}
	return NO;
}


#pragma mark - private

-(void)addCloseButton {
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeScreen)];
	self.navigationItem.leftBarButtonItem = closeButton;
}

-(void)closeScreen {
	[self dismissModalViewControllerAnimated:YES];
}

-(void)openURLInBrowser:(NSURL*)urlToOpen {
	[[UIApplication sharedApplication] openURL:urlToOpen];
}

-(void)styleAllButtons {
	[MCStyling styleButtonWithCustomBackground:_loginButton];
	[MCStyling styleButtonWithCustomBackground:_createAccountButton];
	[MCStyling styleButtonWithCustomBackground:_forgottenPasswordButton];
}
	 
-(void)setupAndShowHUD {
	if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithWindow:self.view.window];
    }
    
    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:@"Logging in..."];
	_hud.dimBackground = YES;
    [self.view.window addSubview:_hud];
	[_hud show:YES];
	
}

-(void)cleanupAfterSuccessfulLogin {
	[_hud setLabelText:@"Logged in."];
	[_hud hide:YES afterDelay:1.25];
	int64_t delayInSeconds = 0.25;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self closeScreen];
	});
	
}

-(void)cleanupAfterFailedLogin {
	[_hud setLabelText:@"Login failed."];
	[_hud hide:YES afterDelay:3];

}

@end
