//
//  MCFeatureDetailViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 10/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import "MCContentView.h"

@class MCCollectionItem;
@class MCFeature;
@interface MCFeatureDetailViewController : UIViewController <MWPhotoBrowserDelegate,MCContentImageInteractionProtocol>
@property (strong, nonatomic) MCCollectionItem *collectionItem;
@property (strong, nonatomic) NSManagedObjectContext *managedContext;
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *featureImageView;
@property (weak, nonatomic) IBOutlet UIButton *showOnMapButton;
@property (weak, nonatomic) IBOutlet UIButton *showPhotoBrowserButton;
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;
@property (weak, nonatomic) IBOutlet UIButton *childFeaturesButton;

-(IBAction)showOnMap:(id)sender;
-(IBAction)checkIn:(id)sender;
-(IBAction)comment:(id)sender;
-(IBAction)favouriteFeature:(id)sender;
-(IBAction)reportProblem:(id)sender;
-(IBAction)showPhotoBrowser:(id)sender;
-(IBAction)showDirections:(id)sender;
-(IBAction)showListOfChildFeatures:(id)sender;
@end
