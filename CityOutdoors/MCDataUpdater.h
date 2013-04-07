//
//  MCDataUpdater.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 30/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCCollection;
@interface MCDataUpdater : NSObject

+(void)updateCollectionsRecursively;
+(void)updateCollectionsUsingManagedObjectContext:(NSManagedObjectContext *)moc;

+(void)updateFeatureWithID:(NSNumber*)featureID
 usingManagedObjectContext:(NSManagedObjectContext *)moc;

+(void)updateCollectionWithID:(NSNumber*)collectionID
	usingManagedObjectContext:(NSManagedObjectContext *)moc;

+(void)updateFeatureWithID:(NSNumber*)featureID
usingManagedObjectContext:(NSManagedObjectContext *)moc
completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

+(void)getFavouritesUsingManagedObjectContext:(NSManagedObjectContext*)moc
							  completionBlock:(void (^)(BOOL success,NSArray *favourites,NSError *error))completionBlock;

@end
