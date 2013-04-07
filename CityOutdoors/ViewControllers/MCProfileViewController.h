//
//  MCProfileViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCProfileViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *forgottenPasswordButton;

@end
