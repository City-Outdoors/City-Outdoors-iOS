//
//  MCBaseListViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MCCollectionItem.h"
#import "MCCollection.h"
#import "MCFeature.h"
#import "UIImageView+AFNetworking.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "MCAppDataModel.h"
#import "MCDataUpdater.h"


@interface MCBaseListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) SSPullToRefreshView *pullToRefreshView;

-(void)loadListElements;
-(void)refresh;
-(void)refreshFromRemoteData;
- (void)contextDidSave:(NSNotification *)notification;
@end
