//
//  MCContentView.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 14/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCContentView.h"
#import "MCContent.h"
#import "UIImageView+AFNetworking.h"
#import "MCStyling.h"

#define MINIMUM_CONTENT_HEIGHT 100

@interface MCContentView ()
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (strong,nonatomic) MCContent *content;
-(IBAction)contentImagePressed:(id)sender;
@end

@implementation MCContentView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)populateFromContent:(MCContent *)content {
	_content = content;
	_photoButton.enabled = _content.pictureFullURL.length > 0;
	NSString *contentImageURLString = _content.pictureThumbURL;
	NSURL *imageURL = [NSURL URLWithString:contentImageURLString];
	[self.contentImageView setImageWithURL:imageURL
						  placeholderImage:[MCStyling imagePlaceholder]];

	self.contentTextView.text = content.body;
	CGRect textViewFrame = self.contentTextView.frame;
	textViewFrame.size.height = self.contentTextView.contentSize.height;
	self.contentTextView.frame = textViewFrame;
	
	CGRect viewFrame = self.frame;
	CGFloat calculatedContentHeight = CGRectGetMaxY(self.contentTextView.frame)+self.contentTextView.frame.origin.y;
	viewFrame.size.height = MAX(calculatedContentHeight, MINIMUM_CONTENT_HEIGHT);
	self.frame = viewFrame;
}

-(IBAction)contentImagePressed:(id)sender {
	if (_delegate != nil && [_delegate respondsToSelector:@selector(showImageForContentWithID:)]) {
		[_delegate showImageForContentWithID:_content.contentID];
	}
}

@end
