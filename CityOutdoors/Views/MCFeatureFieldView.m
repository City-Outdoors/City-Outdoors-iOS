//
//  MCFeatureFieldView.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCFeatureFieldView.h"
#import "MCFeatureField.h"
#import "MCStyling.h"

@interface MCFeatureFieldView ()

@property MCFeatureField *field;
@end

@implementation MCFeatureFieldView

-(void)populateFromFeatureField:(MCFeatureField*)field {
	_field = field;
	[self styleView];
	self.titleLabel.text = _field.title;
	self.valueTextView.text = _field.textValue;
	CGRect textViewFrame = self.valueTextView.frame;
	textViewFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame);
	textViewFrame.size.height = self.valueTextView.contentSize.height;
	self.valueTextView.frame = textViewFrame;
	
	CGRect viewFrame = self.frame;
	viewFrame.size.height = CGRectGetMaxY(self.valueTextView.frame);
	self.frame = viewFrame;
}

-(void)styleView {
	self.titleLabel.textColor = [MCStyling greenTextColor];
	self.valueTextView.textColor = [MCStyling contentTextColor];
}
@end
