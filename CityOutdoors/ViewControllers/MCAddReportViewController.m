//
//  MCAddReportViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 04/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCAddReportViewController.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCCredentialStore.h"

@interface MCAddReportViewController ()

@end

@implementation MCAddReportViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	self.emailTextField.text = [credentials email];

}

- (void)viewDidUnload {
	[self setEmailTextField:nil];
	[super viewDidUnload];
}

-(void)hideKeyboard {
	[super hideKeyboard];
	[_emailTextField resignFirstResponder];
}

-(void)sendMessage {
	[self prepareForMessageSending];;
	MCCityOutdoorsAPIClient *apiClient = [MCCityOutdoorsAPIClient sharedClient];
	[apiClient postReport:self.commentTextView.text
			 forFeatureID:self.featureID
					 name:self.nameTextField.text
					email:self.emailTextField.text
					photo:self.photoImageView.image
			   completion:^(BOOL success, NSError *error) {
				   if (success) {
					   [self cleanupAfterMessageSentSuccessfully];
				   } else {
					   [self cleanupAfterMessageFailedToSend];
				   }
				   DLog(@"Finished posting message with success = %@",success ? @"YES": @"NO");

			   }];
}

@end
