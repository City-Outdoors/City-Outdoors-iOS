//
//  MCCollectionItemMapAnnotation.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class MCCollectionItem;

@interface MCCollectionItemMapAnnotation : NSObject <MKAnnotation>
@property (strong,nonatomic) MCCollectionItem *item;
@property (assign) UIViewController *parentController;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
// Title and subtitle for use by selection UI.
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

-(id)initWithCollectionItem:(MCCollectionItem*)item andParentViewController:(UIViewController*)parentController;
-(void)showDetailScreen;
@end
