//
//  MCAddCommentViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 09/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCAddCommentViewController.h"
#import "MCImagePicker.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MBProgressHUD.h"
#import "UIImage+Resize.h"
#import "MCCredentialStore.h"

#define PORTRAIT_IMAGE_SIZE CGSizeMake(600,800)
#define LANDSCAPE_IMAGE_SIZE CGSizeMake(800,600)

@interface MCAddCommentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong,nonatomic) MCImagePicker *imagePicker;
@property MBProgressHUD *hud;

-(void)sendMessage;
@end

@implementation MCAddCommentViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addSendMessageButton];
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	self.nameTextField.text = [credentials name];
}

- (void)viewDidUnload {
	[self setCommentTextView:nil];
	[self setPhotoImageView:nil];
	[self setNameTextField:nil];
	[super viewDidUnload];
}

#pragma mark - Table view delegate

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"photoCell"]) {
		return indexPath;
    }
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"photoCell"]) {
        [self showImagePicker];
    }
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self hideKeyboard];
	[self.commentTextView becomeFirstResponder];
	return NO;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
	[self hideKeyboard];
    return NO;
}
#pragma mark - Button Actions

-(void)sendMessage {
    [self prepareForMessageSending];;
	MCCityOutdoorsAPIClient *apiClient = [MCCityOutdoorsAPIClient sharedClient];
	[apiClient postComment:self.commentTextView.text
			  forFeatureID:self.featureID
					  name:self.nameTextField.text
					 photo:self.photoImageView.image
				completion:^(BOOL success, NSError *error) {
					if (success) {
						[self cleanupAfterMessageSentSuccessfully];
					} else {
						[self cleanupAfterMessageFailedToSend];
					}
					DLog(@"Finished posting comment with success = %@",success ? @"YES": @"NO");
				}];
}

- (void)prepareForMessageSending {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self hideKeyboard];
    [self setupAndShowHUD];
    DLog(@"Showing HUD");
}

-(void)goToPreviousScreen {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private methods

-(void)cleanupAfterMessageSentSuccessfully {
	self.navigationItem.rightBarButtonItem.enabled = YES;
	[_hud setLabelText:@"Message sent."];
	[_hud hide:YES afterDelay:1];
	int64_t delayInSeconds = 1.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self goToPreviousScreen];
	});
}

-(void)cleanupAfterMessageFailedToSend {
	self.navigationItem.rightBarButtonItem.enabled = YES;
	[_hud setLabelText:@"Couldn't send message."];
	[_hud hide:YES afterDelay:3];

}

-(void)hideKeyboard {
	[self setEditing:NO];
	[_nameTextField resignFirstResponder];
	[_commentTextView resignFirstResponder];
}

-(void)setupAndShowHUD {
	if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    
    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:@"Sending message..."];
	_hud.dimBackground = YES;
    [self.view addSubview:_hud];
	[_hud show:YES];

}

-(void)showImagePicker {
	if (!_imagePicker) {
        self.imagePicker = [[MCImagePicker alloc] init];
        __weak MCAddCommentViewController *weakSelf = self;
		[_imagePicker setImagePickerCompletionBlock:^(UIImage *chosenImage) {
			DLog(@"Original image of scale %f with size %@",chosenImage.scale, NSStringFromCGSize(chosenImage.size));
			CGSize originalImageSize = chosenImage.size;
			
			CGSize resizedImageSize;
			if (originalImageSize.width < originalImageSize.height) {
				resizedImageSize = PORTRAIT_IMAGE_SIZE;
			}else {
				resizedImageSize = LANDSCAPE_IMAGE_SIZE;
			}
			UIImage *resizedImage = [chosenImage resizedImageToFitInSize:resizedImageSize scaleIfSmaller:NO];
			DLog(@"Resized image of scale %f with size %@",resizedImage.scale, NSStringFromCGSize(resizedImage.size));
			weakSelf.photoImageView.image = resizedImage;
		}];
	}
	[self hideKeyboard];
	[_imagePicker presentFromController:self];
}

-(void)addSendMessageButton {
	UIBarButtonItem *saveComment = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                 target:self action:@selector(sendMessage)];
	[self.navigationItem setRightBarButtonItem:saveComment];
}

@end
