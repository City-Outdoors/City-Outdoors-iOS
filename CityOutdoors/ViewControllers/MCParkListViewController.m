//
//  MCParkListViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 18/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCParkListViewController.h"


@interface MCParkListViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *parkMapButton;
@end

@implementation MCParkListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupUIComponents];
	[self refresh];
}


- (void)loadListElements {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollectionItem entityName]];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"collection.collectionID = %d", 1]];
	[fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setFetchBatchSize:30];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByName]];
    
	NSManagedObjectContext *fetchMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	fetchMOC.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
	
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:fetchMOC
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:nil];
	NSError *_error;
	if (![self.fetchedResultsController performFetch:&_error]) {
		DLog(@"Unresolved error %@, %@", _error, [_error userInfo]);
	}

}

- (void)refreshFromRemoteData {
	NSManagedObjectContext *remoteMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	remoteMOC.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
	[MCDataUpdater updateCollectionWithID:@(1) usingManagedObjectContext:remoteMOC];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	NSInteger rows = [sectionInfo numberOfObjects];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ParkCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	MCCollectionItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];

	cell.textLabel.text = item.title;
	NSURL *iconURL = [NSURL URLWithString:item.collection.iconURL];
    [cell.imageView setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"appIcon.png"]];
    return cell;
}

#pragma mark - private methods
- (void)setupUIComponents {
/*
	self.parkMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map"
														   style:UIBarButtonItemStyleBordered
														  target:self
														  action:@selector(showMapView)];
	self.navigationItem.rightBarButtonItem = self.parkMapButton;
 */
}

- (void)showMapView {
	DLog(@"Show Park map");
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *mapViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkMapViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:mapViewController];
}

@end
