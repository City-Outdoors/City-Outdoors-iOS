//
//  MCQuestionView.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 18/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCQuestion;
@interface MCQuestionView : UIView <UITextFieldDelegate>

-(void)populateFromQuestion:(MCQuestion*)question;
-(void)setParentScrollView:(UIScrollView*)parentScrollView;
@end
