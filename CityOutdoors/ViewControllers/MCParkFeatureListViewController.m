//
//  MCParkFeatureListViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCParkFeatureListViewController.h"
#import "BSModalPickerView.h"

@interface MCParkFeatureListViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *parkMapButton;
@property (strong, nonatomic) BSModalPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *currentCollections;
@property (strong, nonatomic) NSArray *categoryStrings;
@property (strong, nonatomic) NSManagedObjectContext *categoryFetchContext;
- (void)configureAvailableCategories;
- (void)setupUIComponents;
@end

@implementation MCParkFeatureListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	self.title = @"Park Features";

	[self configureAvailableCategories];
	self.pickerView = [[BSModalPickerView alloc] initWithValues:[self categoryStrings]];
	[self setupUIComponents];
	[self refresh];
}

#pragma mark - private

- (void)categoryStringsFromArray:(NSArray*)categoryArray {
	NSMutableArray *categories = [[NSMutableArray alloc] initWithCapacity:0];
	[categories insertObject:@"All" atIndex:0];

	for (MCCollection *c in categoryArray) {
		[categories addObject:c.title];
	}
	_categoryStrings = [NSArray arrayWithArray:categories];
}

- (NSArray*)categoryStrings {

	if (_categoryStrings == nil) {
		[self configureAvailableCategories];
	}
	return _categoryStrings;
}


- (NSInteger)collectionIDForTitle:(NSString*)title {
	if (title == nil) {
		return 0;
	}
	NSInteger colID = 0;
	for (MCCollection *c in _currentCollections) {
		if ([c.title isEqualToString:title]) {
			colID = c.collectionID.integerValue;
			break;
		}
	}
	return colID;
}


#pragma mark - Overridden methods

- (void)loadListElements {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollectionItem entityName]];
	[fetchRequest setPredicate:[self currentPredicate]];
	[fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setFetchBatchSize:30];
	NSSortDescriptor *sortByCollectionTitle = [NSSortDescriptor sortDescriptorWithKey:@"collection.title" ascending:YES];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByCollectionTitle, sortByName]];
    
	NSManagedObjectContext *fetchMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	fetchMOC.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
	
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																		managedObjectContext:fetchMOC
																		  sectionNameKeyPath:@"collection.title"
																				   cacheName:nil];
	NSError *_error;
	if (![self.fetchedResultsController performFetch:&_error]) {
		DLog(@"Unresolved error %@, %@", _error, [_error userInfo]);
	}
}

- (void)refreshFromRemoteData {
	[MCDataUpdater updateCollectionsRecursively];
}

- (void)configureAvailableCategories {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollection entityName]];
	[fetchRequest setPropertiesToFetch:@[@"collectionID", @"title"]];
	[fetchRequest setReturnsDistinctResults:YES];
	NSPredicate *allExceptParks = [NSPredicate predicateWithFormat:@"collectionID != %d",1];
	[fetchRequest setPredicate:allExceptParks];

	NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"collectionID" ascending:YES];
	[fetchRequest setSortDescriptors:@[sortByID]];

	self.categoryFetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	self.categoryFetchContext.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];

	NSError *error = nil;
	NSArray *fetchResults = [self.categoryFetchContext executeFetchRequest:fetchRequest error:&error];
	self.currentCollections = [NSMutableArray arrayWithArray:fetchResults];
	DLog(@"%d categories found :\n%@",[_currentCollections count],_currentCollections);
	for (MCCollection *c in _currentCollections) {
		DLog(@"collectionID = %d title= %@",c.collectionID.integerValue,c.title);
	}
	[self categoryStringsFromArray:_currentCollections];
	DLog(@"Error = %@",error);
}

- (NSPredicate*)currentPredicate {
	NSString *predicateFormat = nil;
	switch (_pickerView.selectedIndex) {
		case 0:
			predicateFormat = @"collection.collectionID != 1";
			break;
		default:
			predicateFormat = [NSString stringWithFormat:@"collection.collectionID == %d",
							   [self collectionIDForTitle:_pickerView.selectedValue]];
			break;
	}
	return [NSPredicate predicateWithFormat:predicateFormat];
}

#pragma mark - Table view data source

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	NSString *sectionName = [sectionInfo name];
    return sectionName;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ParkFeatureCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    /* Configure the cell... */
	MCCollectionItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = item.title;
	NSURL *iconURL = [NSURL URLWithString:item.collection.iconURL];
    [cell.imageView setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"appIcon.png"]];
    return cell;
}

#pragma mark - private methods
- (void)setupUIComponents {
	self.parkMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
														  style:UIBarButtonItemStyleBordered
														 target:self
														 action:@selector(showFilterView)];
	self.navigationItem.rightBarButtonItem = self.parkMapButton;
}

- (void)showFilterView {
	[self.pickerView presentInWindowWithBlock:^(BOOL madeChoice) {
		DLog(@"pickerView madeChoice = %@",madeChoice ? @"YES" : @"NO");
		if (madeChoice) {
			DLog(@"Chose: %@",_pickerView.selectedValue);
			DLog(@"CollectionID = %d",[self collectionIDForTitle:_pickerView.selectedValue]);
			[self refresh];
		}
	}];
}

- (void)showMapView {
	DLog(@"Show Park map");
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *mapViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkMapViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:mapViewController];
}

@end
