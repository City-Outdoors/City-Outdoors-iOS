//
//  MCMenuViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MCMenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>

@property (weak,nonatomic) IBOutlet UITableView *tableView;
-(IBAction)showMapScreen:(id)sender;
-(IBAction)showParksScreen:(id)sender;
-(IBAction)showParkFeaturesScreen:(id)sender;
-(IBAction)showAccountPage:(id)sender;

@end
