//
//  MCImagePicker.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 14/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCImagePicker.h"

typedef void (^MCPickerCompletionBlock) (UIImage *image);
typedef void (^MCPickerCancelBlock) (void);

@interface MCImagePicker () <UIActionSheetDelegate>

@property (nonatomic, copy) MCPickerCompletionBlock completionBlock;
@property (nonatomic, copy) MCPickerCancelBlock cancelBlock;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (weak,nonatomic) UIViewController *parentViewController;

- (void)presentFromController:(UIViewController *)aController withSourceType:(UIImagePickerControllerSourceType)sourceType;
@end

@implementation MCImagePicker

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.imagePicker = [[UIImagePickerController alloc] init];
		self.imagePicker.delegate = self;
    }
    return self;
}

#pragma mark - Public methods

- (void)setImagePickerCompletionBlock:(void (^)(UIImage *chosenImage))block {
	self.completionBlock = block;
}

- (void)setImagePickerCancelBlock:(void (^)(void))block {
	self.cancelBlock = block;
}

- (void)presentFromController:(UIViewController *)aController {
	self.parentViewController = aController;
	UIActionSheet *imageSources = [self actionSheetWithAvailableOptions];
	[imageSources showInView:self.parentViewController.view];
}

#pragma mark - UIImagePickerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
    
    UIImage *capturedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (capturedImage && self.completionBlock) {
        self.completionBlock(capturedImage);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
	
	if (self.cancelBlock) {
		self.cancelBlock();
	}
}

#pragma mark - Private methods

-(UIActionSheet *)actionSheetWithAvailableOptions {
	UIActionSheet *actionSheet = nil;
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Camera", nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", nil];
    }
	return actionSheet;
}

- (void)presentFromController:(UIViewController *)aController withSourceType:(UIImagePickerControllerSourceType)sourceType {
    _imagePicker.sourceType = sourceType;
    [aController presentModalViewController:_imagePicker animated:YES];
	
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self presentFromController:self.parentViewController withSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self presentFromController:self.parentViewController withSourceType:UIImagePickerControllerSourceTypeCamera];
            }
            break;
        default:
            break;
    }
}

@end
