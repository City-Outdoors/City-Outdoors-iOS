//
//  MCCollectionItemMapAnnotation.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCCollectionItemMapAnnotation.h"
#import "MCCollection.h"
#import "MCCollectionItem.h"
#import "MCFeature.h"
#import "MCFeatureDetailViewController.h"

@implementation MCCollectionItemMapAnnotation

-(id)initWithCollectionItem:(MCCollectionItem*)collectionItem andParentViewController:(UIViewController*)_parentVC {
	self = [super init];
    if (self) {
        _item = collectionItem;
		CLLocationCoordinate2D theCoordinate;
		theCoordinate.latitude = _item.feature.latitude.doubleValue;
		theCoordinate.longitude = _item.feature.longitude.doubleValue;
//		DLog(@"Annotation with latitude =%f longitude = %f",theCoordinate.latitude,theCoordinate.longitude);
		_coordinate = theCoordinate;
        _parentController = _parentVC;
    }
    return self;
}

-(NSString*)title {
	return [_item.title copy];
}

-(NSString*)subtitle {
	return [_item.collection.title copy];
}

-(void)showDetailScreen {
	DLog(@"Showing detail screen for %@",_item);
	UIStoryboard *featureStoryboard = [UIStoryboard storyboardWithName:@"Feature" bundle:nil];
	MCFeatureDetailViewController *featureDetailVC = [featureStoryboard instantiateViewControllerWithIdentifier:@"MCFeatureDetailViewController"];
	
	featureDetailVC.collectionItem = _item;
	featureDetailVC.managedContext = _item.managedObjectContext;
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @"Back"
								   style: UIBarButtonItemStyleBordered
								   target: nil action: nil];
	[self.parentController.navigationItem setBackBarButtonItem:backButton];

	[self.parentController.navigationController pushViewController:featureDetailVC animated:YES];

}
@end
