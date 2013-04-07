//
//  MCQuestionView.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 18/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCQuestionView.h"
#import "MCQuestion.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCStyling.h"


@interface MCQuestionView ()
@property (strong,nonatomic) MCQuestion *question;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIView *answerContainerView;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) UIScrollView *parentScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *answerStatusImageView;
-(IBAction)submitAnswer:(id)sender;

@end

@implementation MCQuestionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)populateFromQuestion:(MCQuestion*)question {
	_question = question;
	_questionTextView.font = [MCStyling textFontOfSize:20];
	_questionTextView.text = _question.question;
	CGRect questionRect = _questionTextView.frame;
	questionRect.size.height = MAX(_questionTextView.contentSize.height,40);
	_questionTextView.frame = questionRect;
	[self configureAnswerContainer];
	CGRect answerContainerRect = _answerContainerView.frame;
	answerContainerRect.origin.y = CGRectGetMaxY(_questionTextView.frame);
	_answerContainerView.frame = answerContainerRect;
	CGRect mainFrame = self.frame;
	mainFrame.size.height = CGRectGetMaxY(_answerContainerView.frame);
	self.frame = mainFrame;
}

-(void)setParentScrollView:(UIScrollView*)parentScrollView {
	_parentScrollView = parentScrollView;
}

#pragma mark - private
-(void)submitAnswer:(id)sender {
	DLog(@"Submitting answer: %@",_answerTextField.text);
	[self answerUIComponentsEnabled:NO];
	[[MCCityOutdoorsAPIClient sharedClient] postQuestionWithID:_question.questionID
															 answer:_answerTextField.text
													completionBlock:^(BOOL success, BOOL isCorrectResponse, NSError *error) {
														DLog(@"success=%@ isCorrectResponse=%@ error=%@",
															 success ? @"YES": @"NO",
															 isCorrectResponse ? @"YES": @"NO",
															 error);
														if (success) {
															_question.hasAnswered = @(isCorrectResponse);
															DLog(@"Answer is correct ? %@",isCorrectResponse ? @"YES" : @"NO");
															dispatch_async(dispatch_get_main_queue(), ^{
																[self configureAnswerContainer];
																if (!isCorrectResponse) {
																	[self wrongAnswerSetup];
																}
															});
														} else {
															dispatch_async(dispatch_get_main_queue(), ^{
																[self answerUIComponentsEnabled:YES];
															});
														}
													}];
}

-(void)answerUIComponentsEnabled:(BOOL)enabled {
	_answerButton.enabled = enabled;
	_answerTextField.enabled = enabled;
}
- (void)configureAnswerContainer {
	_answerTextField.delegate = self;
	[MCStyling styleButtonWithCustomBackground:_answerButton];
	_answerStatusImageView.image = nil;
	if (_question.hasAnswered.boolValue) {
		[self correctAnswerSetup];
	}
}

- (void)correctAnswerSetup {
	_answerStatusImageView.image = [UIImage imageNamed:@"checkmark.png"];
	_answerStatusImageView.hidden = NO;
	[self answerUIComponentsEnabled:NO];
}

- (void)wrongAnswerSetup {
	_answerStatusImageView.image = [UIImage imageNamed:@"wrong_X_mark.png"];
	_answerStatusImageView.hidden = NO;
	[self answerUIComponentsEnabled:YES];
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self submitAnswer:nil];
	[textField resignFirstResponder];
	return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {           /* became first responder */
	_answerStatusImageView.image = nil;
	double delayInSeconds = 0.1;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[_parentScrollView scrollRectToVisible:self.frame animated:NO];
	});
}

@end
