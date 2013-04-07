//
//  MCParkMapViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 17/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class MCCollectionItem;
@interface MCParkMapViewController : UIViewController <MKMapViewDelegate>
@property NSNumber *collectionItemIDToShow;
@end
