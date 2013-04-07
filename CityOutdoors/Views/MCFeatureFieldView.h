//
//  MCFeatureFieldView.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCFeatureField;
@interface MCFeatureFieldView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *valueTextView;

-(void)populateFromFeatureField:(MCFeatureField*)field;
@end
