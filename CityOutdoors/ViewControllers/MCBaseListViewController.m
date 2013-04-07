//
//  MCBaseListViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCBaseListViewController.h"
#import "MCFeatureDetailViewController.h"

@interface MCBaseListViewController ()
@end

@implementation MCBaseListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @"Back"
								   style: UIBarButtonItemStyleBordered
								   target: nil action: nil];
	[self.navigationItem setBackBarButtonItem:backButton];

}
#pragma mark - Methods to be overridden in subclasses

-(void)loadListElements {
	
}

- (void)refresh {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
				   ^{
					   [self loadListElements];
					   dispatch_async(dispatch_get_main_queue(),
									  ^{
/*
										  [self.pullToRefreshView finishLoading];
*/
										  [self.tableView reloadData];
									  });
				   });
}

- (void)refreshFromRemoteData {
	
}

- (void)contextDidSave:(NSNotification *)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSManagedObjectContext *mergeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		mergeContext.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
		[mergeContext setMergePolicy:NSOverwriteMergePolicy];
        [mergeContext mergeChangesFromContextDidSaveNotification:notification];
		
        [self refresh];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	NSInteger rows = [sectionInfo numberOfObjects];
    return rows;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIStoryboard *featureStoryboard = [UIStoryboard storyboardWithName:@"Feature" bundle:nil];
	MCFeatureDetailViewController *featureDetailVC = [featureStoryboard instantiateViewControllerWithIdentifier:@"MCFeatureDetailViewController"];
	
	MCCollectionItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
	featureDetailVC.collectionItem = item;
	featureDetailVC.managedContext = item.managedObjectContext;
	[self.navigationController pushViewController:featureDetailVC animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end
