//
//  MCAddCommentViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 09/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCAddCommentViewController : UITableViewController <UITextFieldDelegate,UITextViewDelegate>
@property (strong,nonatomic) NSNumber *featureID;
@end
