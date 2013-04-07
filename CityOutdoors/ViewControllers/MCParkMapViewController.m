//
//  MCParkMapViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 17/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCParkMapViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import <CoreData/CoreData.h>
#import "MCCollectionItem.h"
#import "MCCollectionItemMapAnnotation.h"
#import "MCAppDataModel.h"
#import "MCCollection.h"
#import "MCFeature.h"
#import <CoreLocation/CoreLocation.h>
#import "MKAnnotationView+WebCache.h"

@interface MCParkMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (strong, nonatomic) IBOutlet UIButton *addContentButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *parkListButton;
@property (strong, nonatomic) NSManagedObjectContext *pinFetchContext;
@property (strong, nonatomic) NSManagedObjectContext *itemToShowContext;

-(IBAction)showCurrentLocation:(id)sender;
-(void)centerMapOnCurrentLocation;
-(void)centerMapOnCoordinate:(CLLocationCoordinate2D)location;
-(IBAction)addContentButtonPressed;
-(void)populateWithAnnotations;
-(MCCollectionItem*)collectionItemToShow;
@end

@implementation MCParkMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	[self setupUIComponents];
	[self setupMapView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self showCurrentLocation:nil];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Button actions

-(IBAction)showCurrentLocation:(id)sender {
	MCCollectionItem *currentCollectionItem = [self collectionItemToShow];
	DLog(@"item to show = %@\nCollectionItem=%@\nfeature=%@\nCoordinate=%f,%f",
		  self.collectionItemIDToShow.stringValue,
		  currentCollectionItem,
		 currentCollectionItem.feature,
		  currentCollectionItem.feature.coordinate.latitude,
		  currentCollectionItem.feature.coordinate.longitude);
	if ((sender == nil) && (currentCollectionItem != nil)) {
		[self centerMapOnCoordinate:currentCollectionItem.feature.coordinate];
	}else {
		[self centerMapOnCurrentLocation];
	}
}

- (void)addContentButtonPressed {
	UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@""
													delegate:nil
										   cancelButtonTitle:@"Cancel"
									  destructiveButtonTitle:nil
										   otherButtonTitles:@"Add Comment",@"Report an issue", nil];
	[as showFromRect:_addContentButton.frame inView:_mapView animated:YES];
}

- (void)centerMapOnCurrentLocation {
	CLLocationCoordinate2D regionCenter = _mapView.userLocation.location.coordinate ;
	if (CLLocationCoordinate2DIsValid(regionCenter) && regionCenter.latitude != 0 && regionCenter.longitude != 0) {
		DLog(@"Location valid");
		regionCenter = _mapView.userLocation.location.coordinate;
	}else {
		DLog(@"Location invalid");
		regionCenter = CLLocationCoordinate2DMake(55.950563, -3.1986095);
	}
	MKCoordinateRegion mapRegion = _mapView.region;
	mapRegion.span.latitudeDelta = 0.0200;
	mapRegion.span.longitudeDelta = 0.0200;
	mapRegion.center = regionCenter;
	[_mapView setRegion:mapRegion animated:YES];
}

-(void)centerMapOnCoordinate:(CLLocationCoordinate2D)location {
	MKCoordinateRegion currentRegion = self.mapView.region;
	currentRegion.span.latitudeDelta = 0.0175;
	currentRegion.span.longitudeDelta = 0.0175;
	currentRegion.center = location;
	[self.mapView setRegion:currentRegion animated:YES];
}

#pragma mark -
#pragma mark MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
    /* if it's the user location, just return nil. */
    if ([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
	static NSString *viewIdentifier = @"annotationView";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
    }
	pinView.canShowCallout = YES;
	pinView.animatesDrop = NO;
	pinView.rightCalloutAccessoryView = nil;
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton addTarget:annotation
					action:@selector(showDetailScreen)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
	pinView.annotation = annotation;
	MCCollectionItem *item = [((MCCollectionItemMapAnnotation*)annotation) item];
	NSURL *iconURL = [NSURL URLWithString:item.collection.iconURL];
	if (iconURL != nil) {
		[pinView setImageWithURL:iconURL];
	}

	return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	DLog(@"Selected annotation %@",view.annotation.title);
}


#pragma mark - Private methods
- (NSManagedObjectContext*)currentContext {
	if (_pinFetchContext == nil) {
		_pinFetchContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		_pinFetchContext.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
		[_pinFetchContext setMergePolicy:NSOverwriteMergePolicy];
	}
	return _pinFetchContext;
}

- (NSManagedObjectContext*)singleItemContext {
	if (_itemToShowContext == nil) {
		_itemToShowContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		_itemToShowContext.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
		[_itemToShowContext setMergePolicy:NSOverwriteMergePolicy];
	}
	return _itemToShowContext;
}


- (MCCollectionItem*)collectionItemToShow {
	if (self.collectionItemIDToShow == nil) {
		return nil;
	}

	MCCollectionItem *itemToShow = [MCCollectionItem collectionItemWithId:self.collectionItemIDToShow.integerValue usingManagedObjectContext:[self singleItemContext]];
	DLog(@"item to show = %@\nCoordinate=%f,%f",
		  itemToShow,
		  itemToShow.feature.coordinate.latitude,
		  itemToShow.feature.coordinate.longitude);

	return itemToShow;
}
- (void)populateWithAnnotations {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
		NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollectionItem entityName]];
		NSError *error = nil;
		NSArray *results = [[self currentContext] executeFetchRequest:fetchRequest error:&error];
		if (error) {
			DLog(@"map ERROR: %@ %@", [error localizedDescription], [error userInfo]);
		}
		DLog(@"will load %d annotations",results.count);
		NSMutableArray *mapAnnotations = [NSMutableArray arrayWithCapacity:results.count];
		for (MCCollectionItem *item in results) {
			MCCollectionItemMapAnnotation *mapAnnotation = [[MCCollectionItemMapAnnotation alloc] initWithCollectionItem:item andParentViewController:self];
			[mapAnnotations addObject:mapAnnotation];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[self removeAllAnnotations];
			[self.mapView addAnnotations:mapAnnotations];
		});
	});
}

-(void)removeAllAnnotations{
	id userAnnotation = self.mapView.userLocation;
	
	NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.mapView.annotations];
	[annotations removeObject:userAnnotation];
	
	[self.mapView removeAnnotations:annotations];
}

- (void)setupMapView{
	_mapView.delegate = self;
	_mapView.showsUserLocation = YES;
/*
 _mapView.userTrackingMode = MKUserTrackingModeNone;
*/
	
	if ([self shouldShowAllAnnotations]) {
		[self populateWithAnnotations];
	}
	[self showCurrentLocation:nil];
	[self addAnnotationForItemToShow];

}

- (BOOL)shouldShowAllAnnotations {
	return [self collectionItemToShow] == nil;
}

- (void)addAnnotationForItemToShow {
	if ([self collectionItemToShow] != nil) {
		MCCollectionItemMapAnnotation *mapAnnotation = [[MCCollectionItemMapAnnotation alloc]
														initWithCollectionItem:[self collectionItemToShow]
														andParentViewController:self];
		[self removeAllAnnotations];
		[self.mapView addAnnotation:mapAnnotation];
	}
}
- (void)setupUIComponents {
/*
	self.parkListButton = [[UIBarButtonItem alloc] initWithTitle:@"List"
													  style:UIBarButtonItemStyleBordered
													 target:self
													 action:@selector(showListView)];
	self.navigationItem.rightBarButtonItem = self.parkListButton;
 */
}

- (void)showListView {
	DLog(@"Show Park list");
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *listViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkListViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:listViewController];
}

@end
