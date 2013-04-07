//
//  MCAddCommentViewController_MCAddCommentViewControllerSubclass.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 04/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCAddCommentViewController.h"
#import "MCImagePicker.h"
#import "MBProgressHUD.h"

@interface MCAddCommentViewController (ExposingPrivateMethodsToSubclasses)

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong,nonatomic) MCImagePicker *imagePicker;
@property (strong,nonatomic) MBProgressHUD *hud;

- (void)sendMessage;
- (void)prepareForMessageSending;
-(void)cleanupAfterMessageSentSuccessfully;
-(void)cleanupAfterMessageFailedToSend;
-(void)hideKeyboard;
-(void)setupAndShowHUD;
-(void)showImagePicker;
-(void)addSendMessageButton;
-(void)goToPreviousScreen;
@end
